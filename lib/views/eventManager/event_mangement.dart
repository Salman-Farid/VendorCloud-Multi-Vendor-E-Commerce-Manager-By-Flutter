import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../controllers/EventManagementController.dart';
import '../../models/product_model.dart';

class EventManagementScreen extends StatelessWidget {
  static const routeName = "/event_management";
  final EventManagementController eventManagementController = Get.put(EventManagementController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(child: const Text('Event Management', style: TextStyle(color: Colors.black, fontSize: 24))),
        elevation: 0,
      ),
      body: Stack(
        children: [
          Obx(() {
            if (eventManagementController.productController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            } else if (eventManagementController.productController.products.isEmpty) {
              return const Center(child: Text('No products available.'));
            } else {
              return GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.75,
                ),
                itemCount: eventManagementController.productController.products.length,
                itemBuilder: (context, index) {
                  final product = eventManagementController.productController.products[index];
                  return LongPressDraggable<Product>(
                    data: product,
                    feedback: Material(
                      elevation: 4,
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        width: 100,
                        height: 140,
                        child: ProductCard(product: product, index: index), // Pass index here
                      ),
                    ),
                    onDragStarted: () {
                      eventManagementController.startDragging(index);
                    },
                    onDraggableCanceled: (velocity, offset) {
                      eventManagementController.stopDragging();
                    },
                    onDragCompleted: () {
                      eventManagementController.stopDragging();
                    },
                    childWhenDragging: SizedBox(height: 150),
                    child: ProductCard(product: product, index: index), // Pass index here
                    onDragEnd: (details) {
                      eventManagementController.stopDragging();
                    },
                  );
                },
              );
            }
          }),
          Positioned(
            bottom: 70,
            left: 0,
            right: 0,
            child: Center(
              child: DragTarget<Product>(
                onWillAcceptWithDetails: (product) => product != null,
                onAccept: (product) => eventManagementController.addProductToEvent(product),
                builder: (context, candidateData, rejectedData) {
                  return Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      color: candidateData.isEmpty ? Colors.transparent : Colors.red.shade100,
                      shape: BoxShape.circle,
                    ),
                    child:  Obx(() {
                    return Visibility(
                      visible: eventManagementController.draggingIndex.value != null, // Check if draggingIndex is not null
                      child: Lottie.network(
                        repeat: false,
                        'https://lottie.host/d5ff3ee6-7d57-41bf-ad92-ca34777279e3/P4XDvDxN9O.json',
                        fit: BoxFit.contain,
                        animate: true,
                      ),
                    );
                  }),

                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  final int index;
  final EventManagementController eventManagementController = Get.find<EventManagementController>(); // Use Get.find to reuse controller

  ProductCard({Key? key, required this.product, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      bool isDragging = eventManagementController.draggingIndex.value == index;
      return Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                "https://baburhaatbd.com${product.coverPhoto!.secureUrl}",
                fit: BoxFit.cover,
                height: isDragging ? 100 : 175,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.name ?? '',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: isDragging ? 5 : 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '\$${product.price ?? 0}',
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodySmall!.color,
                          fontWeight: FontWeight.w600,
                          fontSize: isDragging ? 3 : 12,
                        ),
                      ),

                    ],
                  ),

                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
