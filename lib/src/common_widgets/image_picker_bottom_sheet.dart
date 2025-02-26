import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

/// Bottom sheet for image source selection
class ImagePickerBottomSheet extends StatelessWidget {
  final String title;

  const ImagePickerBottomSheet({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take a photo'),
              onTap: () => Navigator.of(context).pop(ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from gallery'),
              onTap: () => Navigator.of(context).pop(ImageSource.gallery),
            ),
            if (title.contains('Profile'))
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Remove current photo'),
                onTap: () => Navigator.of(context).pop(null),
              ),
          ],
        ),
      ),
    );
  }
}

// /// Provider for image picker
// final imagePickerProvider = Provider<ImagePicker>((ref) {
//   return ImagePicker();
// });
