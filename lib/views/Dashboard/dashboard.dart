import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:karmalab_assignment/models/category_model.dart';
import '../../../constants/colors.dart';
import '../../utils/route_util.dart';
import '../category/category_management_screen.dart';
import '../eventManager/event_mangement.dart';
import '../product/all_products.dart';
import '../product/product_upload_screen.dart';
import '../review/product_review.dart';

// Add other import statements for the respective screens

class DashboardScreen extends StatelessWidget {
  static const routeName = "/dashboard";
  DashboardScreen({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> menuList = [
    {'title': 'Manage Products', 'icon': Icons.storefront, 'routeName': ProductGridView.routeName},
    {'title': 'Upload Products', 'icon': Icons.upload, 'routeName': ProductCreationScreen.routeName},
    {'title': 'Category', 'icon': Icons.category_outlined, 'routeName': CategorySubcategoryView.routeName}, // Add your category route
    {'title': 'Finance', 'icon': Icons.insert_chart, 'routeName': '/Finance'},
    //{'title': 'Account/Balance', 'icon': Icons.monetization_on, 'routeName': '/account'},
    {'title': 'Event Management', 'icon': Icons.event, 'routeName':EventManagementScreen.routeName},
    {'title': 'AD Management', 'icon': Icons.ad_units, 'routeName': '/ad'},
    {'title': 'Review', 'icon': Icons.reviews_outlined, 'routeName': ProductReviewScreen.routeName},
    {'title': 'Report', 'icon': Icons.report, 'routeName': '/report'},

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.blue.shade50],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 16.0),
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
        onTap:   ()=> Get.toNamed(item['routeName']),
        // onTap: () {
        //   // Navigate to the corresponding screen using routeName
        //   Navigator.of(context).pushNamed(item['routeName']);
        // },
        borderRadius: BorderRadius.circular(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              item['icon'],
              size: 48,
              color: primaryColor,
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                item['title'],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
