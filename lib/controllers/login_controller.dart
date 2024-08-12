import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karmalab_assignment/services/auth_service.dart';
import 'package:karmalab_assignment/services/base/app_exceptions.dart';
import 'package:karmalab_assignment/services/shared_pref_service.dart';
import 'package:karmalab_assignment/views/authentication/select_auth/select_auth_view.dart';
import '../models/user_model.dart';





class LoginController extends GetxController {
  final SharedPrefService _sharedPrefService = SharedPrefService();
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();

  // controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  final _loading = false.obs;

  var isPasswordVisible = false.obs;
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }
  // ?? getters
  GlobalKey get formKey => _formKey;
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;

  bool get loading => _loading.value;

// validate login form
  bool validate() {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(_emailController.text);

    try {
      if (
          _emailController.text == "" ||
          passwordController.text == "") {
        throw InvalidException("please fill all given inputs !!", false);
      } else {
        if (emailValid) {
          if (passwordController.text.length >= 8) {
            return true;
          } else {
            throw InvalidException("password must be greater than 8 !!", false);
          }
        } else {
          throw InvalidException("Email is not valid !!", false);
        }
      }
    } catch (e) {
      return false;
    }
  }

  Future<void> login(Function(User?)? onLogin) async {
    final valid = validate();
    if (valid) {
      _loading.value = true;
      await Future.delayed(const Duration(seconds: 2));
      // Perform login
      User? user = await _authService.login(
        {
          "email": _emailController.text,
          "password": _passwordController.text,
        },
      );
      _loading.value = false;
      await Future.delayed(const Duration(milliseconds: 300));
      onLogin!(user);
    }
  }

  // ignore: logout method
  void logout() {
    _sharedPrefService.clear();
    Get.offNamedUntil(
      SelectAuthView.routeName,
      (_) => false,
    );
    // Get.offAndToNamed(SelectAuthView.routeName);
  }
}
