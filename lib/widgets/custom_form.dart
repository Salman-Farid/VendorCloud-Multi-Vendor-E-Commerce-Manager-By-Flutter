import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karmalab_assignment/widgets/custom_input.dart';

Column customForm({
  required dynamic controller, // Can be either LoginController or SignUpController
  required bool isLogin,      // Flag to indicate if it's the login form
}) {
  return Column(
    children: [
      // Conditionally add the "Business Name" field if it's not the login form
      !isLogin
          ? CustomInputFelid(
        hint: "Business Name",
        controller: controller.nameTextController,
      )
          : SizedBox.shrink(),
      CustomInputFelid(
        hint: "Email",
        controller: controller.emailController,
        keyboardType: TextInputType.emailAddress,
      ),
      Obx(() {
        return CustomInputFelid(
          hint: "Password",
          controller: controller.passwordController,
          isPassWord: true,
          secure: controller.isPasswordVisible.value,
          toggle: controller.togglePasswordVisibility,
        );
      }),
      // Conditionally add the "Confirm Password" field if it's not the login form
      !isLogin
          ? Obx(() {
        return CustomInputFelid(
          hint: "Confirm Password",
          controller: controller.conformPasswordController,
          isPassWord: true,
          secure: controller.isConformPasswordVisible.value,
          lowerMargin: true,
          toggle: controller.toggleConformPasswordVisibility,
        );
      })
          : SizedBox.shrink(),
    ],
  );
}
