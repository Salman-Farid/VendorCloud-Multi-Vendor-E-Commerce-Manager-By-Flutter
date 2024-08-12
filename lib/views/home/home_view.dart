import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karmalab_assignment/constants/size_constants.dart';
import 'package:karmalab_assignment/controllers/user_controller.dart';

import '../../models/user_model.dart';
import '../../services/shared_pref_service.dart';  // Import the controller

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);
  static const routeName = "/home";
  final UserController userController = Get.find<UserController>();  // Access the controller

  @override
  Widget build(BuildContext context) {
    final user = userController.user.value;

    return Scaffold(
      backgroundColor: Colors.white, // Set the canvas color to white

      appBar: AppBar(
        title: const Text('User Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => _showSessionInfo(context),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _confirmLogout(context),
          ),
        ],
      ),
      body: Obx(() {
        if (user == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final avatarUrl = "https://baburhaatbd.com${user.avatar}";

        return Padding(
          padding: const EdgeInsets.all(AppSizes.defaultPadding),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildProfileHeader(context, user, avatarUrl),
                const SizedBox(height: 10),
                _buildInfoList(user),
                const SizedBox(height: 10),
                _buildPermissionsList(),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildProfileHeader(BuildContext context, User user, String avatarUrl) {
    return Row(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage(avatarUrl),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.name,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(
                user.email,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () => _showEditProfileDialog(context, user),
        ),
      ],
    );
  }

  Widget _buildInfoList(User user) {
    return Column(
      children: [
        _buildInfoCard('User ID:  ', user.id ?? ''),
        _buildInfoCard('Email:  ', user.email),
        _buildInfoCard('Name:  ', user.name),
      ],
    );
  }

  Widget _buildInfoCard(String title, String value) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 14, color: Colors.deepOrange),
            ),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(fontSize: 14, color:Colors.black , ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPermissionsList() {
    final user = userController.user.value;
    final permissions = user?.otherPermissions?.toJson() ?? {};

    if (permissions.isEmpty) {
      return const Center(child: Text('Permissions not available'));
    }

    return Column(
      children: permissions.entries.map((entry) {
        final permissionKey = entry.key;
        final isGranted = entry.value!;

        return Card(
          color: Colors.white,
          elevation: 3,
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: ListTile(
            leading: Icon(
              isGranted ? Icons.check_circle : Icons.cancel,
              color: isGranted ? Colors.green : Colors.red,
            ),
            title: Text(
              _formatPermissionName(permissionKey),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              isGranted ? 'Granted' : 'Not Granted',
              style: TextStyle(
                color: isGranted ? Colors.green : Colors.red,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  String _formatPermissionName(String permissionKey) {
    return permissionKey.replaceAll('is', '').replaceAllMapped(RegExp(r'[A-Z]'), (match) => ' ${match.group(0)}').trim();
  }

  void _showSessionInfo(BuildContext context) async {
    final SharedPrefService _prefService = SharedPrefService();

    final sessionId = await _prefService.getSessionId();
    Get.snackbar(
      'Session Information',
      sessionId != null ? 'Session ID: $sessionId' : 'No Session ID found.',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
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
        Get.back();
      },
    );
  }

  void _showEditProfileDialog(BuildContext context, User user) {
    TextEditingController nameController = TextEditingController(text: user.name ?? '');
    TextEditingController emailController = TextEditingController(text: user.email ?? '');

    Get.defaultDialog(
      title: 'Edit Profile',
      content: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: emailController,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
        ],
      ),
      textCancel: 'Cancel',
      textConfirm: 'Save',
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back();
      },
    );
  }
}
