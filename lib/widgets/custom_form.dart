import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karmalab_assignment/widgets/custom_input.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CustomForm extends StatelessWidget {
  final dynamic controller;
  final bool isLogin;
  final bool isEmailLogin;

  const CustomForm({
    super.key,
    required this.controller,
    required this.isLogin,
    required this.isEmailLogin,
  });

  Widget _buildNameField() {
    return CustomInputFelid(
      hint: "Business Name",
      controller: controller.nameTextController,
    );
  }

  Widget _buildLoginField() {
    return CustomInputFelid(
      hint: isEmailLogin ? "Email" : "Phone Number",
      controller: isEmailLogin ? controller.emailController : controller.phoneController,
      keyboardType: isEmailLogin ? TextInputType.emailAddress : TextInputType.phone,
    );
  }

  Widget _buildEmailField() {
    return CustomInputFelid(
      hint: "Email",
      controller: controller.emailController,
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget _buildPasswordField() {
    return Obx(() => CustomInputFelid(
      hint: "Password",
      controller: controller.passwordController,
      isPassWord: true,
      secure: !controller.isPasswordVisible,  // Add .value here
      toggle: controller.togglePasswordVisibility,
    ));
  }

  Widget _buildConfirmPasswordField() {
    return Obx(() => CustomInputFelid(
      hint: "Confirm Password",
      controller: controller.conformPasswordController,
      isPassWord: true,
      secure: !controller.isConformPasswordVisible,  // Add .value here
      lowerMargin: true,
      toggle: controller.toggleConformPasswordVisibility,
    ));
  }


  Widget _buildOtpField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: PinCodeTextField(
        appContext: context,
        length: 4,
        obscureText: false,
        animationType: AnimationType.fade,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 50,
          fieldWidth: 40,
          activeFillColor: Colors.white,
          inactiveFillColor: Colors.grey[100],
          selectedFillColor: Colors.white,
          activeColor: Colors.blue,
          inactiveColor: Colors.grey,
          selectedColor: Colors.blue,
        ),
        animationDuration: const Duration(milliseconds: 300),
        backgroundColor: Colors.transparent,
        enableActiveFill: true,
        onCompleted: controller.updateOtpValue,
        onChanged: controller.updateOtpValue,
        beforeTextPaste: (_) => true,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        keyboardType: TextInputType.number,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!isLogin) _buildNameField(),
        if (isLogin)
          _buildLoginField()
        else
          _buildEmailField(),
        if (isEmailLogin && isLogin) _buildPasswordField(),
        if (isLogin && !isEmailLogin) _buildOtpField(context),
        if (!isLogin) ...[
          _buildPasswordField(),
          _buildConfirmPasswordField(),
        ],
      ],
    );
  }
}