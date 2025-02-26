import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;

class InteractiveImageViewer extends StatefulWidget {
  /// The image to display
  final ImageProvider imageProvider;

  /// Optional title to display in the app bar
  final String? title;

  /// Optional callback when the close button is pressed
  final VoidCallback? onClose;

  /// Background color for the viewer
  final Color? backgroundColor;

  /// Whether to allow sharing the image
  final bool allowSharing;

  /// Optional callback to run after a successful share
  final VoidCallback? onShareComplete;

  /// Optional custom share subject (for email sharing)
  final String? shareSubject;

  /// Optional custom share text
  final String? shareText;

  /// Optional original image URL or path for direct sharing
  final String? imageSource;

  /// Optional caption to share with the image
  final String? imageCaption;

  const InteractiveImageViewer({
    super.key,
    required this.imageProvider,
    this.title,
    this.onClose,
    this.backgroundColor,
    this.allowSharing = true,
    this.onShareComplete,
    this.shareSubject,
    this.shareText,
    this.imageSource,
    this.imageCaption,
  });

  /// Helper method to easily show the viewer as a modal
  static Future<void> show({
    required BuildContext context,
    required ImageProvider imageProvider,
    String? title,
    Color? backgroundColor,
    bool allowSharing = true,
    VoidCallback? onShareComplete,
    String? shareSubject,
    String? shareText,
    String? imageSource,
    String? imageCaption,
  }) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => InteractiveImageViewer(
          imageProvider: imageProvider,
          title: title,
          backgroundColor: backgroundColor ?? Colors.black,
          onClose: () => Navigator.of(context).pop(),
          allowSharing: allowSharing,
          onShareComplete: onShareComplete,
          shareSubject: shareSubject,
          shareText: shareText,
          imageSource: imageSource,
          imageCaption: imageCaption,
        ),
      ),
    );
  }

  @override
  State<InteractiveImageViewer> createState() => _InteractiveImageViewerState();
}

class _InteractiveImageViewerState extends State<InteractiveImageViewer>
    with SingleTickerProviderStateMixin {
  late TransformationController _transformationController;
  late AnimationController _animationController;
  Animation<Matrix4>? _animation;
  final double _minScale = 0.5;
  final double _maxScale = 4.0;
  double _rotation = 0;
  bool _isSharing = false;
  final GlobalKey _imageKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _transformationController = TransformationController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..addListener(() {
        if (_animation != null) {
          _transformationController.value = _animation!.value;
        }
      });
  }

  @override
  void dispose() {
    _transformationController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _handleDoubleTapDown(TapDownDetails details) {
    if (_transformationController.value != Matrix4.identity()) {
      _resetAnimation();
    } else {
      _zoomAnimation(details.localPosition, 2.0);
    }
  }

  void _resetAnimation() {
    _animation = Matrix4Tween(
      begin: _transformationController.value,
      end: Matrix4.identity(),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _animationController.forward(from: 0);
  }

  void _zoomAnimation(Offset position, double scale) {
    final parameterMatrix = Matrix4.identity()
      ..translate(position.dx, position.dy)
      ..scale(scale)
      ..translate(-position.dx, -position.dy);

    _animation = Matrix4Tween(
      begin: _transformationController.value,
      end: parameterMatrix,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _animationController.forward(from: 0);
  }

  void _rotateRight() {
    setState(() {
      _rotation += pi / 2;
    });
  }

  void _rotateLeft() {
    setState(() {
      _rotation -= pi / 2;
    });
  }

  // Share the image
  Future<void> _shareImage() async {
    if (_isSharing) return;

    setState(() {
      _isSharing = true;
    });

    try {
      // If we have a direct image source URL/path, we could use it directly
      if (widget.imageSource != null) {
        await _shareViaSource();
      } else {
        // Otherwise, capture the current view as an image
        await _shareViaScreenCapture();
      }

      if (widget.onShareComplete != null) {
        widget.onShareComplete!();
      }
    } catch (e) {
      // Show error message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to share: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSharing = false;
        });
      }
    }
  }

  // Share using the direct image source
  Future<void> _shareViaSource() async {
    // Reset any transformations to capture the original image
    final oldTransform = _transformationController.value;
    final oldRotation = _rotation;

    try {
      // For network images
      if (widget.imageSource!.startsWith('http')) {
        final response = await http.get(Uri.parse(widget.imageSource!));
        final tempDir = await getTemporaryDirectory();
        final file = File('${tempDir.path}/share_image.jpg');
        await file.writeAsBytes(response.bodyBytes);

        await Share.shareXFiles(
          [XFile(file.path)],
          text: widget.imageCaption ?? widget.shareText,
          subject: widget.shareSubject,
        );
      }
      // For local files
      else if (widget.imageSource!.startsWith('/')) {
        await Share.shareXFiles(
          [XFile(widget.imageSource!)],
          text: widget.imageCaption ?? widget.shareText,
          subject: widget.shareSubject,
        );
      }
    } finally {
      // Restore the previous transformations
      if (mounted) {
        setState(() {
          _transformationController.value = oldTransform;
          _rotation = oldRotation;
        });
      }
    }
  }

  // Capture screen and share
  Future<void> _shareViaScreenCapture() async {
    // Reset any transformations to capture the clean image
    final oldTransform = _transformationController.value;
    final oldRotation = _rotation;

    try {
      setState(() {
        _transformationController.value = Matrix4.identity();
        _rotation = 0;
      });

      // Wait for the UI to update
      await Future.delayed(const Duration(milliseconds: 300));

      // Capture the image
      final RenderRepaintBoundary boundary =
          _imageKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      final ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData != null) {
        final tempDir = await getTemporaryDirectory();
        final file = File('${tempDir.path}/share_image.png');
        await file.writeAsBytes(byteData.buffer.asUint8List());

        await Share.shareXFiles(
          [XFile(file.path)],
          text: widget.imageCaption ?? widget.shareText,
          subject: widget.shareSubject,
        );
      }
    } finally {
      // Restore the previous transformations
      if (mounted) {
        setState(() {
          _transformationController.value = oldTransform;
          _rotation = oldRotation;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor ?? Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.4),
        elevation: 0,
        title: widget.title != null
            ? Text(
                widget.title!,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              )
            : null,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: widget.onClose,
          tooltip: 'Close',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.rotate_left, color: Colors.white),
            onPressed: _rotateLeft,
            tooltip: 'Rotate left',
          ),
          IconButton(
            icon: const Icon(Icons.rotate_right, color: Colors.white),
            onPressed: _rotateRight,
            tooltip: 'Rotate right',
          ),
          if (widget.allowSharing)
            IconButton(
              icon: _isSharing
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Icon(Icons.share, color: Colors.white),
              onPressed: _isSharing ? null : _shareImage,
              tooltip: 'Share image',
            ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Main image viewer
          Center(
            child: GestureDetector(
              onDoubleTapDown: _handleDoubleTapDown,
              child: RepaintBoundary(
                key: _imageKey,
                child: InteractiveViewer(
                  transformationController: _transformationController,
                  minScale: _minScale,
                  maxScale: _maxScale,
                  clipBehavior: Clip.none,
                  child: Transform.rotate(
                    angle: _rotation,
                    child: Image(image: widget.imageProvider),
                  ),
                ),
              ),
            ),
          ),

          // Gesture hint overlay (shows briefly)
          _GestureHintOverlay(),

          // Share button overlay (if sharing is allowed)
          if (widget.allowSharing && !_isSharing)
            Positioned(
              bottom: 24,
              right: 24,
              child: FloatingActionButton(
                onPressed: _shareImage,
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                elevation: 4,
                tooltip: 'Share image',
                child: const Icon(Icons.share),
              ),
            ),

          // Loading overlay when sharing
          if (_isSharing)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(color: Colors.white),
                    SizedBox(height: 16),
                    Text(
                      'Preparing to share...',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// A widget that shows gesture hints and fades out after a delay
class _GestureHintOverlay extends StatefulWidget {
  @override
  State<_GestureHintOverlay> createState() => _GestureHintOverlayState();
}

class _GestureHintOverlayState extends State<_GestureHintOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _animation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    // Start the animation after a delay
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Container(
        color: Colors.black.withOpacity(0.5),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.touch_app,
                  color: Colors.white,
                  size: 44,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Double tap to zoom',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Pinch to zoom in and out',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// // Basic usage
// InteractiveImageViewer.show(
//   context: context,
//   imageProvider: NetworkImage('https://example.com/image.jpg'),
//   title: 'Profile Photo',
// );

// // With sharing features
// InteractiveImageViewer.show(
//   context: context,
//   imageProvider: FileImage(myImageFile),
//   title: 'Profile Photo',
//   allowSharing: true,
//   imageSource: myImageFile.path,  // For direct sharing
//   imageCaption: 'My profile photo',
//   onShareComplete: () {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Image shared successfully!')),
//     );
//   },
// );

// // Custom styling
// InteractiveImageViewer.show(
//   context: context,
//   imageProvider: NetworkImage('https://example.com/image.jpg'),
//   title: 'View Image',
//   backgroundColor: Colors.grey[900],
//   shareSubject: 'Check out this image',
//   shareText: 'I found this amazing image!',
// );
