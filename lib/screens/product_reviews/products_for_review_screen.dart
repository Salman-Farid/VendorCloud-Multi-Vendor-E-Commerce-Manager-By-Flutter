import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karmalab_assignment/constants/color_constants.dart';
import 'package:karmalab_assignment/screens/product_reviews/product_reviews.dart';
import '../../controllers/product_controller.dart';
import '../product_queries/product_question_ans.dart';

class ProductsListScreen extends GetView<ProductController> {
  static const routeNameReviews  = "/products_list";
  static const routeNameQA = "/products_for_qa";

  final bool isReviewScreen;

  const ProductsListScreen({
    super.key,
    this.isReviewScreen = true,
  });
  String get routeName => isReviewScreen ? routeNameReviews : routeNameQA;

  @override
  Widget build(BuildContext context) {
    controller.getProducts();
    return Scaffold(
      appBar: AppBar(
        title: Text(isReviewScreen? 'Products Reviews':'Products Q/A'),
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.products.isEmpty) {
          return const Center(child: Text('No products available.'));
        } else {
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.products.length,
            itemBuilder: (context, index) {
              final product = controller.products[index];
              return Card(
                color: AppColors.white,
                margin: const EdgeInsets.only(bottom: 16),
                elevation: 3,
                shadowColor: Colors.grey.withOpacity(0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: Colors.grey.withOpacity(0.1),
                    width: 1,
                  ),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    Get.to(() => isReviewScreen
                        ? ProductReviewsScreen(productId: product.id ?? '')
                        : ProductQuestionAnswerScreen(productId: product.id ?? '')
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        // Square Product Image
                        Container(
                          width: 80,
                          height: 80,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: product.coverPhoto != null
                                ? Image.network(
                              product.coverPhoto,
                                    fit: BoxFit.cover,
                                  )
                                : Container(
                                    color: Colors.grey[200],
                                    child: Icon(Icons.image,
                                        color: Colors.grey[400], size: 40),
                                  ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Product Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name ?? '',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  letterSpacing: 0.3,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 6),
                              Text(
                                '\$${product.price ?? 0}',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    size: 18,
                                    color: Colors.amber,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '4.5',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.chevron_right, color: Colors.grey[600]),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }

}
