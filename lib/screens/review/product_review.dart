import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karmalab_assignment/controllers/review_controller.dart';
import '../../models/product_review_ProductModel.dart';
import '../../controllers/vendor_reply_controller.dart'; // Import the new controller

class ProductReviewScreen extends StatelessWidget {
  static const routeName = "/reviewScreen";
  final ProductReviewController controller = Get.find<ProductReviewController>();
  final VendorReplyController replyController = Get.put(VendorReplyController()); // Initialize the controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Reviews',
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: false,
        actions: [
          SizedBox(width: 16),
        ],
      ),
      body: Obx(() {
        if (controller.products.isEmpty) {
          return Center(child: Text('No products available'));
        }
        return ListView.builder(
          itemCount: controller.products.length,
          itemBuilder: (context, productIndex) {
            final product = controller.products[productIndex];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProductHeader(product),
                _buildProductDetails(product),
                _buildReviewSection(product),
              ],
            );
          },
        );
      }),
    );
  }

  Widget _buildProductHeader(Product product) {
    return Container(
      height: 250,
      width: double.infinity,
      child: Image.network(
        product.imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildProductDetails(Product product) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.name,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            '\$${product.price.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.green),
          ),
          SizedBox(height: 16),
          Text(
            product.description,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Text(
                'Rating: ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              Text(
                '${controller.getAverageRating(product).toStringAsFixed(1)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Icon(Icons.star, color: Colors.amber),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReviewSection(Product product) {
    if (product.reviews.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Text('No reviews available for this product'),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          Text(
            'Reviews',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Column(
            children: product.reviews.map((review) {
              return _buildReviewCard(product, review);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard(Product product, Review review) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  review.userName,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Row(
                  children: [
                    Text(
                      review.rating.toString(),
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Icon(Icons.star, color: Colors.amber, size: 18),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(review.comment),
            SizedBox(height: 8),
            Text(
              '${review.date.day}/${review.date.month}/${review.date.year}',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 16),
            _buildVendorReplySection(product, review),
          ],
        ),
      ),
    );
  }

  Widget _buildVendorReplySection(Product product, Review review) {
    return Obx(() {
      // Access the VendorReplyController's reactive state
      final replyText = replyController.replyText.value;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (review.vendorReply != null)
            Container(
              margin: EdgeInsets.only(bottom: 8.0),
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Vendor',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(review.vendorReply!),
                ],
              ),
            ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  onChanged: (text) {
                    replyController.updateReply(text); // Update the reply text
                  },
                  decoration: InputDecoration(
                    hintText: 'Write a reply...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send, color: Colors.blue),
                onPressed: () {
                  if (replyText.isNotEmpty) {
                    controller.addVendorReply(product, review, replyText);
                    replyController.clearReply(); // Clear the text field
                  }
                },
              ),
            ],
          ),
        ],
      );
    });
  }
}
