import 'package:get/get.dart';
import 'package:karmalab_assignment/views/authentication/forgot/forgot_password.dart';
import 'package:karmalab_assignment/views/authentication/login/login_view.dart';
import 'package:karmalab_assignment/views/authentication/new_password/new_password.dart';
import 'package:karmalab_assignment/views/authentication/select_auth/select_auth_view.dart';
import 'package:karmalab_assignment/views/authentication/siginup/signup_view.dart';
import 'package:karmalab_assignment/views/authentication/verification/verification_view.dart';
import 'package:karmalab_assignment/views/home/home_view.dart';
import 'package:karmalab_assignment/views/onboarding/onboarding_view.dart';
import 'package:karmalab_assignment/views/splash/splash_view.dart';
import '../controllers/product_controller.dart';
import '../views/product/all_products.dart';
import '../views/product/product_upload_screen.dart';
import 'Bindings/fetchProductBindings.dart';
import 'Bindings/product_creation_screen_binding.dart';

class RouteUtil {
  static final routes = [
    GetPage(name: SplashView.routeName, page: () => const SplashView()),
    GetPage(name: OnboardingView.routeName, page: () => const OnboardingView()),
    GetPage(name: SelectAuthView.routeName, page: () => const SelectAuthView()),
    GetPage(name: SignUpView.routeName, page: () => SignUpView()),
    GetPage(name: LoginView.routeName, page: () => const LoginView()),
    GetPage(name: ForgotPassWord.routeName, page: () => const ForgotPassWord()),
    GetPage(
        name: VerificationView.routeName, page: () => const VerificationView()),
    GetPage(name: HomeView.routeName, page: () => HomeView()),
    GetPage(
      name: ProductCreationScreen.routeName,
      page: () => ProductCreationScreen(),
      binding: ProductCreationScreenBinding(),
    ),
    GetPage(
      name: ProductGridView.routeName,
      page: () => ProductGridView(),
      binding: Fetchproductbindings(),

    ),

    GetPage(
        name: NewPassWordView.routeName, page: () => const NewPassWordView()),
  ];
}
