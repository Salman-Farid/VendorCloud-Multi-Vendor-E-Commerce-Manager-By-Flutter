import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karmalab_assignment/controllers/category_controller.dart';
import 'package:karmalab_assignment/screens/authentication/select_auth/select_auth_view.dart';
import 'package:karmalab_assignment/services/ad_package_service.dart';
import 'package:karmalab_assignment/services/hive_service.dart';
import 'package:karmalab_assignment/services/review_services.dart';
import 'package:karmalab_assignment/theme/theme.dart';
import 'package:karmalab_assignment/utils/route_util.dart';
import 'constants/network_constants.dart';
import 'controllers/event_ad_management_controller.dart';
import 'controllers/event_product_controller.dart';
import 'controllers/mainscreen_controller.dart';
import 'controllers/order_controller.dart';
import 'controllers/product_controller.dart';
import 'controllers/review_controller.dart';
import 'controllers/user_controller.dart';
import 'models/event_model.dart';
import 'models/pachakge_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final hiveService = HiveService();
  await hiveService.init();
  Get.put(hiveService);
  Get.put(UserController());

  // Initialize repositories with print statements
  final packageRepository = GenericRepository<Package>(
      fromJson: (json) => PackageModel.fromJson(json),
      endpoint: NetworkConstants.getAllPackages(1, 10)
  );

  final eventRepository = GenericRepository<Event>(
      fromJson: (json) => EventModel.fromJson(json),
      endpoint: NetworkConstants.getAllEvents(1, 10)
  );

  // Initialize controllers with explicit IDs
  final packageController = GenericController<Package>(packageRepository, isPackageScreen: true);
  final eventController = GenericController<Event>(eventRepository, isPackageScreen: false);

  // Put controllers with explicit initialization
  Get.put(packageController, tag: 'package', permanent: true);
  Get.put(eventController, tag: 'event', permanent: true);

  Get.lazyPut(()=>EventManagementController(),fenix: true);


  print('Controllers initialized');




  Get.lazyPut(()=>ProductController(),fenix: true);
  Get.lazyPut(()=>ProductController(),fenix: true);
  Get.lazyPut(()=>ReviewController(),fenix: true);
  Get.lazyPut(()=>PageController(),fenix: true);
  Get.lazyPut(()=>ReviewRepository(),fenix: true);
  Get.lazyPut(()=>MainController());
  Get.put(UserController());
  Get.lazyPut(()=>CategoryController());
  Get.lazyPut(()=>OrderController());
  //Get.put(DashboardController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // theme: ThemeData(
      //   canvasColor: Colors.white, // Sets the background color of the app
      //   fontFamily: 'Roboto',
      //   primaryColor: primaryColor,

      // ),
      //themeMode: ThemeMode.system,
      title: 'AnyhowVendor',
      initialRoute: SelectAuthView.routeName,
      getPages: RouteUtil.routes,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme(),
    );
  }
}
