import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karmalab_assignment/screens/event_ad_management_common_widgets/product_list.dart';
import 'package:karmalab_assignment/screens/event_ad_management_common_widgets/selected_product_card.dart';

import '../../controllers/event_product_controller.dart';

class Event_AD_Products extends StatelessWidget {
  final bool isPackage;
  final String id;

  Event_AD_Products({
    Key? key,
    required this.isPackage,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final  controller = EventManagementController.instance;
    controller.syncProductsWithEvent();
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Product Management',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Obx(() => controller.isLoading.value
              ? const Padding(
                  padding: EdgeInsets.all(16),
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                  ),
                )
              : const SizedBox()),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Selected Products',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Obx(() {
                  final selectedProducts = controller.eventProducts;

                  return selectedProducts.isEmpty
                      ? Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          alignment: Alignment.center,
                          child: const Text(
                            'No products selected',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                        )
                      : Container(
                          height: 100,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: selectedProducts.length,
                            itemBuilder: (context, index) {
                              final product = selectedProducts[index];
                              return SelectedProductCard(
                                eventProduct: product,
                                controller: controller,
                              );
                            },
                          ),
                        );
                }),
              ],
            ),
          ),
          Container(
            height: 8,
            color: Colors.grey[100],
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Available Products',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Obx(() {
                      return controller.availableProducts.isEmpty
                          ? const Center(
                              child: Text(
                                'No products available',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                            )
                          :
                      ListView.builder(
                        padding: const EdgeInsets.only(bottom: 16),
                        itemCount: controller.productController.products.length,  // Changed to lowercase
                        itemBuilder: (context, index) {
                          final product = controller.productController.products[index];  // Changed to lowercase
                          return ProductListItem(
                            product: product,
                            parentId: id ?? '',
                            controller: controller,
                          );
                        },
                      );                    }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
