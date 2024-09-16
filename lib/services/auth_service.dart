// import 'package:flutter/rendering.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:karmalab_assignment/constants/network_constants.dart';
import 'package:karmalab_assignment/controllers/base_controller.dart';
import 'package:karmalab_assignment/helper/dialog_helper.dart';
import 'package:karmalab_assignment/services/base/auth_client.dart';
import 'package:karmalab_assignment/services/shared_pref_service.dart';

import '../controllers/user_controller.dart';
import '../models/user_model.dart';

class AuthService extends BaseController {
  final SharedPrefService _prefService = SharedPrefService();

  final BaseClient _baseClient = BaseClient();
  UserController userController = Get.find<UserController>();

// !! Register method
  Future<User?> register(dynamic object) async {
    try {
      var response = await _baseClient.post(
        NetworkConstants.registerAPI,
        object,
        header: {'Content-Type': "application/json"},
      ).catchError(handleError);

      // Ensure result is not null and parse the response
      if (response != null && response.containsKey('data')) {
        var data = response['data'];

        User fetchedUser = userFromJson(jsonEncode(data));
        userController.setUser(fetchedUser);
        await _prefService.saveUser(fetchedUser);
        return fetchedUser;
      }
    } catch (e) {
      print('Error during registration: $e');
    }
    return null;
  }

  Future<User?> login(dynamic object) async {
    try {
      var response = await _baseClient.post(
        NetworkConstants.loginAPI,
        object,
        header: {'Content-Type': "application/json"},
      ).catchError(handleError);
      if (response != null && response.containsKey('data')) {
        var data = response['data'];
        print(data);
        User fetchedUser = userFromJson(jsonEncode(data));
        userController.setUser(fetchedUser);
        print(fetchedUser.email);
        await _prefService.saveUser(fetchedUser);

        return fetchedUser;
      }
    } catch (e) {
      print('Error during login: $e');
    }
    return null;
  }





  //Google sign in:

  final GoogleSignIn _googleSignIn = GoogleSignIn();


  Future<User?> signInWithGoogle() async {
    try {
      // Attempt to sign in the user with Google
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        print('Google Sign In cancelled by user.');
        return null;
      }

      // Get authentication information from the signed-in Google account
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      print('Google Sign-In successful. ID Token: ${googleAuth.idToken}');

      // Send Google authentication data to your server via API
      var response = await BaseClient().get(
        NetworkConstants.googleAuth,
        header: {
          'user-agent': 'flutter',
          'Content-Type': "application/json",
          // 'Authorization': 'Bearer ${googleAuth.idToken}',
        },
      );

      if (response != null && response.containsKey('data')) {
        var data = response['data'];
        print('API call successful. Data received: $data');

        // Parse the user data and store it locally
        User fetchedUser = User.fromJson(data);
        UserController userController = Get.find();
        userController.setUser(fetchedUser);

        SharedPrefService prefService = SharedPrefService();
        await prefService.saveUser(fetchedUser);

        return fetchedUser;
      } else {
        print('API response does not contain "data" key or is null.');
        throw Exception('Invalid API response');
      }
    } on Exception catch (e, stackTrace) {
      print('Error during Google Sign In: $e');
      print('Stack trace: $stackTrace');
      return null;
    }
  }

  // final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  //
  // Future<User?> signInWithGoogle() async {
  //   try {
  //     // Construct the URL for Google authentication
  //     final googleAuthUrl = NetworkConstants.googleAuth;
  //
  //     // Start the Google Sign-In process
  //     final result = await FlutterWebAuth.authenticate(
  //       url: "https://baburhaatbd.com/api/auth/google?redirect_uri=${Uri.encodeComponent("https://baburhaatbd.com/api/auth/google/callback")}",
  //       callbackUrlScheme: "https", // Ensure this matches your callback URL scheme
  //     );
  //     // Extract the auth token from the redirect URL
  //     final token = Uri.parse(result).queryParameters['token'];
  //
  //     if (token == null) {
  //       print('No token received from Google authentication.');
  //       return null;
  //     }
  //
  //     print('Google Sign-In successful. Fetching user data...');
  //
  //     // Use the token to get user data
  //     var response = await BaseClient().get(
  //       NetworkConstants.googleSuccess,
  //       header: {
  //         'Content-Type': "application/json",
  //         'Authorization': 'Bearer $token',
  //       },
  //     );
  //
  //     if (response != null && response.containsKey('data')) {
  //       var data = response['data'];
  //       print('API call successful. Data received: $data');
  //
  //       // Parse the user data and store it locally
  //       User fetchedUser = User.fromJson(data);
  //       UserController userController = Get.find();
  //       userController.setUser(fetchedUser);
  //
  //       SharedPrefService prefService = SharedPrefService();
  //       await prefService.saveUser(fetchedUser);
  //
  //       return fetchedUser;
  //     } else {
  //       print('API response does not contain "data" key or is null.');
  //       throw Exception('Invalid API response');
  //     }
  //   } on Exception catch (e, stackTrace) {
  //     print('Error during Google Sign In process: $e');
  //     print('Stack trace: $stackTrace');
  //     return null;
  //   }
  // }


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
  Future<User?> verifyOtp(dynamic object) async {
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

        User fetchedUser = User.fromJson(data);
        userController.setUser(fetchedUser);
        print("VerifyOtp fetchedUser: $fetchedUser"); // Debug print
        await _prefService.saveUser(fetchedUser);

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
      NetworkConstants.resetPassApi,
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
