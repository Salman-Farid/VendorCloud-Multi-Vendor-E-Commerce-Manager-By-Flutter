import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karmalab_assignment/widgets/custom_input.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CustomForm extends StatelessWidget {
 final dynamic controller;
  final bool isLogin;
  final bool isEmailLogin;

  const CustomForm({
    Key? key,
    required this.controller,
    required this.isLogin,
    required this.isEmailLogin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!isLogin)
          CustomInputFelid(
            hint: "Business Name",
            controller: controller.nameTextController,
          ),
        if (isLogin)
          CustomInputFelid(
            hint: isEmailLogin ? "Email" : "Phone Number",
            controller: isEmailLogin ? controller.emailController : controller.phoneController,
            keyboardType: isEmailLogin ? TextInputType.emailAddress : TextInputType.phone,
          )
        else
          CustomInputFelid(
            hint: "Email",
            controller: controller.emailController,
            keyboardType: TextInputType.emailAddress,
          ),
        if (isEmailLogin && isLogin)
          Obx(() => CustomInputFelid(
            hint: "Password",
            controller: controller.passwordController,
            isPassWord: true,
            secure: controller.isPasswordVisible,
            toggle: controller.togglePasswordVisibility,
          )),
        if (isLogin && !isEmailLogin)
          Padding(
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
              onCompleted: (v) {
                controller.updateOtpValue(v); // Update the OTP value in the controller
              },
              onChanged: (value) {
                controller.updateOtpValue(value);
              },
              beforeTextPaste: (text) {
                return true;
              },
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              keyboardType: TextInputType.number,
            ),
          ),



        if (!isLogin)
          Obx(() => CustomInputFelid(
            hint: "Password",
            controller: controller.passwordController,
            isPassWord: true,
            secure: controller.isPasswordVisible,
            toggle: controller.togglePasswordVisibility,
          )),
        if (!isLogin)
          Obx(() => CustomInputFelid(
            hint: "Confirm Password",
            controller: controller.confirmPasswordController,
            isPassWord: true,
            secure: controller.isConfirmPasswordVisible,
            lowerMargin: true,
            toggle: controller.toggleConfirmPasswordVisibility,
          )),
      ],
    );
  }
}
