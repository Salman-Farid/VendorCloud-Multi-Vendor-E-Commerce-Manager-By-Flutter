import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karmalab_assignment/models/category_model.dart' as model;
import '../../controllers/category_controller.dart';

class CategoryGridView extends GetView<CategoryController> {
  static const routeName = "/all_categories";
  late model.Category categoryByModel;

  CategoryGridView({super.key});

  @override
  Widget build(BuildContext context) {
    // Fetch categories when the view is first built
    controller.getCategories();

    return Scaffold(
      appBar: AppBar(title: const Text('Category Grid')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.categories.isEmpty) {
          return const Center(child: Text('No categories available.'));
        } else {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of columns in the grid
              crossAxisSpacing: 10.0, // Space between columns
              mainAxisSpacing: 10.0, // Space between rows
              childAspectRatio: 0.75, // Aspect ratio of each item
            ),
            itemCount: controller.categories.length,
            itemBuilder: (context, index) {
              final category = controller.categories[index];
              return Stack(
                children: [
                  Card(
                    elevation: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: category.image != null
                              ? Image.network(
                            "https://baburhaatbd.com${category.image.secureUrl}",
                            fit: BoxFit.cover,
                            width: double.infinity,
                          )
                              : Container(color: Colors.grey),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            category.name ?? '',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child:
                    PopupMenuButton<String>(
                      onSelected: (value) async {
                        if (value == 'update') {
                          // Update category logic
                          controller.updateCategoryById(category.id ?? '', categoryByModel);
                        } else if (value == 'delete') {
                          // Delete category logic
                          bool success = false;
                          await controller.deleteCategory(category.id ?? '', (result, {errorMessage}) {
                            success = result;
                            if (success) {
                              // Safely use context only if the widget is still mounted
                              Get.snackbar(
                                'Success',
                                'Category deleted successfully',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.transparent,
                                colorText: Colors.black,
                              );
                              controller.getCategories();
                            } else {
                              Get.snackbar(
                                'Error',
                                'Error deleting category',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.transparent,
                                colorText: Colors.red,
                              );
                            }
                          });
                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'update',
                          child: Text('Update Category'),
                        ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Text('Delete Category'),
                        ),
                      ],
                      icon: const Icon(Icons.more_vert),
                    ),
                  ),
                ],
              );
            },
          );
        }
      }),
    );
  }
}
