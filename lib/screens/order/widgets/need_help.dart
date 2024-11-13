import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:karmalab_assignment/utils/constants/sizes.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common/widgets/custom_shapes/containers/rounded_container.dart';

class OrderHelpScreen extends StatelessWidget {
  const OrderHelpScreen({Key? key}) : super(key: key);

  // Function to launch URL
  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  // Function to make phone call
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    await _launchUrl(phoneUri);
  }

  // Function to send email
  Future<void> _sendEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=Support Request&body=Hello, I need assistance with ',
    );
    await _launchUrl(emailUri);
  }



  Future<void> _openMessenger() async {
    const String fbProfileId = 'salman.frahman.94';

    // Direct web messenger link - this is the most reliable method
    final Uri webUri = Uri.parse('https://m.me/$fbProfileId');
    await launchUrl(
      webUri,
      mode: LaunchMode.externalApplication,
    );
  }





  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Help & Support',
          style: Get.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ).animate().fadeIn(duration: 600.ms).slideX(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showQuickHelpDialog(context),
        child: const Icon(Iconsax.message_question5, color: Colors.white),
        backgroundColor: Colors.blue,
      ).animate().scale(delay: 500.ms),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(Sizes.defaultSpace),
        child: Column(
          children: [
            // Search Bar
            // FAQ Section
            RoundedContainer(
              padding: const EdgeInsets.all(Sizes.md),
              backgroundColor: Colors.white,
              showBorder: true,
              borderColor: Colors.grey.shade200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Iconsax.message_question, color: Colors.blue)
                          .animate()
                          .shake(delay: 1000.ms),
                      const SizedBox(width: Sizes.sm),
                      Text(
                        'Frequently Asked Questions',
                        style: Get.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: Sizes.spaceBtwItems),
                  _buildExpandableFAQ(
                    'How can I track my order?',
                    'You can track your order using the timeline shown on the order details page. Real-time updates are provided at each stage of delivery. You\'ll also receive email notifications for major status changes.',
                  ),
                  _buildExpandableFAQ(
                    'What if I receive a damaged item?',
                    'Please contact our support team immediately with photos of the damaged item. We\'ll arrange a return and replacement within 24 hours. Make sure to keep the original packaging.',
                  ),
                  _buildExpandableFAQ(
                    'Can I modify my order?',
                    'Orders can only be modified within 1 hour of placement. Contact our support team for immediate assistance with order modifications.',
                  ),
                  _buildExpandableFAQ(
                    'What are your return policies?',
                    'We offer a 30-day return policy for most items. Items must be unused and in original packaging. Refunds are processed within 5-7 business days after we receive the return.',
                  ),
                  _buildExpandableFAQ(
                    'Do you offer international shipping?',
                    'Yes, we ship to most countries worldwide. Shipping costs and delivery times vary by location. Please check the shipping calculator at checkout for exact rates.',
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 800.ms).slideY(),
            const SizedBox(height: Sizes.spaceBtwSections),

            // Contact Support Section
            RoundedContainer(
              padding: const EdgeInsets.all(Sizes.md),
              backgroundColor: Colors.white,
              showBorder: true,
              borderColor: Colors.grey.shade200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Iconsax.support, color: Colors.green).animate().shake(delay: 1500.ms),
                      const SizedBox(width: Sizes.sm),
                      Text(
                        'Contact Support',
                        style: Get.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: Sizes.spaceBtwItems),
                  _buildAnimatedContactItem(
                    Iconsax.call,
                    'Call Us',
                    '+1 234 567 890',
                    Colors.blue,
                        () => _showContactDialog(context, 'Call Support'),
                  ),
                  _buildAnimatedContactItem(
                    Iconsax.message,
                    'Email Support',
                    'support@example.com',
                    Colors.green,
                        () => _showContactDialog(context, 'Email Support'),
                  ),
                  _buildAnimatedContactItem(
                    Iconsax.message_question,
                    'Live Chat',
                    'Available 24/7',
                    Colors.orange,
                        () => _showContactDialog(context, 'Live Chat'),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 800.ms, delay: 400.ms).slideY(),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandableFAQ(String question, String answer) {
    return ExpansionTile(
      title: Text(
        question,
        style: Get.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(Sizes.md),
          child: Text(
            answer,
            style: Get.textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
          ),
        ),
      ],
      iconColor: Colors.blue,
      collapsedIconColor: Colors.grey,
    ).animate().fadeIn();
  }

  Widget _buildAnimatedContactItem(
      IconData icon,
      String title,
      String detail,
      Color color,
      VoidCallback onTap,
      ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(Sizes.sm),
      child: Padding(
        padding: const EdgeInsets.all(Sizes.sm),
        child: Row(
          children: [
            Icon(icon, size: 24, color: color)
                .animate(onPlay: (controller) => controller.repeat())
                .shimmer(delay: 2000.ms, duration: 1200.ms),
            const SizedBox(width: Sizes.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Get.textTheme.titleSmall,
                  ),
                  Text(
                    detail,
                    style: Get.textTheme.bodyMedium?.copyWith(color: Colors.grey),
                  ),
                ],
              ),
            ),
            Icon(Iconsax.arrow_right, color: color, size: 20),
          ],
        ),
      ),
    );
  }


  void _showContactDialog(BuildContext context, String type) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.cardRadiusLg),
        ),
        title: Row(
          children: [
            Icon(
              type == 'Call Support'
                  ? Iconsax.call
                  : type == 'Email Support'
                  ? Iconsax.message
                  : Iconsax.message_question,
              color: type == 'Call Support'
                  ? Colors.blue
                  : type == 'Email Support'
                  ? Colors.green
                  : Colors.orange,
            ),
            const SizedBox(width: Sizes.sm),
            Text(type),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              type == 'Call Support'
                  ? 'Our support team is available Monday to Friday, 9 AM to 6 PM EST.'
                  : type == 'Email Support'
                  ? 'We typically respond to emails within 24 hours.'
                  : 'Connect with our support team instantly through live chat.',
              style: Get.textTheme.bodyMedium,
            ),
            const SizedBox(height: Sizes.spaceBtwItems),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
                try {
                  if (type == 'Call Support') {
                    _makePhoneCall('+1234567890');
                  } else if (type == 'Email Support') {
                    _sendEmail('support@example.com');
                  } else {
                    _openMessenger();
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Could not open ${type.toLowerCase()}. Please try again.'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              icon: Icon(
                type == 'Call Support'
                    ? Iconsax.call
                    : type == 'Email Support'
                    ? Iconsax.message
                    : Iconsax.message_question,
              ),
              label: Text(
                type == 'Call Support'
                    ? 'Call Now'
                    : type == 'Email Support'
                    ? 'Send Email'
                    : 'Start Chat',
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: type == 'Call Support'
                    ? Colors.blue
                    : type == 'Email Support'
                    ? Colors.green
                    : Colors.orange,
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 48),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showQuickHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.cardRadiusLg),
        ),
        title: Row(
          children: [
            Icon(Iconsax.support, color: Colors.blue),
            const SizedBox(width: Sizes.sm),
            Text('Need Quick Help?'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Our support team is ready to assist you 24/7. Choose your preferred way to connect with us.',
              style: Get.textTheme.bodyMedium,
            ),
            const SizedBox(height: Sizes.spaceBtwItems),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
                _openMessenger();
              },
              icon: Icon(Iconsax.message_text),
              label: Text('Start Live Chat'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 48),
              ),
            ),
          ],
        ),
      ),
    );
  }
}