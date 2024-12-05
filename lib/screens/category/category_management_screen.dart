import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:karmalab_assignment/models/category_model.dart' as model;
import '../../controllers/category_controller.dart';

class CategorySubcategoryView extends GetView<CategoryController> {
  static const routeName = "/category_subcategory";

  const CategorySubcategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    // Fetch categories when the view is first built
    controller.getCategories();

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.grey[200],
          title: const Text('Categories')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.categories.isEmpty) {
          return const Center(child: Text('No categories available.'));
        } else {
          // Select the first category by default if none is selected
          if (controller.selectedCategory.value == null && controller.categories.isNotEmpty) {
            controller.selectedCategory.value = controller.categories.first;
          }

          return Row(
            children: [
              // Subcategory Grid
              Expanded(
                child: Obx(() {
                  final subCategories = controller.selectedCategory.value?.subCategories ?? [];
                  return subCategories.isEmpty
                      ? const Center(child: Text('No subcategories available.'))
                      : GridView.builder(
                    padding: const EdgeInsets.all(10.0),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: subCategories.length,
                    itemBuilder: (context, index) {
                      final subCategory = subCategories[index];
                      return Stack(
                        children: [
                          Card(
                            elevation: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Image.asset(
                                    'assets/images/png/subcategory.jpg',
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    subCategory.name ?? '',
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
                            child: PopupMenuButton<String>(
                              onSelected: (value) async {
                                if (value == 'delete') {
                                  // Delete subcategory logic
                                  await controller.deleteSubCategoryId(
                                    subCategory.sId ?? '',
                                        (success, {errorMessage}) {
                                      if (success) {
                                        Get.snackbar(
                                          'Success',
                                          'Subcategory deleted successfully',
                                          snackPosition: SnackPosition.BOTTOM,
                                          backgroundColor: Colors.transparent,
                                          colorText: Colors.black,
                                        );
                                        // Update selected category to reflect the deletion
                                        controller.selectedCategory.value?.subCategories.remove(subCategory);
                                      } else {
                                        Get.snackbar(
                                          'Error',
                                          'Error deleting subcategory',
                                          snackPosition: SnackPosition.BOTTOM,
                                          backgroundColor: Colors.transparent,
                                          colorText: Colors.red,
                                        );
                                      }
                                    },
                                  );
                                }
                              },
                              itemBuilder: (context) => [
                                const PopupMenuItem(
                                  value: 'delete',
                                  child: Text('Delete Subcategory'),
                                ),
                              ],
                              icon: const Icon(Icons.more_vert),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }),
              ),
              Container(
                width: 100, // Adjust the width as per design
                color: Colors.grey[200],
                padding: const EdgeInsets.all(8.0), // Add padding for space between categories
                child: ListView.builder(
                  itemCount: controller.categories.length,
                  itemBuilder: (context, index) {
                    final category = controller.categories[index];
                    return GestureDetector(
                      onTap: () {
                        controller.selectedCategory.value = category;
                      },
                      child: Obx(() {
                        return Stack(
                          children: [
                            Container(
                              color: controller.selectedCategory.value?.id == category.id
                                  ? Colors.grey[300]
                                  : Colors.transparent,
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  if (category.image != null)
                                    Image.network(
                                      "https://readyhow.com${category.image!.secureUrl}",
                                      width: 100,
                                      height: 100,
                                    ),
                                  const SizedBox(height: 5),
                                  Text(
                                    category.name,
                                    style: const TextStyle(fontSize: 12),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            Positioned(

                              top:12,
                              right: 0,
                              child: PopupMenuButton<String>(

                                onSelected: (value) async {
                                  if (value == 'delete') {
                                    // Delete category logic
                                    await controller.deleteCategory(
                                      category.id ?? '',
                                          (success, {errorMessage}) {
                                        if (success) {
                                          Get.snackbar(
                                            'Success',
                                            'Category deleted successfully',
                                            snackPosition: SnackPosition.BOTTOM,
                                            backgroundColor: Colors.transparent,
                                            colorText: Colors.black,
                                          );
                                          controller.getCategories(); // Refresh categories to reflect deletion
                                        } else {
                                          Get.snackbar(
                                            'Error',
                                            'Error deleting category',
                                            snackPosition: SnackPosition.BOTTOM,
                                            backgroundColor: Colors.transparent,
                                            colorText: Colors.red,
                                          );
                                        }
                                      },
                                    );
                                  }
                                },
                                itemBuilder: (context) => [
                                  const PopupMenuItem(
                                    value: 'delete',
                                    child: Text('Delete Category'),
                                  ),
                                ],
                                icon: const Icon(
                                    color: Colors.white70,
                                    Icons.more_vert),
                              ),
                            ),
                          ],
                        );
                      }),
                    );
                  },
                ),
              ),
              // Sidebar for categories
            ],
          );
        }
      }),
    );
  }
}