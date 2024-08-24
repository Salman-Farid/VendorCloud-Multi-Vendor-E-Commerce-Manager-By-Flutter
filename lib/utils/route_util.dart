import 'package:get/get.dart';
import 'package:karmalab_assignment/views/authentication/forgot/forgot_password.dart';
import 'package:karmalab_assignment/views/authentication/login/login_view.dart';
import 'package:karmalab_assignment/views/authentication/new_password/new_password.dart';
import 'package:karmalab_assignment/views/authentication/select_auth/select_auth_view.dart';
import 'package:karmalab_assignment/views/authentication/siginup/signup_view.dart';
import 'package:karmalab_assignment/views/authentication/verification/verification_view.dart';
import 'package:karmalab_assignment/views/profile/profile_view.dart';
import 'package:karmalab_assignment/views/onboarding/onboarding_view.dart';
import 'package:karmalab_assignment/views/splash/splash_view.dart';
import '../controllers/EventManagementController.dart';
import '../controllers/category_controller.dart';
import '../controllers/product_controller.dart';
import '../views/Dashboard/dashboard.dart';
import '../views/category/category_creation_screen.dart';
import '../views/category/category_management_screen.dart';
import '../views/eventManager/event_mangement.dart';
import '../views/home/home.dart';
import '../views/mainScreen/mainscreen.dart';
import '../views/order_management/orderlist_screen.dart';
import '../views/product/all_products.dart';
import '../views/product/product_upload_screen.dart';
import '../views/review/product_review.dart';
import 'Bindings/category_bindings.dart';
import 'Bindings/fetchProductBindings.dart';
import 'Bindings/orderlist_binding.dart';
import 'Bindings/product_creation_screen_binding.dart';

class RouteUtil {
  static final routes = [
    GetPage(name: SplashView.routeName, page: () => const SplashView()),
    GetPage(name: OnboardingView.routeName, page: () => const OnboardingView()),
    GetPage(name: SelectAuthView.routeName, page: () => const SelectAuthView()),
    GetPage(name: SignUpView.routeName, page: () => SignUpView()),
    GetPage(name: LoginView.routeName, page: () => const LoginView()),
    GetPage(name: ForgotPassWord.routeName, page: () => const ForgotPassWord()),
    GetPage(name: VerificationView.routeName, page: () => const VerificationView()),
    GetPage(name: Profile.routeName, page: () => Profile()),
    GetPage(name: ProductCreationScreen.routeName, page: () => ProductCreationScreen(), binding: ProductCreationScreenBinding(),),
    GetPage(name: ProductGridView.routeName, page: () => ProductGridView(), binding: Fetchproductbindings(),),
    GetPage(name: CategorySubcategoryView.routeName, page: () => CategorySubcategoryView(), binding: FetchCategorybindings(),),
    GetPage(name: CategoryCreationScreen.routeName, page: () => CategoryCreationScreen(), binding: BindingsBuilder(() {Get.lazyPut<CategoryController>(() => CategoryController());}),),
    GetPage(name: EventManagementScreen.routeName, page: () => EventManagementScreen()),//binding: BindingsBuilder(() {Get.lazyPut<EventManagementController>(() => EventManagementController());}),),
    GetPage(name: OrderListScreen.routeName, page: () => OrderListScreen(), binding: OrderlistBinding(),),
    GetPage(name: MainScreen.routeName, page: () =>  MainScreen()),
    GetPage(name: HomeScreen.routeName, page: () =>  HomeScreen()),
    GetPage(name: DashboardScreen.routeName, page: () =>  DashboardScreen()),
    GetPage(name: NewPassWordView.routeName, page: () => const NewPassWordView()),
    GetPage(name: ProductReviewScreen.routeName, page: () => ProductReviewScreen()),
  ];
}
