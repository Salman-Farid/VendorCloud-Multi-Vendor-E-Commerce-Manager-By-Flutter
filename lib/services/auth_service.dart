// import 'package:flutter/rendering.dart';
import 'dart:convert';
import 'package:uni_links/uni_links.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:karmalab_assignment/constants/network_constants.dart';
import 'package:karmalab_assignment/services/base/auth_client.dart';
import 'package:karmalab_assignment/services/shared_pref_service.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/base_controller.dart';
import '../controllers/user_controller.dart';
import '../models/user_model.dart';
import '../screens/mainScreen/mainscreen.dart';
import 'hive_service.dart';

class AuthService extends BaseController {
  final SharedPrefService _prefService = SharedPrefService();

  final BaseClient _baseClient = BaseClient();
  UserController userController = Get.find<UserController>();
  final HiveService _hiveService = HiveService();

// !! Register method
  Future<UserModel?> register(dynamic object) async {
    try {
      var response = await _baseClient.post(
        NetworkConstants.registerAPI,
        object,
        header: {'Content-Type': "application/json"},
      ).catchError(handleError);

      // Ensure result is not null and parse the response
      if (response != null && response.containsKey('data')) {
        var data = response['data'];

        UserModel fetchedUser = UserModel.fromJson(data);
        userController.setUser(fetchedUser);
        await _prefService.saveUser(fetchedUser);
        return fetchedUser;
      }
    } catch (e) {
      print('Error during registration: $e');
    }
    return null;
  }

  Future<UserModel?> login(dynamic object) async {
    try {
      var response = await _baseClient.post(
        NetworkConstants.loginAPI,
        object,
        header: {'Content-Type': "application/json"},
      ).catchError(handleError);
      if (response != null && response.containsKey('data')) {
        var data = response['data'];
        UserModel fetchedUser = UserModel.fromJson(data);
        await _hiveService.saveUser(fetchedUser);
        userController.setUser(fetchedUser);
        return fetchedUser;
      }
    } catch (e) {}
    return null;
  }





  //Google sign in:









// !! send otp
  Future<bool> sentOtp(dynamic object) async {
    try {
      var result = await _baseClient.post(
        NetworkConstants.sendOtp,
        object,
        header: {'Content-Type': "application/json"},
      ).catchError(handleError);

      if (result != null && result is Map<String, dynamic>) {
        if (result.containsKey("data") &&
            result["data"] is Map<String, dynamic> &&
            result["data"].containsKey("hash")) {
          final hash = result["data"]["hash"];

          // Save the hash using the _prefService
          await _prefService.saveHash(hash);
          print("Hash saved successfully: $hash");

          return true;
        } else {
          print("Response doesn't contain expected 'data' or 'hash' fields");
          return false;
        }
      } else {
        print("Invalid or null result received from API");
        return false;
      }
    } catch (e) {
      print("Error in sentOtp: $e");
      return false;
    }
  }



  // !! verify otp
  Future<UserModel?> verifyOtp(dynamic object) async {
    try {
      var response = await _baseClient.post(
        NetworkConstants.verifyOtp,
        object,
        header: {'Content-Type': "application/json"},
      ).catchError(handleError);

      print("VerifyOtp raw response: $response"); // Debug print

      if (response != null && response.containsKey('data')) {
        var data = response['data'];
        print("VerifyOtp data: $data"); // Debug print

        UserModel fetchedUser = UserModel.fromJson(data);
        userController.setUser(fetchedUser);
        await _hiveService.saveUser(fetchedUser);

        return fetchedUser;
      } else {
        print("VerifyOtp: 'data' key not found in response"); // Debug print
      }
    } catch (e) {
      print('Error during OTP verification: $e'); // Debug print
    }
    return null;
  }



  //  resetPassword
  Future<bool> resetPassword(dynamic object) async {
    debugPrint("new token");
    debugPrint(object.toString());

    debugPrint(await _prefService.getToken());
    var token = await _prefService.getToken();
    var result = await _baseClient.post(
      NetworkConstants.resetPassword,
      object,
      header: {
        'Content-Type': "application/json",
        'Authorization': "Token $token"
      },
    ).catchError(handleError);
    debugPrint(result.toString());

    if (result != null) {
      result = json.decode(result);
      debugPrint("reset password");
      debugPrint(result.toString());

      return true;
    } else {
      return false;
    }
  }

  // Fetch the current user's data
  Future<Map<String, dynamic>?> fetchCurrentUser() async {
    try {
      final token = await _prefService.getToken();
      if (token == null) {
        throw Exception("No token found. User might not be logged in.");
      }

      final result = await _baseClient.get(
        NetworkConstants.getMe,
        header: {
          'Authorization': 'Token $token',
        },
      ).catchError(handleError);

      if (result != null) {
        return json.decode(result);
      }
    } catch (e) {
      debugPrint("Error fetching user data: $e");
    }
    return null;
  }
}
