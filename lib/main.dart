import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karmalab_assignment/theme/theme.dart';
import 'package:karmalab_assignment/utils/route_util.dart';
import 'package:karmalab_assignment/views/authentication/select_auth/select_auth_view.dart';
import 'controllers/user_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(UserController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Auth_by_getx_rest_api',
      initialRoute: SelectAuthView.routeName,
      getPages: RouteUtil.routes,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme(),
    );
  }
}
