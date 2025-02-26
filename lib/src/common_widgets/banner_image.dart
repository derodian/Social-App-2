import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:social_app_2/src/common_widgets/interactive_image_view.dart';

// class BannerImage extends StatelessWidget {
//   final String? imageUrl;
//   final File? imageFile;
//   final double height;
//   final bool isLoading;
//   final bool isInteractive;
//   final Color? backgroundColor;
//   final String? placeholderAsset;

//   const BannerImage({
//     super.key,
//     this.imageUrl,
//     this.imageFile,
//     this.height = 200,
//     this.isLoading = false,
//     this.isInteractive = false,
//     this.backgroundColor,
//     this.placeholderAsset,
//   });

//   void _showFullScreenImage(BuildContext context, ImageProvider imageProvider) {
//     InteractiveImageViewer.show(
//       context: context,
//       imageProvider: imageProvider,
//       title: 'Banner Photo',
//       backgroundColor: Colors.black,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       height: height,
//       decoration: BoxDecoration(
//         color: backgroundColor ??
//             Theme.of(context).colorScheme.surfaceContainerHighest,
//       ),
//       child: isLoading
//           ? const Center(
//               child: CircularProgressIndicator(),
//             )
//           : _buildImage(context),
//     );
//   }

//   Widget _buildImage(BuildContext context) {
//     // If there's a file image
//     if (imageFile != null) {
//       final imageProvider = FileImage(imageFile!);
//       return isInteractive
//           ? GestureDetector(
//               onTap: () => _showFullScreenImage(context, imageProvider),
//               child: Image(
//                 image: imageProvider,
//                 fit: BoxFit.cover,
//                 width: double.infinity,
//                 height: double.infinity,
//                 errorBuilder: (context, error, stackTrace) =>
//                     _buildErrorWidget(context),
//               ),
//             )
//           : Image(
//               image: imageProvider,
//               fit: BoxFit.cover,
//               width: double.infinity,
//               height: double.infinity,
//               errorBuilder: (context, error, stackTrace) =>
//                   _buildErrorWidget(context),
//             );
//     }

//     // If there's a network image
//     if (imageUrl != null) {
//       return CachedNetworkImage(
//         imageUrl: imageUrl!,
//         fit: BoxFit.cover,
//         width: double.infinity,
//         height: double.infinity,
//         imageBuilder: (context, imageProvider) {
//           return isInteractive
//               ? GestureDetector(
//                   onTap: () => _showFullScreenImage(context, imageProvider),
//                   child: Image(
//                     image: imageProvider,
//                     fit: BoxFit.cover,
//                     width: double.infinity,
//                     height: double.infinity,
//                   ),
//                 )
//               : Image(
//                   image: imageProvider,
//                   fit: BoxFit.cover,
//                   width: double.infinity,
//                   height: double.infinity,
//                 );
//         },
//         placeholder: (context, url) => _buildPlaceholderWidget(),
//         errorWidget: (context, url, error) => _buildErrorWidget(context),
//       );
//     }

//     // If no image is provided
//     return _buildPlaceholderWidget();
//   }

//   Widget _buildPlaceholderWidget() {
//     return Center(
//       child: placeholderAsset != null
//           ? Image.asset(
//               placeholderAsset!,
//               fit: BoxFit.cover,
//               width: double.infinity,
//               height: double.infinity,
//             )
//           : const Icon(
//               Icons.image,
//               size: 50,
//               color: Colors.grey,
//             ),
//     );
//   }

//   Widget _buildErrorWidget(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       height: double.infinity,
//       color: Theme.of(context).colorScheme.errorContainer,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.error_outline,
//             size: 40,
//             color: Theme.of(context).colorScheme.error,
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'Failed to load image',
//             style: TextStyle(
//               color: Theme.of(context).colorScheme.error,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Extension methods for common use cases
// extension BannerImageX on BannerImage {
//   static BannerImage network({
//     required String url,
//     double height = 200,
//     bool isInteractive = false,
//     bool isLoading = false,
//     Color? backgroundColor,
//     String? placeholderAsset,
//   }) {
//     return BannerImage(
//       imageUrl: url,
//       height: height,
//       isInteractive: isInteractive,
//       isLoading: isLoading,
//       backgroundColor: backgroundColor,
//       placeholderAsset: placeholderAsset,
//     );
//   }

//   static BannerImage file({
//     required File file,
//     double height = 200,
//     bool isInteractive = false,
//     bool isLoading = false,
//     Color? backgroundColor,
//     String? placeholderAsset,
//   }) {
//     return BannerImage(
//       imageFile: file,
//       height: height,
//       isInteractive: isInteractive,
//       isLoading: isLoading,
//       backgroundColor: backgroundColor,
//       placeholderAsset: placeholderAsset,
//     );
//   }

//   static BannerImage placeholder({
//     double height = 200,
//     Color? backgroundColor,
//     String? placeholderAsset,
//   }) {
//     return BannerImage(
//       height: height,
//       backgroundColor: backgroundColor,
//       placeholderAsset: placeholderAsset,
//     );
//   }
// }

// // Usage examples:
// void example() {
//   // Network image
//   BannerImage.network(
//     url: 'https://example.com/image.jpg',
//     isInteractive: true,
//   );

//   // File image
//   BannerImage.file(
//     file: File('path/to/image.jpg'),
//     height: 300,
//   );

//   // Placeholder
//   BannerImage.placeholder(
//     height: 200,
//     placeholderAsset: 'assets/images/default_banner.png',
//   );

//   // Full configuration
//   const BannerImage(
//     imageUrl: 'https://example.com/image.jpg',
//     height: 250,
//     isInteractive: true,
//     isLoading: false,
//     backgroundColor: Colors.grey,
//     placeholderAsset: 'assets/images/placeholder.png',
//   );
// }

class BannerImage extends StatelessWidget {
  /// URL for network image
  final String? imageUrl;

  /// File for local image
  final File? imageFile;

  /// Height of the banner
  final double height;

  /// Whether the image is loading
  final bool isLoading;

  /// Whether the image can be tapped to show full screen view
  final bool isInteractive;

  /// Background color when no image is available
  final Color? backgroundColor;

  /// Asset path for a placeholder image
  final String? placeholderAsset;

  /// Optional callback when image is tapped
  final VoidCallback? onTap;

  /// Optional error text to display
  final String? errorText;

  /// Optional border radius for the banner
  final BorderRadius? borderRadius;

  /// Optional box shadow for the banner
  final List<BoxShadow>? boxShadow;

  /// Show a visual indicator that the image can be zoomed
  final bool showZoomIndicator;

  const BannerImage({
    super.key,
    this.imageUrl,
    this.imageFile,
    this.height = 200,
    this.isLoading = false,
    this.isInteractive = false,
    this.backgroundColor,
    this.placeholderAsset,
    this.onTap,
    this.errorText,
    this.borderRadius,
    this.boxShadow,
    this.showZoomIndicator = true,
  });

  void _showFullScreenImage(BuildContext context, ImageProvider imageProvider) {
    InteractiveImageViewer.show(
      context: context,
      imageProvider: imageProvider,
      title: 'Banner Photo',
      backgroundColor: Colors.black,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultBgColor =
        backgroundColor ?? theme.colorScheme.surfaceContainerHighest;

    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: defaultBgColor,
        borderRadius: borderRadius,
        boxShadow: boxShadow,
      ),
      clipBehavior: borderRadius != null ? Clip.antiAlias : Clip.none,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Main image content
          _buildImageContent(context),

          // Loading indicator (if applicable)
          if (isLoading)
            Container(
              color: Colors.black26,
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      theme.colorScheme.onSurface),
                ),
              ),
            ),

          // Optional zoom indicator (for interactive images)
          if (!isLoading &&
              isInteractive &&
              showZoomIndicator &&
              (imageUrl != null || imageFile != null))
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Icon(
                  Icons.zoom_in,
                  size: 16,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildImageContent(BuildContext context) {
    // Determine if we should enable tap functionality
    final bool enableTap = !isLoading && (isInteractive || onTap != null);
    final hasImage = imageFile != null || imageUrl != null;

    Widget content;

    if (imageFile != null) {
      // Local file image
      content = Image.file(
        imageFile!,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        errorBuilder: (context, error, stackTrace) =>
            _buildErrorWidget(context, errorText),
      );
    } else if (imageUrl != null) {
      // Network image with caching
      content = CachedNetworkImage(
        imageUrl: imageUrl!,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        placeholder: (context, url) => _buildPlaceholderWidget(),
        errorWidget: (context, url, error) =>
            _buildErrorWidget(context, errorText),
      );
    } else {
      // No image available
      content = _buildPlaceholderWidget();
    }

    // Wrap in GestureDetector if tap should be enabled
    return enableTap && hasImage
        ? GestureDetector(
            onTap: onTap ??
                () {
                  // Determine which image provider to use
                  final imageProvider = imageFile != null
                      ? FileImage(imageFile!) as ImageProvider
                      : CachedNetworkImageProvider(imageUrl!);

                  _showFullScreenImage(context, imageProvider);
                },
            child: content,
          )
        : content;
  }

  Widget _buildPlaceholderWidget() {
    return Container(
      color: backgroundColor,
      child: Center(
        child: placeholderAsset != null
            ? Image.asset(
                placeholderAsset!,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              )
            : const Icon(
                Icons.image,
                size: 50,
                color: Colors.grey,
              ),
      ),
    );
  }

  Widget _buildErrorWidget(BuildContext context, String? customErrorText) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: theme.colorScheme.errorContainer,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 40,
              color: theme.colorScheme.error,
            ),
            const SizedBox(height: 8),
            Text(
              customErrorText ?? 'Failed to load image',
              style: TextStyle(
                color: theme.colorScheme.error,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// Extension methods for common BannerImage usage patterns
extension BannerImageExtensions on BannerImage {
  /// Create a banner from a network URL
  static BannerImage network({
    required String url,
    double height = 200,
    bool isInteractive = true,
    bool isLoading = false,
    Color? backgroundColor,
    String? placeholderAsset,
    VoidCallback? onTap,
    String? errorText,
    BorderRadius? borderRadius,
    List<BoxShadow>? boxShadow,
    bool showZoomIndicator = true,
  }) {
    return BannerImage(
      imageUrl: url,
      height: height,
      isInteractive: isInteractive,
      isLoading: isLoading,
      backgroundColor: backgroundColor,
      placeholderAsset: placeholderAsset,
      onTap: onTap,
      errorText: errorText,
      borderRadius: borderRadius,
      boxShadow: boxShadow,
      showZoomIndicator: showZoomIndicator,
    );
  }

  /// Create a banner from a local file
  static BannerImage file({
    required File file,
    double height = 200,
    bool isInteractive = true,
    bool isLoading = false,
    Color? backgroundColor,
    String? placeholderAsset,
    VoidCallback? onTap,
    String? errorText,
    BorderRadius? borderRadius,
    List<BoxShadow>? boxShadow,
    bool showZoomIndicator = true,
  }) {
    return BannerImage(
      imageFile: file,
      height: height,
      isInteractive: isInteractive,
      isLoading: isLoading,
      backgroundColor: backgroundColor,
      placeholderAsset: placeholderAsset,
      onTap: onTap,
      errorText: errorText,
      borderRadius: borderRadius,
      boxShadow: boxShadow,
      showZoomIndicator: showZoomIndicator,
    );
  }

  /// Create a placeholder banner with no image
  static BannerImage placeholder({
    double height = 200,
    Color? backgroundColor,
    String? placeholderAsset,
    BorderRadius? borderRadius,
    List<BoxShadow>? boxShadow,
  }) {
    return BannerImage(
      height: height,
      backgroundColor: backgroundColor,
      placeholderAsset: placeholderAsset,
      borderRadius: borderRadius,
      boxShadow: boxShadow,
      isInteractive: false,
    );
  }

  /// Create a banner with a rounded appearance
  static BannerImage rounded({
    String? imageUrl,
    File? imageFile,
    double height = 200,
    bool isInteractive = true,
    bool isLoading = false,
    Color? backgroundColor,
    String? placeholderAsset,
    VoidCallback? onTap,
    String? errorText,
    double radius = 16.0,
    List<BoxShadow>? boxShadow,
  }) {
    return BannerImage(
      imageUrl: imageUrl,
      imageFile: imageFile,
      height: height,
      isInteractive: isInteractive,
      isLoading: isLoading,
      backgroundColor: backgroundColor,
      placeholderAsset: placeholderAsset,
      onTap: onTap,
      errorText: errorText,
      borderRadius: BorderRadius.circular(radius),
      boxShadow: boxShadow ??
          [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
    );
  }

  /// Create a banner with elevated appearance
  static BannerImage elevated({
    String? imageUrl,
    File? imageFile,
    double height = 200,
    bool isInteractive = true,
    bool isLoading = false,
    Color? backgroundColor,
    String? placeholderAsset,
    VoidCallback? onTap,
    String? errorText,
    BorderRadius? borderRadius,
  }) {
    return BannerImage(
      imageUrl: imageUrl,
      imageFile: imageFile,
      height: height,
      isInteractive: isInteractive,
      isLoading: isLoading,
      backgroundColor: backgroundColor,
      placeholderAsset: placeholderAsset,
      onTap: onTap,
      errorText: errorText,
      borderRadius: borderRadius ?? BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 10,
          spreadRadius: 1,
          offset: const Offset(0, 3),
        ),
      ],
    );
  }
}
