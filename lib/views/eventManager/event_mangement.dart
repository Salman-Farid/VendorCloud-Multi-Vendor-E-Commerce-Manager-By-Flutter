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
        title: const Text('Event Management'),
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
                    feedback: Container(
                      width: 150,
                      height: 150,
                      child: Image.network(product.coverPhoto != null
                            ? "https://baburhaatbd.com${product.coverPhoto!.secureUrl}"
                            : '',
                        height: 100,
                        color: Colors.orangeAccent,
                        colorBlendMode: BlendMode.colorBurn,
                      ),
                    ),
                    onDragStarted: () {
                      eventManagementController.setDragging(true);
                    },
                    onDraggableCanceled: (velocity, offset) {
                      eventManagementController.setDragging(false);
                    },
                    onDragCompleted: () {
                      eventManagementController.setDragging(false);
                    },

                    childWhenDragging: SizedBox(height: 150),
                    child: ProductCard(product: product),
                    onDragEnd: (details) {
                      eventManagementController.setDragging(false);

                      // You can handle drag end here if needed
                    },
                  );
                },
              );
            }
          }),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Center(
              child: DragTarget<Product>(
                onWillAcceptWithDetails: (product) => product != null,
                onAccept: (product) => eventManagementController.addProductToEvent(product),
                builder: (context, candidateData, rejectedData) {
                  return Container(
                    width: 450,
                    height: 450,
                    decoration: BoxDecoration(
                      color: candidateData.isEmpty ? Colors.transparent : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    child:

                    Obx(() {
                      return Visibility(
                        visible: eventManagementController.isDragging.value,
                        child: Lottie.network(

                          repeat: false,
                          //'https://lottie.host/1dfd30da-0380-4082-91f7-cd7448112b00/xrT5wfkcvy.json',
                          'https://lottie.host/d5ff3ee6-7d57-41bf-ad92-ca34777279e3/P4XDvDxN9O.json',
                          width: 450,
                          height: 450,
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
  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            child: product.coverPhoto != null
                ? Image.network(
              "https://baburhaatbd.com${product.coverPhoto!.secureUrl}",
              fit: BoxFit.cover,
              height: 175,
              width: double.infinity,
            )
                : Container(
              color: Colors.grey[200],
              width: double.infinity,
              height: 150,
              child: Icon(Icons.image, color: Colors.grey[400], size: 40),
            ),
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
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${product.price ?? 0}',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodySmall!.color,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
