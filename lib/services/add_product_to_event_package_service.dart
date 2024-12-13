import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karmalab_assignment/models/product_model.dart';
import 'package:karmalab_assignment/services/shared_pref_service.dart';

import '../constants/network_constants.dart';
import 'base/auth_client.dart';

class EventProductRepository {
  final _baseClient = BaseClient();
  final SharedPrefService _prefService = SharedPrefService();

  Future<bool> addProductToEvent(Map<String, dynamic> eventProductData) async {
    try {
      final sessionId = await _prefService.getSessionId();
      final response = await _baseClient.post(
        NetworkConstants.createEventProduct,
        eventProductData,
        header: {
          'Cookie': "connect.sid=$sessionId",
          'Content-Type': "application/json",
        },
      );
      return response['body'] != null && response['body'].containsKey('data');
    } catch (e) {
      return false;
    }
  }
  Future<bool> addProductToPackage(Map<String, dynamic> eventProductData) async {
    try {
      final sessionId = await _prefService.getSessionId();
      final response = await _baseClient.post(
        NetworkConstants.createPackageProduct,
        eventProductData,
        header: {
          'Cookie': "connect.sid=$sessionId",
          'Content-Type': "application/json",
        },
      );
      return response['body'] != null && response['body'].containsKey('data');
    } catch (e) {
      return false;
    }
  }
  Future<bool> deleteEventProduct(String eventProductId) async {
    try {
      final sessionId = await _prefService.getSessionId();
      await _baseClient.delete(
        NetworkConstants.deleteEventProductById(eventProductId),
        header: {'Cookie': "connect.sid=$sessionId"},
      );
      return true;
    } catch (e) {
      return false;
    }
  }
  Future<bool> deletePackageProduct(String eventProductId) async {
    try {
      final sessionId = await _prefService.getSessionId();
      await _baseClient.delete(
        NetworkConstants.deleteEventProductById(eventProductId),
        header: {'Cookie': "connect.sid=$sessionId"},
      );
      return true;
    } catch (e) {
      return false;
    }
  }



  // Future<allProduct?> getEventProducts() async {
  //   try {
  //     final sessionId = await _prefService.getSessionId();
  //     final response = await _baseClient.get(
  //       NetworkConstants.getAllEventProducts(1, 10),
  //       header: {'Cookie': "connect.sid=$sessionId"},
  //     );
  //
  //     if (response['body'] != null && response['body']['data'] != null) {
  //       // Assuming `response['body']['data']` contains a single product's JSON data
  //       return allProduct.fromJson(response['body']);
  //     }
  //     return null;
  //   } catch (e) {return null;}
  // }
  Future<allProduct?> getEventProducts() async {
    try {
      final sessionId = await _prefService.getSessionId();
      final response = await _baseClient.get(
        NetworkConstants.getAllEventProducts(1, 10),
        header: {'Cookie': "connect.sid=$sessionId"},
      );
      if (response['body'] != null && response['body']['data'] != null) {
        // Assuming `response['body']['data']` contains a single product's JSON data
        return allProduct.fromJson(response['body']);
      }
      return null;
    } catch (e) {
      debugPrint('Error fetching event products: $e');
      Get.snackbar('Error', e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.transparent,
        colorText: Colors.black,
        //duration: Duration(seconds: 3),
      );
      return null;
    }
  }

}
