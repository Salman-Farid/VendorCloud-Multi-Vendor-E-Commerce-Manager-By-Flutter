import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:karmalab_assignment/models/category_model.dart';
import '../../../constants/colors.dart';
import '../../utils/route_util.dart';
import '../category/category_management_screen.dart';
import '../eventManager/event_mangement.dart';
import '../product/all_products.dart';
import '../product/product_upload_screen.dart';
import '../review/product_review.dart';
import '../../controllers/dashboard_controller.dart';

class DashboardScreen extends StatelessWidget {
  static const routeName = "/dashboard";
  DashboardScreen({Key? key}) : super(key: key);

  final DashboardController controller = Get.put(DashboardController());
  final List<Map<String, dynamic>> menuList = [
    {
      'title': 'Manage Products',
      'animationUrl': 'assets/images/lottie/manage_prod.json',
      'routeName': ProductGridView.routeName
    },
    {
      'title': 'Upload Products',
      'animationUrl': 'assets/images/lottie/upload.json',
      'routeName': ProductCreationScreen.routeName
    },
    {
      'title': 'Category',
      'animationUrl': 'assets/images/lottie/category.json',
      'routeName': CategorySubcategoryView.routeName
    },
    {
      'title': 'Finance',
      'animationUrl': 'assets/images/lottie/finance.json',
      'routeName': '/Finance'
    },
    {
      'title': 'Event Management',
      'animationUrl': 'assets/images/lottie/event.json',
      'routeName': EventManagementScreen.routeName
    },
    {
      'title': 'AD Management',
      'animationUrl': 'assets/images/lottie/advertise.json',
      'routeName': '/ad'
    },
    {
      'title': 'Review',
      'animationUrl': 'assets/images/lottie/reviews.json',
      'routeName': ProductReviewScreen.routeName
    },
    {
      'title': 'Report',
      'animationUrl': 'assets/images/lottie/Reports.json',
      'routeName': '/report'
    },
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height*1.2,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.blue.shade50],
          ),
        ),
        child: SafeArea(
          child: GetBuilder<DashboardController>(
            builder: (controller) {
              return AnimatedBuilder(
                animation: controller.animationController!,
                builder: (context, child) {
                  return Opacity(
                    opacity: controller.opacityAnimation!.value,
                    child: Transform.scale(
                      scale: controller.scaleAnimation!.value,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 0),
                        child: Column(
                          children: [
                            const Center(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.dashboard,
                                    color: primaryColor,
                                    size: 32,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Dashboard',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 28,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),
                            Expanded(
                              child: GridView.builder(
                                padding: const EdgeInsets.all(10),
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 16,
                                  childAspectRatio: 1,
                                ),
                                itemCount: menuList.length,
                                itemBuilder: (context, index) => _buildMenuItem(context, menuList[index]),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
  Widget _buildMenuItem(BuildContext context, Map<String, dynamic> item) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: InkWell(
        onTap: () => Get.toNamed(item['routeName']),
        borderRadius: BorderRadius.circular(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              item['animationUrl'],
              width: 110,
              height: 110,
              fit: BoxFit.cover,
            ),
            Text(
              item['title'],
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}