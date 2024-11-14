import 'package:flutter/material.dart';
import 'package:karmalab_assignment/constants/color_constants.dart';
import 'package:karmalab_assignment/constants/image_constants.dart';
import 'package:karmalab_assignment/constants/size_constants.dart';
import 'package:karmalab_assignment/utils/dimension.dart';
import 'package:karmalab_assignment/widgets/custom_button.dart';
import '../login/login_view.dart';
import '../siginup/signup_view.dart';

class SelectAuthView extends StatelessWidget {
  const SelectAuthView({super.key});

  static const String routeName = "/selectAuth";

  // Constants to avoid magic numbers
  static const double _contentPaddingHorizontal = 60;
  static const double _titleFontSizeRatio = 6;
  static const double _descriptionFontSizeRatio = 4.2;
  static const double _buttonSpacing = 15;
  static const double _contentSpacing = 50;

  void _navigateToScreen(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      "Grow Your Business\nWith Easy Selling",
      style: Theme.of(context)
          .textTheme
          .titleLarge
          ?.copyWith(fontSize: context.getWidth(_titleFontSizeRatio)),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Text(
      "Join thousands of successful vendors managing their online stores with us",
      style: Theme.of(context)
          .textTheme
          .displayLarge
          ?.copyWith(fontSize: context.getWidth(_descriptionFontSizeRatio)),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildAuthButtons(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomButton(
          label: "Sign In as Vendor",
          onTap: () => _navigateToScreen(context, LoginView.routeName),
        ),
        const SizedBox(height: _buttonSpacing),
        CustomButton(
          isFilled: false,
          label: "Create Vendor Account",
          onTap: () => _navigateToScreen(context, SignUpView.routeName),
        ),
      ],
    );
  }

  Widget _buildBanner() {
    return Image.asset(
      AppImages.authSelection,
      width: AppSizes.onboardingImageSize,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: _contentPaddingHorizontal,
            ),
            child: Column(
              children: [
                const SizedBox(height: 100),
                _buildBanner(),
                const SizedBox(height: 60),
                _buildTitle(context),
                const SizedBox(height: _buttonSpacing),
                _buildDescription(context),
                const SizedBox(height: _contentSpacing),
                _buildAuthButtons(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}