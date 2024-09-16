import 'dart:convert';
import 'package:karmalab_assignment/views/profile/profile_view.dart';
import 'package:karmalab_assignment/views/onboarding/onboarding_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../views/home/home.dart';



class SharedPrefService {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();






  Future<void> saveSessionId(String sessionId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('session_id', sessionId);
  }

  Future<String?> getSessionId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('session_id');
  }

  Future<void> clearSessionId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('session_id');
  }


// Method to save the hash value in SharedPreferences
  Future<void> saveHash(String hash) async {
    final prefs = await SharedPreferences.getInstance();
    // Save the hash value under the key 'hash'
    bool result = await prefs.setString('hash', hash);

    // Optionally, add a debug statement to check if saving was successful
    if (result) {
      print("Hash saved successfully.");
    } else {
      print("Failed to save hash.");
    }
  }

// Method to get the hash value from SharedPreferences
  Future<String?> getHash() async {
    final prefs = await SharedPreferences.getInstance();
    // Retrieve the hash value stored under the key 'hash'
    String? hash = prefs.getString('hash');

    // Optionally, add a debug statement to check the retrieved hash value
    if (hash != null) {
      print("Retrieved hash: $hash");
    } else {
      print("No hash found in storage.");
    }

    return hash;
  }



  Future<void> saveUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userJson = jsonEncode(user.toJson());
    print('Saving User: $userJson');  // Debugging statement
    await prefs.setString('user', userJson);
  }

  Future<User?> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user');
    if (userJson != null) {
      print('Retrieved User JSON: $userJson');  // Debugging statement
      return User.fromJson(jsonDecode(userJson));
    }
    print('No user data found in SharedPreferences');  // Debugging statement
    return null;
  }




  void userLog({String? email, String? id, int? otp}) async {
    SharedPreferences pref = await _prefs;
    pref.setBool("login", true);
    pref.setString("email", email ?? "email");
    pref.setString("id", id?? "0");
    pref.setInt("otp", otp ?? 0);
  }

  Future<String> start() async {
    SharedPreferences pref = await _prefs;

    var status = pref.getString("email");
    if (status == null) {
      pref.setBool("login", false);
    }

    return status != null ? Profile.routeName : OnboardingView.routeName;
  }


  Future<void> forgotPassCred({String? token, int? otp}) async {
    SharedPreferences pref = await _prefs;
    // ? simulate delay
    await Future.delayed(const Duration(seconds: 0));

    pref.setInt("otp", otp ?? 0);
    pref.setString("token", token ?? "");
  }

  Future<String?> getToken() async {
    SharedPreferences pref = await _prefs;
    return pref.getString("token");
  }

  Future<void> updateToken(String? token) async {
    SharedPreferences pref = await _prefs;
    pref.setString("token", token ?? "");
  }

  void clear() async {
    SharedPreferences pref = await _prefs;
    pref.setBool("login", false);
    pref.remove("email");
    pref.remove("id");
    pref.remove("otp");
  }
}
