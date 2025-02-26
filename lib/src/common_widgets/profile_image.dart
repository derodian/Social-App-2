import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_app_2/src/common_widgets/interactive_image_view.dart';

// class ProfileImage extends StatelessWidget {
//   final String? imageUrl;
//   final File? imageFile;
//   final double radius;
//   final bool isLoading;
//   final bool showBorder;
//   final bool isInteractive;

//   const ProfileImage({
//     super.key,
//     this.imageUrl,
//     this.imageFile,
//     this.radius = 60,
//     this.isLoading = false,
//     this.showBorder = true,
//     this.isInteractive = false,
//   });

//   void _showFullScreenImage(BuildContext context, ImageProvider imageProvider) {
//     InteractiveImageViewer(
//       imageProvider: imageProvider,
//       title: 'Profile Photo',
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: showBorder
//           ? BoxDecoration(
//               shape: BoxShape.circle,
//               border: Border.all(
//                   color: Theme.of(context).colorScheme.surface, width: 4),
//             )
//           : null,
//       child: CircleAvatar(
//         radius: radius - (showBorder ? 4 : 0),
//         backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
//         child: isLoading
//             ? const CircularProgressIndicator()
//             : _buildImage(context),
//       ),
//     );
//   }

//   Widget _buildImage(BuildContext context) {
//     if (imageFile != null) {
//       final imageProvider = FileImage(imageFile!);
//       return isInteractive
//           ? GestureDetector(
//               onTap: () => _showFullScreenImage(context, imageProvider),
//               child: _buildClippedImage(imageProvider),
//             )
//           : _buildClippedImage(imageProvider);
//     } else if (imageUrl != null) {
//       final imageProvider = CachedNetworkImageProvider(imageUrl!);
//       return isInteractive
//           ? GestureDetector(
//               onTap: () => _showFullScreenImage(context, imageProvider),
//               child: _buildCachedImage(imageProvider),
//             )
//           : _buildCachedImage(imageProvider);
//     }
//     return Icon(Icons.person, size: radius);
//   }

//   Widget _buildClippedImage(ImageProvider imageProvider) {
//     return ClipOval(
//       child: Image(
//         image: imageProvider,
//         width: radius * 2,
//         height: radius * 2,
//         fit: BoxFit.cover,
//       ),
//     );
//   }

//   Widget _buildCachedImage(ImageProvider imageProvider) {
//     return Container(
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         image: DecorationImage(
//           image: imageProvider,
//           fit: BoxFit.cover,
//         ),
//       ),
//     );
//   }
// }

class ProfileImage extends StatelessWidget {
  final String? imageUrl;
  final File? imageFile;
  final double radius;
  final bool isLoading;
  final bool showBorder;
  final bool isInteractive;
  final VoidCallback? onTap;

  const ProfileImage({
    super.key,
    this.imageUrl,
    this.imageFile,
    this.radius = 60,
    this.isLoading = false,
    this.showBorder = true,
    this.isInteractive = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: showBorder
          ? BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: theme.colorScheme.surface,
                width: 4,
              ),
              // Add subtle shadow for depth
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  spreadRadius: 1,
                  offset: const Offset(0, 2),
                ),
              ],
            )
          : null,
      child: CircleAvatar(
        radius: radius - (showBorder ? 4 : 0),
        backgroundColor: theme.colorScheme.surfaceContainerHighest,
        child: _buildImageContent(context),
      ),
    );
  }

  Widget _buildImageContent(BuildContext context) {
    if (isLoading) {
      return SizedBox(
        width: radius,
        height: radius,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            Theme.of(context).colorScheme.primary,
          ),
        ),
      );
    }

    // Determine if we have an image to display
    final hasImage = imageFile != null || imageUrl != null;

    // If we have an image and it's interactive, wrap in GestureDetector
    if (hasImage && (isInteractive || onTap != null)) {
      return GestureDetector(
        onTap: onTap ?? () => _showFullScreenImage(context),
        child: _buildImageWidget(context),
      );
    }

    // Otherwise just return the image or placeholder
    return _buildImageWidget(context);
  }

  Widget _buildImageWidget(BuildContext context) {
    if (imageFile != null) {
      return ClipOval(
        child: Image.file(
          imageFile!,
          width: radius * 2,
          height: radius * 2,
          fit: BoxFit.cover,
        ),
      );
    } else if (imageUrl != null) {
      return CachedNetworkImage(
        imageUrl: imageUrl!,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        placeholder: (context, url) => Center(
          child: SizedBox(
            width: radius * 0.5,
            height: radius * 0.5,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
        errorWidget: (context, url, error) => Icon(
          Icons.person,
          size: radius,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      );
    }

    // No image - show placeholder
    return Icon(
      Icons.person,
      size: radius,
      color: Theme.of(context).colorScheme.onSurfaceVariant,
    );
  }

  void _showFullScreenImage(BuildContext context) {
    if (imageFile != null || imageUrl != null) {
      final ImageProvider imageProvider = imageFile != null
          ? FileImage(imageFile!)
          : CachedNetworkImageProvider(imageUrl!) as ImageProvider;

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => InteractiveImageViewer(
            imageProvider: imageProvider,
            title: 'Profile Photo',
          ),
        ),
      );
    }
  }
}
