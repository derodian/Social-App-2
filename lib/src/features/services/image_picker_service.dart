// lib/core/services/image_picker_service.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'image_picker_service.g.dart';

class ImagePickerService {
  ImagePickerService({ImagePicker? picker}) : _picker = picker ?? ImagePicker();

  final ImagePicker _picker;

  /// Picks an image from the specified source with optional constraints
  Future<File?> pickImage({
    required ImageSource source,
    double? maxWidth,
    double? maxHeight,
    int? imageQuality,
    bool preferCameraDevice = false,
  }) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        imageQuality: imageQuality ?? 80,
        preferredCameraDevice:
            preferCameraDevice ? CameraDevice.front : CameraDevice.rear,
      );

      // If user canceled selection, return null without throwing
      if (pickedFile == null) return null;

      // Verify the file exists and is readable
      final file = File(pickedFile.path);
      if (!await file.exists()) {
        throw Exception('Selected image file does not exist');
      }

      // Check file size (optional)
      final fileSize = await file.length();
      if (fileSize > 10 * 1024 * 1024) {
        // 10MB limit example
        throw Exception('Image file is too large (max 10MB)');
      }

      return file;
    } on PlatformException catch (e) {
      debugPrint('Platform error picking image: ${e.message}');
      if (e.code == 'invalid_image') {
        throw Exception(
            'The selected image appears to be invalid or corrupted');
      } else if (e.code == 'camera_access_denied') {
        throw Exception('Camera permission denied');
      } else if (e.code == 'photo_access_denied') {
        throw Exception('Gallery access denied');
      } else if (e.message?.contains('Cannot load representation') ?? false) {
        throw Exception(
          'Unable to load this image format. Please try another image.',
        );
      }
      throw Exception('Error picking image: ${e.message}');
    } catch (e) {
      debugPrint('Error picking image: $e');
      throw Exception('Failed to pick image. Please try again.');
    }
  }

  /// Picks a video from the specified source with optional constraints
  Future<File?> pickVideo({
    required ImageSource source,
    Duration? maxDuration,
  }) async {
    try {
      final XFile? pickedFile = await _picker.pickVideo(
        source: source,
        maxDuration: maxDuration,
      );

      if (pickedFile == null) return null;

      final file = File(pickedFile.path);
      if (!await file.exists()) {
        throw Exception('Selected video file does not exist');
      }

      return file;
    } catch (e) {
      debugPrint('Error picking video: $e');
      throw Exception('Failed to pick video. Please try again.');
    }
  }

  Future<File?> pickImageFromGallery({
    double? maxWidth,
    double? maxHeight,
    int? quality,
  }) async {
    return pickImage(
      source: ImageSource.gallery,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      imageQuality: quality,
    );
  }

  Future<File?> pickImageFromCamera({
    double? maxWidth,
    double? maxHeight,
    int? quality,
    bool preferFrontCamera = false,
  }) async {
    return pickImage(
      source: ImageSource.camera,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      imageQuality: quality,
      preferCameraDevice: preferFrontCamera,
    );
  }
}

@riverpod
ImagePickerService imagePicker(Ref ref) {
  return ImagePickerService();
}
