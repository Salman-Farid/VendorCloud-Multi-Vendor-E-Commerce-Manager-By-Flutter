import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../controllers/product_controller.dart';
import '../../controllers/category_controller.dart';

class ProductCreationScreen extends GetView<ProductController> {
  static const routeName = "/productUploadScreen";

  final CategoryController categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Create Product', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Obx(() {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Cover Photo Upload Section
                  _buildCoverPhotoSection(),
                  const SizedBox(height: 32),

                  // Additional Images Section
                  _buildAdditionalImagesSection(),
                  const SizedBox(height: 32),

                  // Video Upload Section
                  _buildVideoUploadSection(),
                  const SizedBox(height: 32),

                  // Product Details Section
                  const Text(
                    'Product Details',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple),
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: controller.nameController,
                    label: 'Name',
                    icon: FontAwesomeIcons.tag,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: controller.slugController,
                    label: 'Slug',
                    icon: FontAwesomeIcons.link,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          controller: controller.priceController,
                          label: 'Price',
                          icon: FontAwesomeIcons.dollarSign,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildTextField(
                          controller: controller.quantityController,
                          label: 'Quantity',
                          icon: FontAwesomeIcons.cubes,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: controller.summaryController,
                    label: 'Summary',
                    icon: FontAwesomeIcons.alignLeft,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: controller.descriptionController,
                    label: 'Description',
                    icon: FontAwesomeIcons.alignJustify,
                    maxLines: 5,
                  ),
                  const SizedBox(height: 16),
                  _buildCategoryDropdown(),
                  const SizedBox(height: 16),
                  _buildSubCategoryDropdown(),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: controller.brandController,
                    label: 'Brand',
                    icon: FontAwesomeIcons.trademark,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: controller.sizeController,
                    label: 'Size',
                    icon: FontAwesomeIcons.rulerHorizontal,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: controller.discountController,
                    label: 'Discount',
                    icon: FontAwesomeIcons.percent,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: controller.warrantyController,
                    label: 'Warranty',
                    icon: FontAwesomeIcons.shield,
                  ),
                  const SizedBox(height: 16),
                  _buildPackagingFields(),
                  const SizedBox(height: 32),

                  // Create Product Button
                  ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : _handleCreateProduct,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: controller.isLoading.value
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.deepPurple),
                                strokeWidth: 2.0,
                              ),
                            )
                          : const Text(
                              'Create Product',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurple),
                            ),
                    ),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.deepPurple,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: const BorderSide(color: Colors.deepPurple),
                      ),
                      elevation: 0,
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildCoverPhotoSection() {
    return Column(
      children: [
        Center(
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              GestureDetector(
                onTap: () async {
                  await controller.mediaController
                      .imagePickerAndBase64Conversion();
                },
                onDoubleTap: () {
                  controller.mediaController.removeCoverPhoto();
                },
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: Colors.deepPurple, width: 2),
                    image: controller.mediaController.imageBase64.isNotEmpty
                        ? DecorationImage(
                            image: MemoryImage(base64Decode(controller
                                .mediaController.imageBase64
                                .split(',')
                                .last)),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: controller.mediaController.imageBase64.isEmpty
                      ? const Icon(FontAwesomeIcons.image,
                          color: Colors.deepPurple, size: 40)
                      : null,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.deepPurple,
                  shape: BoxShape.circle,
                ),
                child: const Icon(FontAwesomeIcons.camera,
                    color: Colors.white, size: 20),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Cover Photo',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple),
        ),
      ],
    );
  }

  Widget _buildAdditionalImagesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Additional Images',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(3, (index) {
            if (index <
                controller.mediaController.additionalImagesBase64.length) {
              return GestureDetector(
                onLongPress: () {
                  controller.mediaController.removeImage(index);
                },
                onTap: () async {
                  await controller.mediaController.pickAdditionalImages();
                },
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.blue.shade200, width: 2),
                    image: DecorationImage(
                      image: MemoryImage(base64Decode(controller
                          .mediaController.additionalImagesBase64[index]
                          .split(',')
                          .last)),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            } else {
              return GestureDetector(
                onTap: () async {
                  await controller.mediaController.pickAdditionalImages();
                },
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.deepPurple, width: 2),
                  ),
                  child: const Icon(FontAwesomeIcons.plus,
                      color: Colors.deepPurple, size: 30),
                ),
              );
            }
          }),
        ),
      ],
    );
  }

  Widget _buildVideoUploadSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Video',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                controller: controller.videoController,
                label: 'Video URL',
                icon: FontAwesomeIcons.link,
              ),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: () async {
                await controller.mediaController
                    .videoPickerAndBase64Conversion();
              },
              child: const Text('Upload Video'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.deepPurple,
              ),
            ),
          ],
        ),
        if (controller.mediaController.videoBase64.isNotEmpty)
          const Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Text(
              'Video uploaded',
              style: TextStyle(color: Colors.green),
            ),
          ),
      ],
    );
  }

  Widget _buildCategoryDropdown() {
    return Obx(() {
      return DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Category',
          prefixIcon:
              const Icon(FontAwesomeIcons.layerGroup, color: Colors.deepPurple),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.deepPurple.withOpacity(0.5)),
          ),
        ),
        value: categoryController.selectedCategory.value?.sId,
        items: categoryController.categories.map((category) {
          return DropdownMenuItem<String>(
            value: category.sId,
            child: Text(category.name),
          );
        }).toList(),
        onChanged: (String? categoryId) {
          if (categoryId != null) {
            categoryController.setSelectedCategory(categoryId);
          }
        },
      );
    });
  }

  Widget _buildSubCategoryDropdown() {
    return Obx(() {
      final subCategories =
          categoryController.selectedCategory.value?.subCategories ?? [];

      // Clear the selected subcategory and controller text if the current subcategory is not in the new category's subcategories
      if (controller.subCategoryController.text.isNotEmpty &&
          !subCategories.any((subCat) =>
              subCat.sId == controller.subCategoryController.text)) {
        controller.subCategoryController.text = '';
        categoryController.selectedSubCategory.value =
            null; // Reset selected subcategory
      }

      return DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Subcategory',
          prefixIcon: const Icon(FontAwesomeIcons.tags, color: Colors.deepPurple),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.deepPurple.withOpacity(0.5)),
          ),
        ),
        value: controller.subCategoryController.text.isNotEmpty &&
                subCategories.any((subCat) =>
                    subCat.sId == controller.subCategoryController.text)
            ? controller.subCategoryController.text
            : null,
        items: subCategories.map((subCategory) {
          return DropdownMenuItem<String>(
            value: subCategory.sId,
            child: Text(subCategory.name ?? ''),
          );
        }).toList(),
        onChanged: (String? subCategoryId) {
          if (subCategoryId != null) {
            categoryController.setSelectedSubCategory(subCategoryId);
          } else {
            controller.subCategoryController.text = '';
            categoryController.selectedSubCategory.value = null;
          }
        },
      );
    });
  }

  Widget _buildPackagingFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Packaging',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                controller: controller.weightController,
                label: 'Weight',
                icon: FontAwesomeIcons.weightHanging,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildTextField(
                controller: controller.heightController,
                label: 'Height',
                icon: FontAwesomeIcons.arrowsAltV,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                controller: controller.widthController,
                label: 'Width',
                icon: FontAwesomeIcons.arrowsAltH,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildTextField(
                controller: controller.dimensionController,
                label: 'Dimension',
                icon: FontAwesomeIcons.cube,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.deepPurple),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.deepPurple.withOpacity(0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Colors.deepPurple.withOpacity(0.5),
          ),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      ),
    );
  }

  void _handleCreateProduct() async {
    await controller.createProduct((success, {errorMessage}) {
      if (success) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(
            content: Text('Product created successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        // Optionally, navigate back or to a product list screen
        Get.back();
      } else {
        print(errorMessage);
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: Text('Error: $errorMessage'),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
  }
}
