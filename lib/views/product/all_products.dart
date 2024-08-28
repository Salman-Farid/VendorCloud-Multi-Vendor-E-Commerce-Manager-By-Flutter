import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/product_controller.dart';

class ProductGridView extends GetView<ProductController> {
  static const routeName = "/all_products";

  const ProductGridView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getProducts();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Grid'),
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.products.isEmpty) {
          return const Center(child: Text('No products available.'));
        } else {
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.77,
            ),
            itemCount: controller.products.length,
            itemBuilder: (context, index) {
              final product = controller.products[index];
              return Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(12)),
                          child: product.coverPhoto != null
                              ? Image.network(
                                  "https://baburhaatbd.com${product.coverPhoto.secureUrl}",
                                  fit: BoxFit.cover,
                                  height: 175, // Increased image height
                                  width: double.infinity,
                                )
                              : Container(
                                  color: Colors.grey[200],
                                  width: double.infinity,
                                  child: Icon(Icons.image,
                                      color: Colors.grey[200], size: 40),
                                ),
                        ),
                        Positioned(
                          top: 4,
                          right: 4,
                          child: PopupMenuButton<String>(
                            icon: const Icon(Icons.more_vert,
                                color: Colors.white),
                            onSelected: (value) {
                              if (value == 'update') {
                                //Get.to(() => ProductUpdateScreen(product: product));
                              } else if (value == 'delete') {
                                _showDeleteConfirmation(
                                    context, product.id ?? '');
                              }
                            },
                            itemBuilder: (BuildContext context) => [
                              const PopupMenuItem(
                                value: 'update',
                                child: Text('Update'),
                              ),
                              const PopupMenuItem(
                                value: 'delete',
                                child: Text('Delete'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name ?? '',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                            maxLines: 1, // Adjusted to single line
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '\$${product.price ?? 0}',
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodySmall!.color,
                              fontWeight: FontWeight.w600,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
      }),
    );
  }

  void _showDeleteConfirmation(BuildContext context, String productId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Delete"),
          content: const Text("Are you sure you want to delete this product?"),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text("Delete"),
              onPressed: () {
                Navigator.of(context).pop();
                controller.deleteProduct(
                  productId,
                  (success, {errorMessage}) {
                    if (success) {
                      Get.snackbar('Success', 'Product deleted successfully');
                      controller.getProducts();
                    } else {
                      Get.snackbar(
                          'Error', errorMessage ?? 'Failed to delete product');
                    }
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }
}