import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// Custom image widget that loads an image as a static asset or uses
/// [CachedNetworkImage] depending on the image url.
class CustomImage extends StatelessWidget {
  const CustomImage({
    super.key,
    required this.imageUrl,
    this.aspectRatio = 1.4,
    this.fit = BoxFit.cover,
  });
  final String? imageUrl;
  final double? aspectRatio;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    // needed to make null-checks easier
    final imageUrl = this.imageUrl;
    // * For this widget to work correctly on web, we need to handle CORS:
    // * https://flutter.dev/docs/development/platform-integration/web-images
    return AspectRatio(
      aspectRatio: aspectRatio!,
      child: imageUrl == null
          ? const Placeholder()
          : imageUrl.startsWith('http')
              ? CachedNetworkImage(
                  imageUrl: localhostFriendlyImageUrl(imageUrl),
                  fit: fit,
                  placeholder: (context, url) => _buildShimmer(
                    child: Container(
                      height: 200,
                      color: Colors.white,
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    height: 200,
                    color: Colors.grey[300],
                    child: const Center(
                      child: Icon(Icons.error, color: Colors.red),
                    ),
                  ),
                )
              : Image.asset(imageUrl),
    );
  }

  Widget _buildShimmer({required Widget child}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: child,
    );
  }
}

/// Unless the correct IP is used, the Android Emulator will fail to load
/// localhost images that were saved with the Firebase Local Emulator
/// This code ensures the correct IP is used on localhost
String localhostFriendlyImageUrl(String imageUrl) {
  const localhostDefault1 = 'http://127.0.0.1';
  const localhostDefault2 = 'http://localhost';
  const localhostAndroid = 'http://10.0.2.2';
  // To prevent an exception, check kIsWeb before using the [Platform] class
  final isAndroid = !kIsWeb && Platform.isAndroid;
  if (isAndroid) {
    // * Android emulator can only connect to localhost with the 10.0.2.2 IP:
    // * https://stackoverflow.com/a/5806384/436422
    if (imageUrl.startsWith(localhostDefault1)) {
      return imageUrl.replaceFirst(localhostDefault1, localhostAndroid);
    } else if (imageUrl.startsWith(localhostDefault2)) {
      return imageUrl.replaceFirst(localhostDefault2, localhostAndroid);
    }
  }
  if (!isAndroid && imageUrl.startsWith(localhostAndroid)) {
    // * If the image was originally saved with the Android emulator, but
    // * we're now try to load it from a different platform, use 127.0.0.1:
    return imageUrl.replaceFirst(localhostAndroid, localhostDefault1);
  }
  return imageUrl;
}
