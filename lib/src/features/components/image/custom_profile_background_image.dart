import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_app_2/src/constants/strings.dart';
import 'package:social_app_2/src/theme/app_colors.dart';

class CustomProfileBackgroundImage extends StatelessWidget {
  const CustomProfileBackgroundImage({
    super.key,
    this.imageUrl,
    this.imageFile,
    this.onTap,
    this.text,
  });
  final String? imageUrl;
  final File? imageFile;
  final VoidCallback? onTap;
  final String? text;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SizedBox(
      height: screenSize.height / 4.0,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: imageFile != null || imageUrl != null
                ? Colors.transparent
                : AppColors.kcPrimaryColor,
            image: imageFile != null
                ? DecorationImage(
                    image: FileImage(imageFile!),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.lightBlue.shade100,
                      BlendMode.colorBurn,
                    ),
                  )
                : (imageUrl != null && imageUrl!.isNotEmpty)
                    ? DecorationImage(
                        image: CachedNetworkImage(
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
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Center(
                            child: CircularProgressIndicator(
                                value: downloadProgress.progress),
                          ),
                          errorWidget: (context, url, error) => const Center(
                              child: Column(
                            children: [
                              Icon(Icons.error),
                              Text(Strings.noImage)
                            ],
                          )),
                        ) as ImageProvider<Object>,
                      )
                    : const DecorationImage(
                        image: AssetImage(Strings.assetImagePlaceholder),
                        fit: BoxFit.cover,
                      ),
          ),
        ),
      ),
    );
  }
}
