import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_thumbnail_video/index.dart';
import 'package:get_thumbnail_video/video_thumbnail.dart';
import 'package:image_picker/image_picker.dart';

class MediaController extends GetxController {
  final _imageBase64 = ''.obs;
  final _fileExtension = ''.obs;
  final _encodedImage = ''.obs;
  final _additionalImagesUrls = <String>[].obs;
  final _videoUrl = ''.obs;
  final _imageUrl = ''.obs;
  final _additionalImagesBase64 = <String>[].obs;



  // Video properties
  final _videoBase64 = ''.obs;
  final _videoExtension = ''.obs;
  final _encodedVideo = ''.obs;
  final _videoThumnail = ''.obs;

  // Additional images

  String get imageUrl => _imageUrl.value;
  String get imageBase64 => _imageBase64.value;
  String get fileExtension => _fileExtension.value;
  String get encodedImage => _encodedImage.value;
  List<String> get additionalImagesBase64 => _additionalImagesBase64;
  List<String> get additionalImagesUrls => _additionalImagesUrls;
  String get videoUrl => _videoUrl.value;








  String get videoBase64 => _videoBase64.value;
  String get videoExtension => _videoExtension.value;
  String get encodedVideo => _encodedVideo.value;
  String get videoThumnail => _videoThumnail.value;




  Future<void> imagePickerAndBase64Conversion() async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        final filePath = pickedFile.path;

        _fileExtension.value =
            filePath.split('.').last.toLowerCase(); // File extension

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
        _imageBase64.value =
            "data:image/${_fileExtension.value};base64,${_encodedImage.value}";
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

  Future<void> videoPickerAndBase64Conversion({String? videoUrl}) async {
    final picker = ImagePicker();

    if (videoUrl != null && videoUrl.isNotEmpty) {
      // Handle the video URL
      try {
        print('The video url is: $videoUrl');
        // Generate thumbnail for the video URL
        final videoThumbnail = await VideoThumbnail.thumbnailData(
          video: videoUrl,

          imageFormat: ImageFormat.JPEG,
          maxWidth: 720,
          quality: 50,
        );

        if (videoThumbnail != null) {
          _videoThumnail.value = base64Encode(videoThumbnail);
        } else {
          Get.snackbar(
            'Error',
            'Unable to generate video thumbnail!',
            backgroundColor: Colors.transparent,
            colorText: Colors.black,
          );
        }

        // Set the video URL as the base64 string directly
        _encodedVideo.value = ''; // Clear any previous encoded video
        _videoBase64.value = videoUrl; // Use the video URL directly
        _videoExtension.value = videoUrl.split('.').last.toLowerCase(); // Extract extension from URL
      } catch (e) {
        print('Error occurred while processing the video URL: $e');
        Get.snackbar(
          'Error',
          'An error occurred while processing the video URL. The error is: $e',
          backgroundColor: Colors.transparent,
          colorText: Colors.black,
        );
      }
    } else {
      // Handle video picking from file
      try {
        final pickedFile = await picker.pickVideo(source: ImageSource.gallery);

        if (pickedFile != null) {
          final filePath = pickedFile.path;
          try {
            final videoThumbnail = await VideoThumbnail.thumbnailData(
              video: filePath,
              imageFormat: ImageFormat.PNG,
              maxWidth: 1080,
              quality: 100,
            );

            if (videoThumbnail != null) {
              _videoThumnail.value = base64Encode(videoThumbnail);
            } else {
              Get.snackbar(
                'Error',
                'Unable to generate video thumbnail!',
                backgroundColor: Colors.transparent,
                colorText: Colors.black,
              );
            }
          } catch (thumbnailError) {
            Get.snackbar(
              'Error',
              'An error occurred while generating the thumbnail.',
              backgroundColor: Colors.transparent,
              colorText: Colors.black,
            );
          }

          _videoExtension.value = filePath.split('.').last.toLowerCase(); // File extension

          final file = File(filePath);
          final fileSize = await file.length(); // Get file size in bytes

          // Check if file size is greater than 200 MB (200 * 1024 * 1024 bytes)
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
          snackPosition: SnackPosition.BOTTOM,
          'Error',
          'An error occurred while picking the video.',
          backgroundColor: Colors.transparent,
          colorText: Colors.black,
        );
      }
    }
  }



  // Future<void> videoPickerAndBase64Conversion() async {
  //   final picker = ImagePicker();
  //   try {
  //     final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
  //
  //     if (pickedFile != null) {
  //       final filePath = pickedFile.path;
  //       try {
  //         final videoThumbnail = await VideoThumbnail.thumbnailData(
  //           video: filePath,
  //           imageFormat: ImageFormat.PNG,
  //           maxWidth: 1080,
  //           quality: 100,
  //         );
  //
  //         if (videoThumbnail != null) {
  //           _videoThumnail.value = base64Encode(videoThumbnail);
  //         } else {}
  //       } catch (thumbnailError) {}
  //       _videoExtension.value =
  //           filePath.split('.').last.toLowerCase(); // File extension
  //
  //       final file = File(filePath);
  //       final fileSize = await file.length(); // Get file size in bytes
  //
  //       // Check if file size is greater than 20 MB (20 * 1024 * 1024 bytes)
  //       if (fileSize > 200 * 1024 * 1024) {
  //         Get.snackbar(
  //           'Error',
  //           'File size exceeds 200 MB! Please select a smaller video.',
  //           backgroundColor: Colors.red,
  //           colorText: Colors.white,
  //         );
  //         return; // Exit the function
  //       }
  //
  //       final bytes = await file.readAsBytes();
  //       _encodedVideo.value = base64Encode(bytes);
  //       // Correctly construct the videoBase64 string
  //       _videoBase64.value =
  //           "data:video/${_videoExtension.value};base64,${_encodedVideo.value}";
  //     } else {
  //       Get.snackbar(
  //         'Error',
  //         'No video selected!',
  //         backgroundColor: Colors.transparent,
  //         colorText: Colors.black,
  //       );
  //     }
  //   } catch (e) {
  //     Get.snackbar(
  //       snackPosition: SnackPosition.BOTTOM,
  //       'Error',
  //       'An error occurred while picking the video.',
  //       backgroundColor: Colors.transparent,
  //       colorText: Colors.black,
  //     );
  //   }
  // }

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

      final totalFile = additionalImagesBase64.length+ additionalImagesUrls.length+ pickedFiles.length;

      if (totalFile > 3) {
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
        final fileExtension =
            filePath.split('.').last.toLowerCase(); // File extension

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
    _imageUrl.value = '';
    _imageBase64.value = '';
  }

  void removeImage(int index) {
    if (index >= 0 && index < _additionalImagesBase64.length) {
      //_additionalImagesUrls.removeAt(index-1);
      _additionalImagesBase64.removeAt(index);
    }
  }



  void removeUrlImage(int index) {
    if (index >= 0 && index < _additionalImagesUrls.length) {
      _additionalImagesUrls.removeAt(index);
    }
  }

  void removeThumbnail() {
    _videoThumnail.value = '';
  }

  void removeVideo() {
    removeThumbnail();
    _videoBase64.value = '';
  }



  // Add these setter methods
  void setCoverPhoto(String value) {
    if (value.startsWith('data:image')) {
      _imageBase64.value = value;
      _imageUrl.value = '';
    } else {
      _imageUrl.value = value;
      _imageBase64.value = '';
    }
  }

  void setAdditionalImages(List<String> values) {
    _additionalImagesUrls.assignAll(values);
  }

  void setVideo(String value) {
    videoPickerAndBase64Conversion( videoUrl:  value);
  }


}
