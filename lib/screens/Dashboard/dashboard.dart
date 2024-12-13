import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../constants/colors.dart';
import '../category/category_management_screen.dart';
import '../eventManager/event_Package_products.dart';
import '../event_ad_management_screen/event_ad_mangement.dart';
import '../finance/vendor_finance.dart';
import '../product/all_products.dart';
import '../product/product_upload_screen.dart';
import '../product_reviews/products_for_review_screen.dart';
import '../report/all_reports.dart';

class DashboardScreen extends StatelessWidget {
  static const routeName = "/dashboard";

  DashboardScreen({Key? key}) : super(key: key);

  static const List<Map<String, dynamic>> _menuList = [
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
      'routeName': FinanceScreen.routeName
    },
    // {
    //   'title': 'Event Management',
    //   'animationUrl': 'assets/images/lottie/event.json',
    //   'routeName': EventManagementScreen.routeName
    // },



    {
      'title': 'Event Management',
      'animationUrl': 'assets/images/lottie/event.json',
      'routeName': Package_EventScreen.eventRouteName
    },




    {
      'title': 'AD Management',
      'animationUrl': 'assets/images/lottie/advertise.json',
      'routeName':Package_EventScreen.packageRouteName
    },
    {
      'title': 'Message Center',
      'animationUrl': 'assets/images/lottie/reviews.json',
      'routeName': ProductsListScreen.routeNameQA
    },
    {
      'title': 'Report',
      'animationUrl': 'assets/images/lottie/Reports.json',
      'routeName': AllReports.routeName
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.white],
          ),
        ),
        child: SafeArea(
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
                    itemCount: _menuList.length,
                    itemBuilder: (context, index) => _MenuItem(_menuList[index]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final Map<String, dynamic> item;

  const _MenuItem(this.item);

  @override
  Widget build(BuildContext context) {
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
            LottieBuilder.asset(
              item['animationUrl'],
              width: 110,
              height: 110,
              fit: BoxFit.cover,
              frameRate: FrameRate(60),
              options: LottieOptions(
                enableMergePaths: true,
              ),
              repeat: false,
            ),
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
