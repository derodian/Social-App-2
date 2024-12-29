import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_app_2/src/constants/strings.dart';

class CustomCircularAvatar extends StatelessWidget {
  const CustomCircularAvatar({
    super.key,
    this.imageUrl,
    this.imageFile,
    this.radius = 100.0,
    this.borderColor,
    this.onTap,
  });
  final String? imageUrl;
  final File? imageFile;
  final double? radius;
  final Color? borderColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final imageUrl = this.imageUrl != null && this.imageUrl!.isNotEmpty
        ? this.imageUrl
        : Strings.dummyProfileImageURL;
    return InkWell(
      onTap: onTap,
      child: CircleAvatar(
        radius: radius,
        // foregroundColor: Colors.white,
        child: (imageFile != null)
            ? DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radius!),
                  border: Border.all(
                    color: borderColor ?? Colors.white,
                    width: 2.0,
                  ),
                ),
                child: CircleAvatar(
                  radius: radius,
                  backgroundImage: FileImage(imageFile!),
                ),
              )
            : CachedNetworkImage(
                imageUrl: imageUrl!,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radius!),
                    border: Border.all(
                      color: borderColor ?? Colors.white,
                      width: 2.0,
                    ),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                      // colorFilter: const ColorFilter.mode(
                      //   Colors.blue,
                      //   BlendMode.colorBurn,
                      // ),
                    ),
                  ),
                ),
                // placeholder: (context, url) => const CircularProgressIndicator(),
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
      ),
    );
  }
}
