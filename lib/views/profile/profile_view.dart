import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karmalab_assignment/constants/size_constants.dart';
import 'package:karmalab_assignment/controllers/user_controller.dart';
import 'dart:math' as math;

import 'package:carousel_slider/carousel_slider.dart';

class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);
  static const routeName = "/profile";
  final UserController userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: Obx(() {
        final user = userController.user.value;
        if (user == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final avatarUrl = "https://baburhaatbd.com${user.avatar}";
        final completionPercentage = userController.getProfileCompletionPercentage();

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                Row(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 120,
                          height: 120,
                          child: CustomPaint(
                            painter: ProfileCompletionPainter(completionPercentage),
                          ),
                        ),
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(avatarUrl),
                        ),
                      ],
                    ),
                    SizedBox(width: 20,),
                    Column(
                      children: [
                        Text(
                          'Your Profile Data',
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '25% Completed',
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.red),
                        ),
                        Text(
                          user.name,
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          user.email??'',
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),

                  ],
                ),
                // SizedBox(height: Get.height * 0.04),
                //
                // Container(
                //   decoration: BoxDecoration(
                //     border:
                //     Border(
                //       top: BorderSide(color: Colors.grey.shade300),
                //     ),
                //   ),
                //   //child: _buildMenuList(),
                // ),
                SizedBox(height: Get.height * 0.02),

                _buildImageCarousel(),
                // ElevatedButton(
                //   onPressed: () => Get.toNamed('/editProfile'),
                //   child: const Text('Edit Profile', style: TextStyle(color: Colors.white)),
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: Colors.blue,
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(20),
                //     ),
                //   ),
                // ),
                SizedBox(height: Get.height * 0.05),
                Container(
                  decoration: BoxDecoration(
                    border:
                    Border(
                      top: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                  child: _buildMenuList(),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildImageCarousel() {
    final List<String> imgList = [
      'https://static.vecteezy.com/system/resources/previews/002/006/774/non_2x/paper-art-shopping-online-on-smartphone-and-new-buy-sale-promotion-backgroud-for-banner-market-ecommerce-free-vector.jpg',
      'https://www.zilliondesigns.com/blog/wp-content/uploads/Perfect-Ecommerce-Sales-Banner.jpg',
      'https://t4.ftcdn.net/jpg/03/48/05/47/360_F_348054737_Tv5fl9LQnZnzDUwskKVKd5Mzj4SjGFxa.jpg',
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Center(
            child: Text(
              'Joined Events',
              style: TextStyle(
                fontSize: 18,
                //fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
        ),
        CarouselSlider(
          options: CarouselOptions(
            height: 150.0,
            enlargeCenterPage: false,
            autoPlay: true,
            aspectRatio: 16 / 9,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: Duration(milliseconds: 1500),
            viewportFraction: 1,
          ),
          items: imgList.map((item) => Container(
            margin: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              image: DecorationImage(
                image: NetworkImage(item),
                fit: BoxFit.cover,
              ),
            ),
          )).toList(),
        ),
      ],
    );
    // return CarouselSlider(
    //   options: CarouselOptions(
    //     height:150.0,
    //     enlargeCenterPage: false,
    //     autoPlay: true,
    //     aspectRatio: 16 / 9,
    //     autoPlayCurve: Curves.fastOutSlowIn,
    //     enableInfiniteScroll: true,
    //     autoPlayAnimationDuration: Duration(milliseconds: 1500),
    //     viewportFraction: 1,
    //   ),
    //   items: imgList.map((item) => Container(
    //     margin: EdgeInsets.all(5.0),
    //     decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(20.0),
    //       image: DecorationImage(
    //         image: NetworkImage(item),
    //         fit: BoxFit.cover,
    //       ),
    //     ),
    //   )).toList(),
    // );
  }

  Widget _buildMenuList() {
    return Column(
      children: [
        const SizedBox(height: 16,),
        _buildMenuItem(Icons.settings, 'Settings'),
        const SizedBox(height: 16,),
        _buildMenuItem(Icons.payment, 'Billing Details'),
        const SizedBox(height: 16,),
        _buildMenuItem(Icons.people, 'User Management'),
        const SizedBox(height: 16,),
        _buildMenuItem(Icons.info, 'Information'),
        const SizedBox(height: 16,),
        _buildMenuItem(Icons.logout, 'Log out', onTap: () => _confirmLogout(Get.context!)),
        const SizedBox(height: 16,),
      ],
    );
  }

  Widget _buildMenuItem(IconData icon, String title, {VoidCallback? onTap}) {
    return InkWell(
      splashColor: Colors.grey.shade50,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.blue),
            const SizedBox(width: 16),
            Expanded(child: Text(title)),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
              child: Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmLogout(BuildContext context) {
    Get.defaultDialog(
      title: 'Logout',
      middleText: 'Are you sure you want to logout?',
      textCancel: 'Cancel',
      textConfirm: 'Logout',
      confirmTextColor: Colors.white,
      onConfirm: () {
        // Perform logout action here
        Get.back();
      },
    );
  }
}
class ProfileCompletionPainter extends CustomPainter {
  final double completionPercentage;

  ProfileCompletionPainter(this.completionPercentage);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0
      ..strokeCap = StrokeCap.round;

    // Draw background circle
    paint.color = Colors.grey[300]!;
    canvas.drawCircle(center, radius, paint);

    // Draw completion arc
    paint.color = Colors.blue;
    final rect = Rect.fromCircle(center: center, radius: radius);
    canvas.drawArc(
      rect,
      -math.pi / 2,
      2 * math.pi * (completionPercentage / 100),
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}





// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:karmalab_assignment/constants/size_constants.dart';
// import 'package:karmalab_assignment/controllers/user_controller.dart';
//
// import '../../models/user_model.dart';
// import '../../services/shared_pref_service.dart'; // Import the controller
//
// class Profile extends StatelessWidget {
//   Profile({Key? key}) : super(key: key);
//   static const routeName = "/profile";
//   final UserController userController =
//       Get.find<UserController>(); // Access the controller
//
//   @override
//   Widget build(BuildContext context) {
//     final user = userController.user.value;
//
//     return Scaffold(
//       backgroundColor: Colors.white, // Set the canvas color to white
//
//       appBar: AppBar(
//         title: const Text('User Dashboard'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.info_outline),
//             onPressed: () => _showSessionInfo(context),
//           ),
//           IconButton(
//             icon: const Icon(Icons.logout),
//             onPressed: () => _confirmLogout(context),
//           ),
//         ],
//       ),
//       drawer: _buildDrawer(context), // Add the drawer
//       body: Obx(() {
//         if (user == null) {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//
//         final avatarUrl = "https://baburhaatbd.com${user.avatar}";
//
//         return Padding(
//           padding: const EdgeInsets.all(AppSizes.defaultPadding),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 _buildProfileHeader(context, user, avatarUrl),
//                 const SizedBox(height: 10),
//                 _buildInfoList(user),
//                 const SizedBox(height: 10),
//                 _buildPermissionsList(),
//               ],
//             ),
//           ),
//         );
//       }),
//     );
//   }
//
//   Widget _buildDrawer(BuildContext context) {
//     return Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: <Widget>[
//           UserAccountsDrawerHeader(
//             accountName: Text(userController.user.value?.name ?? 'Guest'),
//             accountEmail: Text(userController.user.value?.email ?? ''),
//             currentAccountPicture: CircleAvatar(
//               backgroundImage: NetworkImage(
//                   "https://baburhaatbd.com${userController.user.value?.avatar ?? ''}"),
//             ),
//           ),
//           ListTile(
//             leading: Icon(Icons.category),
//             title: Text('Categories'),
//             onTap: () {
//               // Navigate to the category screen
//               Get.toNamed('/category_subcategory');
//             },
//           ),
//           ListTile(
//             leading: Icon(Icons.create_new_folder),
//             title: Text('Categorie Creation'),
//             onTap: () {
//               // Navigate to the category screen
//               Get.toNamed('/categoryCreateScreen');
//             },
//           ),
//           ListTile(
//             leading: Icon(Icons.create),
//             title: Text('Product Creation'),
//             onTap: () {
//               // Navigate to the product screen
//               Get.toNamed('/productUploadScreen');
//             },
//           ),
//
//           ListTile(
//             leading: Icon(Icons.production_quantity_limits_outlined),
//             title: Text('All Products'),
//             onTap: () {
//               Get.toNamed('/all_products');
//             },
//           ),
//           ListTile(
//             leading: Icon(Icons.logout),
//             title: Text('Logout'),
//             onTap: () {
//               _confirmLogout(context);
//             },
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildProfileHeader(
//       BuildContext context, User user, String avatarUrl) {
//     return Row(
//       children: [
//         CircleAvatar(
//           radius: 50,
//           backgroundImage: NetworkImage(avatarUrl),
//         ),
//         const SizedBox(width: 20),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 user.name,
//                 style:
//                     const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 5),
//               Text(
//                 user.email,
//                 style: const TextStyle(fontSize: 16, color: Colors.grey),
//               ),
//             ],
//           ),
//         ),
//         IconButton(
//           icon: const Icon(Icons.edit),
//           onPressed: () => _showEditProfileDialog(context, user),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildInfoList(User user) {
//     return Column(
//       children: [
//         _buildInfoCard('User ID:  ', user.id ?? ''),
//         _buildInfoCard('Email:  ', user.email),
//         _buildInfoCard('Name:  ', user.name),
//       ],
//     );
//   }
//
//   Widget _buildInfoCard(String title, String value) {
//     return Card(
//       elevation: 3,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//       child: Container(
//         width: double.infinity,
//         padding: const EdgeInsets.all(20),
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.white, Colors.white],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           borderRadius: BorderRadius.all(Radius.circular(20)),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               title,
//               style: const TextStyle(fontSize: 14, color: Colors.deepOrange),
//             ),
//             const SizedBox(height: 10),
//             Text(
//               value,
//               style: const TextStyle(fontSize: 14, color: Colors.black),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildPermissionsList() {
//     final user = userController.user.value;
//     final permissions = user?.otherPermissions?.toJson() ?? {};
//
//     if (permissions.isEmpty) {
//       return const Center(child: Text('Permissions not available'));
//     }
//
//     return Column(
//       children: permissions.entries.map((entry) {
//         final permissionKey = entry.key;
//         final isGranted = entry.value!;
//
//         return Card(
//           color: Colors.white,
//           elevation: 3,
//           margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//           child: ListTile(
//             leading: Icon(
//               isGranted ? Icons.check_circle : Icons.cancel,
//               color: isGranted ? Colors.green : Colors.red,
//             ),
//             title: Text(
//               _formatPermissionName(permissionKey),
//               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//             ),
//             subtitle: Text(
//               isGranted ? 'Granted' : 'Not Granted',
//               style: TextStyle(
//                 color: isGranted ? Colors.green : Colors.red,
//               ),
//             ),
//           ),
//         );
//       }).toList(),
//     );
//   }
//
//   String _formatPermissionName(String permissionKey) {
//     return permissionKey
//         .replaceAll('is', '')
//         .replaceAllMapped(RegExp(r'[A-Z]'), (match) => ' ${match.group(0)}')
//         .trim();
//   }
//
//   void _showSessionInfo(BuildContext context) async {
//     final SharedPrefService _prefService = SharedPrefService();
//
//     final sessionId = await _prefService.getSessionId();
//     Get.snackbar(
//       'Session Information',
//       sessionId != null ? 'Session ID: $sessionId' : 'No Session ID found.',
//       snackPosition: SnackPosition.BOTTOM,
//       duration: const Duration(seconds: 3),
//     );
//   }
//
//   void _confirmLogout(BuildContext context) {
//     Get.defaultDialog(
//       title: 'Logout',
//       middleText: 'Are you sure you want to logout?',
//       textCancel: 'Cancel',
//       textConfirm: 'Logout',
//       confirmTextColor: Colors.white,
//       onConfirm: () {
//         Get.back();
//       },
//     );
//   }
//
//   void _showEditProfileDialog(BuildContext context, User user) {
//     TextEditingController nameController =
//         TextEditingController(text: user.name ?? '');
//     TextEditingController emailController =
//         TextEditingController(text: user.email ?? '');
//
//     Get.defaultDialog(
//       title: 'Edit Profile',
//       content: Column(
//         children: [
//           TextField(
//             controller: nameController,
//             decoration: const InputDecoration(labelText: 'Name'),
//           ),
//           const SizedBox(height: 10),
//           TextField(
//             controller: emailController,
//             decoration: const InputDecoration(labelText: 'Email'),
//           ),
//         ],
//       ),
//       textCancel: 'Cancel',
//       textConfirm: 'Save',
//       confirmTextColor: Colors.white,
//       onConfirm: () {
//         Get.back();
//       },
//     );
//   }
// }
