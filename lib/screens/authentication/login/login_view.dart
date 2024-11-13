import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:karmalab_assignment/constants/color_constants.dart';
import 'package:karmalab_assignment/constants/size_constants.dart';
import 'package:karmalab_assignment/controllers/login_controller.dart';
import 'package:karmalab_assignment/widgets/custom_button.dart';
import 'package:karmalab_assignment/widgets/fancy2_text.dart';
import 'package:karmalab_assignment/widgets/social_media_log.dart';
import 'package:get/get.dart';
import 'package:karmalab_assignment/widgets/custom_form.dart';
import '../widget/auth_header.dart';


class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  static const routeName = '/login';
  final LoginController _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const AuthHeader(
                  subTitle: "Sign In To Your Account",
                  title: "Sign In",
                ),
                const SizedBox(height: 30),
                _buildLoginModeToggle(),
                const SizedBox(height: 30),
                Obx(() => CustomForm(
                  controller: _loginController,
                  isLogin: true,
                  isEmailLogin: _loginController.isEmailLogin,
                )),
                const SizedBox(height: 20),
                Fancy2Text(
                  first: "Forgot password? ",
                  second: "Reset",
                  onTap: () => Get.toNamed('/forgot-password'),
                ),
                const SizedBox(height: 32),
                Obx(() =>
                    CustomButton(
                  label: _loginController.isEmailLogin
                      ? "Sign In"
                      : _loginController.otpValue.isNotEmpty
                      ? "Verify OTP"
                      : "Send OTP",
                  isLoading: _loginController.loading,
                  onTap: _loginController.login,
                )),
                const SizedBox(height: 15),
                Fancy2Text(
                  first: "Don't have an account? ",
                  second: " Sign Up",
                  isCenter: true,
                  onTap: () => Get.toNamed('/sign-up'),
                ),
                const SizedBox(height: 50),
                // SocialMediaAuthArea(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginModeToggle() {
    return Obx(() => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildToggleButton("Email", _loginController.isEmailLogin, () => _loginController.toggleLoginMode(true)),
        const SizedBox(width: 16),
        _buildToggleButton("Phone", !_loginController.isEmailLogin, () => _loginController.toggleLoginMode(false)),
      ],
    ));
  }

  Widget _buildToggleButton(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.lightBlue : AppColors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.lightBlue),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? AppColors.white : AppColors.lightBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}