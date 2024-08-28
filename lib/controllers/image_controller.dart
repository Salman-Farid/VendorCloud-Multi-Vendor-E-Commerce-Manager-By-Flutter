import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../services/base/app_exceptions.dart';

class MediaController extends GetxController {
  final _imageBase64 = ''.obs;
  final _fileExtension = ''.obs;
  final _encodedImage = ''.obs;

  // Video properties
  final _videoBase64 = ''.obs;
  final _videoExtension = ''.obs;
  final _encodedVideo = ''.obs;

  // Additional images
  final _additionalImagesBase64 = <String>[].obs;

  String get imageBase64 => _imageBase64.value;
  String get fileExtension => _fileExtension.value;
  String get encodedImage => _encodedImage.value;
  List<String> get additionalImagesBase64 => _additionalImagesBase64;

  String get videoBase64 => _videoBase64.value;
  String get videoExtension => _videoExtension.value;
  String get encodedVideo => _encodedVideo.value;

  // Future<void> imagePickerAndBase64Conversion() async {
  //   final picker = ImagePicker();
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  //
  //   if (pickedFile != null) {
  //     final filePath = pickedFile.path;
  //     _fileExtension.value = filePath.split('.').last.toLowerCase(); // File extension
  //
  //     final file = File(filePath);
  //     final fileSize = await file.length(); // Get file size in bytes
  //
  //     // Check if file size is greater than 5 MB (5 * 1024 * 1024 bytes)
  //     if (fileSize > 5 * 1024 * 1024) {
  //       throw InvalidException(
  //         "File size exceeds 5 MB! Please select a smaller image.",
  //         false,
  //       );
  //     }
  //     final bytes = await file.readAsBytes();
  //     _encodedImage.value = base64Encode(bytes);
  //     // Correctly construct the imageBase64 string
  //     _imageBase64.value = "data:image/${_fileExtension.value};base64,${_encodedImage.value}";
  //   }  else {
  //     Get.snackbar(
  //       'Error',
  //       'No image selected!',
  //       backgroundColor: Colors.red,
  //       colorText: Colors.white,
  //     );
  //   }
  // }







  Future<void> imagePickerAndBase64Conversion() async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        final filePath = pickedFile.path;
        _fileExtension.value = filePath.split('.').last.toLowerCase(); // File extension

        final file = File(filePath);
        final fileSize = await file.length(); // Get file size in bytes

        // Check if file size is greater than 5 MB (5 * 1024 * 1024 bytes)
        if (fileSize > 5 * 1024 * 1024) {
          Get.snackbar(
            'Error',
            'File size exceeds 5 MB! Please select a smaller image.',
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          return; // Exit the function
        }

        final bytes = await file.readAsBytes();
        _encodedImage.value = base64Encode(bytes);
        // Correctly construct the imageBase64 string
        _imageBase64.value = "data:image/${_fileExtension.value};base64,${_encodedImage.value}";
      } else {
        Get.snackbar(
          'Error',
          'No image selected!',
          backgroundColor: Colors.transparent,
          colorText: Colors.black,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred while picking the image.',
        backgroundColor: Colors.transparent,
        colorText: Colors.black,
      );
    }
  }









  // Future<void> videoPickerAndBase64Conversion() async {
  //   final picker = ImagePicker();
  //   final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
  //
  //   if (pickedFile != null) {
  //     final filePath = pickedFile.path;
  //     _videoExtension.value = filePath.split('.').last.toLowerCase(); // File extension
  //
  //     final file = File(filePath);
  //     final fileSize = await file.length(); // Get file size in byt
  //     // Check if file size is greater than 20 MB (20 * 1024 * 1024 bytes)
  //     if (fileSize > 200 * 1024 * 1024) {
  //       throw InvalidException(
  //         "File size exceeds 20 MB! Please select a smaller video.",
  //         false,
  //       );
  //     }
  //     final bytes = await file.readAsBytes();
  //     _encodedVideo.value = base64Encode(bytes);
  //     // Correctly construct the videoBase64 string
  //     _videoBase64.value = "data:video/${_videoExtension.value};base64,${_encodedVideo.value}";
  //   } else {
  //     throw Exception("No video selected!");
  //   }
  // }

  Future<void> videoPickerAndBase64Conversion() async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickVideo(source: ImageSource.gallery);

      if (pickedFile != null) {
        final filePath = pickedFile.path;
        _videoExtension.value = filePath.split('.').last.toLowerCase(); // File extension

        final file = File(filePath);
        final fileSize = await file.length(); // Get file size in bytes

        // Check if file size is greater than 20 MB (20 * 1024 * 1024 bytes)
        if (fileSize > 200 * 1024 * 1024) {
          Get.snackbar(
            'Error',
            'File size exceeds 200 MB! Please select a smaller video.',
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          return; // Exit the function
        }

        final bytes = await file.readAsBytes();
        _encodedVideo.value = base64Encode(bytes);
        // Correctly construct the videoBase64 string
        _videoBase64.value = "data:video/${_videoExtension.value};base64,${_encodedVideo.value}";
      } else {
        Get.snackbar(
          'Error',
          'No video selected!',
          backgroundColor: Colors.transparent,
          colorText: Colors.black,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred while picking the video.',
        backgroundColor: Colors.transparent,
        colorText: Colors.black,
      );
    }
  }






  Future<void> pickAdditionalImages() async {
    final picker = ImagePicker();
    try {
      final pickedFiles = await picker.pickMultiImage();

      if (pickedFiles.isEmpty) {
        Get.snackbar(
          'Error',
          'You can only select up to 3 images!',
          backgroundColor: Colors.transparent,
          colorText: Colors.black,
        );
        return;
      }

      if (pickedFiles.length > 3) {
        Get.snackbar(
          snackPosition: SnackPosition.BOTTOM,

          'Error',
          'You can only select up to 3 images!',
          backgroundColor: Colors.transparent,
          colorText: Colors.black,
        );
        return;
      }

      for (var pickedFile in pickedFiles) {
        final filePath = pickedFile.path;
        final fileExtension = filePath.split('.').last.toLowerCase(); // File extension

        final file = File(filePath);
        final fileSize = await file.length(); // Get file size in bytes

        // Check if file size is greater than 5 MB (5 * 1024 * 1024 bytes)
        if (fileSize > 5 * 1024 * 1024) {
          Get.snackbar(
            snackPosition: SnackPosition.BOTTOM,

            'Error',
            'File size exceeds 5 MB! Please select a smaller image.',
            backgroundColor: Colors.transparent,
            colorText: Colors.black,
          );
          continue; // Skip this file and continue with the next
        }

        final bytes = await file.readAsBytes();
        final encodedImage = base64Encode(bytes);
        final imageBase64 = "data:image/$fileExtension;base64,$encodedImage";

        // Add to additional images list, ensuring it doesn't exceed 3 images
        if (_additionalImagesBase64.length < 3) {
          _additionalImagesBase64.add(imageBase64);
        } else {
          Get.snackbar(
            snackPosition: SnackPosition.BOTTOM,
            'Warning',
            'You can only upload up to 3 images!',
            backgroundColor: Colors.transparent,
            colorText: Colors.black,
          );
        }
      }
    } catch (e) {
      Get.snackbar(
        snackPosition: SnackPosition.TOP,
        'Error',
        'An error occurred while picking images!',
        backgroundColor: Colors.transparent,
        colorText: Colors.black,
      );
    }
  }




  void removeCoverPhoto() {
    _imageBase64.value = '';
  }

  void removeImage(int index) {
    if (index >= 0 && index < _additionalImagesBase64.length) {
      _additionalImagesBase64.removeAt(index);
    }
  }

  void removeVideo() {
    _videoBase64.value = '';
  }
}

















// import 'dart:io';
// import 'dart:convert';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
//
// import '../services/base/app_exceptions.dart';
//
// class ImageController extends GetxController {
//   final _imageBase64 = ''.obs;
//   final _fileExtension = ''.obs;
//   final _encodedImage = ''.obs;
//
//   // Additional images
//   final _additionalImagesBase64 = <String>[].obs;
//
//   String get imageBase64 => _imageBase64.value;
//   String get fileExtension => _fileExtension.value;
//   String get encodedImage => _encodedImage.value;
//   List<String> get additionalImagesBase64 => _additionalImagesBase64;
//
//   Future<void> imagePickerAndBase64Conversion() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//
//     if (pickedFile != null) {
//       final filePath = pickedFile.path;
//       _fileExtension.value =
//           filePath.split('.').last.toLowerCase(); // File extension
//
//       final file = File(filePath);
//       final fileSize = await file.length(); // Get file size in bytes
//
//       // Check if file size is greater than 2 MB (2 * 1024 * 1024 bytes)
//       if (fileSize > 5 * 1024 * 1024) {
//         throw InvalidException(
//           "File size exceeds 5 MB! Please select a smaller image.",
//           false,
//         );
//       }
//       final bytes = await file.readAsBytes();
//       _encodedImage.value = base64Encode(bytes);
//       // Correctly construct the imageBase64 string
//       _imageBase64.value =
//           "data:image/${_fileExtension.value};base64,${_encodedImage.value}";
//     } else {
//       throw Exception("No image selected!");
//     }
//   }
//
//   Future<void> pickAdditionalImages() async {
//     final picker = ImagePicker();
//     final pickedFiles = await picker.pickMultiImage();
//
//     for (var pickedFile in pickedFiles) {
//       final filePath = pickedFile.path;
//       final fileExtension =
//           filePath.split('.').last.toLowerCase(); // File extension
//
//       final file = File(filePath);
//       final fileSize = await file.length(); // Get file size in bytes
//
//       // Check if file size is greater than 5 MB (5 * 1024 * 1024 bytes)
//       if (fileSize > 15 * 1024 * 1024) {
//         throw InvalidException(
//           "File size exceeds 5 MB! Please select a smaller image.",
//           false,
//         );
//       }
//       final bytes = await file.readAsBytes();
//       final encodedImage = base64Encode(bytes);
//       final imageBase64 = "data:image/$fileExtension;base64,$encodedImage";
//
//       // Add to additional images list
//       _additionalImagesBase64.add(imageBase64);
//     }
//   }
//
//   void removeCoverPhoto() {
//     _imageBase64.value = '';
//   }
//
//   void removeImage(int index) {
//     if (index >= 0 && index < _additionalImagesBase64.length) {
//       _additionalImagesBase64.removeAt(index);
//     }
//   }
// }
