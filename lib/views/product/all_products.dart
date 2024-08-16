import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/product_controller.dart';

class ProductGridView extends GetView<ProductController> {
  static const routeName = "/all_products";

  @override
  Widget build(BuildContext context) {
    // Fetch products when the view is first built
    controller.getProducts();

    return Scaffold(
      appBar: AppBar(title: Text('Product Grid')),
      body: Obx(() {
        // Debug print to check if products are fetched
        print('Is loading: ${controller.isLoading.value}');
        print('Products count: ${controller.products.length}');

        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (controller.products.isEmpty) {
          return Center(child: Text('No products available.'));
        } else {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of columns in the grid
              crossAxisSpacing: 10.0, // Space between columns
              mainAxisSpacing: 10.0, // Space between rows
              childAspectRatio: 0.75, // Aspect ratio of each item
            ),
            itemCount: controller.products.length,

            itemBuilder: (context, index) {
              final product = controller.products[index];
              // Debug print to check individual product details
              print('Product at index $index: ${product.name}, ${product.coverPhoto?.secureUrl}, ${product.price}');

              return Card(
                elevation: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: product.coverPhoto != null
                          ? Image.network(
                        "https://baburhaatbd.com${product.coverPhoto.secureUrl}",
                        fit: BoxFit.cover,
                        width: double.infinity,
                      )
                          : Container(color: Colors.grey),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        product.name ?? '',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('\$${product.price ?? 0}'),
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
}