import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_app_2/src/constants/strings.dart';

class CustomCoverImage extends StatelessWidget {
  const CustomCoverImage({
    super.key,
    this.imageUrl,
    this.imageFile,
    this.onTap,
    this.text,
    this.height,
  });

  final String? imageUrl;
  final File? imageFile;
  final VoidCallback? onTap;
  final String? text;
  final double? height;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SizedBox(
      height: height ?? screenSize.height / 3.5,
      child: InkWell(
        onTap: onTap,
        child: _buildImage(context, screenSize),
      ),
    );
  }

  Widget _buildImage(BuildContext context, Size screenSize) {
    if (imageFile != null) {
      return _buildFileImage();
    } else if (imageUrl != null && imageUrl!.isNotEmpty) {
      return _buildNetworkImage();
    } else {
      return _buildPlaceholderImage(screenSize);
    }
  }

  Widget _buildFileImage() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: FileImage(imageFile!),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.lightBlue.shade100,
            BlendMode.colorBurn,
          ),
        ),
      ),
    );
  }

  Widget _buildNetworkImage() {
    return CachedNetworkImage(
      imageUrl: imageUrl!,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.lightBlue.shade100,
              BlendMode.colorBurn,
            ),
          ),
        ),
      ),
      progressIndicatorBuilder: (context, url, downloadProgress) => Center(
        child: CircularProgressIndicator(value: downloadProgress.progress),
      ),
      errorWidget: (context, url, error) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, color: Colors.red),
            const SizedBox(height: 8),
            Text('Error loading image: $error', textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholderImage(Size screenSize) {
    return Container(
      width: screenSize.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Strings.assetImagePlaceholder),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          text ?? '',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
