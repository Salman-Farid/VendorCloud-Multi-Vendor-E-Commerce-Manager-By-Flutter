import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../controllers/image_controller.dart';
import '../../controllers/product_controller.dart';







class ProductCreationScreen extends GetView<ProductController> {
  static const routeName = "/product";

  @override

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Product', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(() {
            return Column(
              children: [
                // Display Cover Photo in a Circular Container
                controller.imageController.imageBase64.isNotEmpty
                    ? CircleAvatar(
                  radius: 50,
                  backgroundImage: MemoryImage(base64Decode(
                      controller.imageController.imageBase64.split(',').last)),
                  backgroundColor: Colors.deepPurpleAccent,
                )
                    : const CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.deepPurpleAccent,
                  child: Icon(FontAwesomeIcons.image,
                      color: Colors.white, size: 30),
                ),
                const SizedBox(height: 20),
                // Cover Photo Upload Button
                ElevatedButton.icon(
                  onPressed: () async {
                    await controller.imageController.imagePickerAndBase64Conversion();
                  },
                  icon: const Icon(FontAwesomeIcons.upload, color: Colors.white),
                  label: const Text('Upload Cover Photo',
                      style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Additional Images
                const Text('Additional Images',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple)),
                const SizedBox(height: 10),
                // Display up to 3 additional images
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(3, (index) {
                    if (index < controller.imageController.additionalImagesBase64.length) {
                      return CircleAvatar(
                        radius: 40,
                        backgroundImage: MemoryImage(base64Decode(
                            controller.imageController.additionalImagesBase64[index]
                                .split(',')
                                .last)),
                        backgroundColor: Colors.deepPurpleAccent,
                      );
                    } else {
                      return const CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.deepPurpleAccent,
                        child: Icon(FontAwesomeIcons.image,
                            color: Colors.white, size: 20),
                      );
                    }
                  }),
                ),
                const SizedBox(height: 10),
                // Additional Images Upload Button
                ElevatedButton.icon(
                  onPressed: () async {
                    await controller.imageController.pickAdditionalImages();
                  },
                  icon: const Icon(FontAwesomeIcons.upload, color: Colors.white),
                  label: const Text('Upload Additional Images',
                      style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Product Name
                _buildTextField(
                  controller: controller.nameController,
                  label: 'Name',
                  icon: FontAwesomeIcons.tag,
                ),
                const SizedBox(height: 10),
                // Product Slug
                _buildTextField(
                  controller: controller.slugController,
                  label: 'Slug',
                  icon: FontAwesomeIcons.link,
                ),
                const SizedBox(height: 10),
                // Product Price
                _buildTextField(
                  controller: controller.priceController,
                  label: 'Price',
                  icon: FontAwesomeIcons.dollarSign,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10),
                // Product Quantity
                _buildTextField(
                  controller: controller.quantityController,
                  label: 'Quantity',
                  icon: FontAwesomeIcons.cubes,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10),
                // Product Summary
                _buildTextField(
                  controller: controller.summaryController,
                  label: 'Summary',
                  icon: FontAwesomeIcons.stickyNote,
                ),
                const SizedBox(height: 10),
                // Product Description
                _buildTextField(
                  controller: controller.descriptionController,
                  label: 'Description',
                  icon: FontAwesomeIcons.infoCircle,
                ),
                const SizedBox(height: 10),
                // Product Category
                _buildTextField(
                  controller: controller.categoryController,
                  label: 'Category',
                  icon: FontAwesomeIcons.list,
                ),
                const SizedBox(height: 10),
                // Product Brand
                _buildTextField(
                  controller: controller.brandController,
                  label: 'Brand',
                  icon: FontAwesomeIcons.brandsFontAwesome,
                ),
                const SizedBox(height: 10),
                // Product Size
                _buildTextField(
                  controller: controller.sizeController,
                  label: 'Size',
                  icon: FontAwesomeIcons.textHeight,
                ),
                const SizedBox(height: 10),
                // Video URL
                _buildTextField(
                  controller: controller.videoController,
                  label: 'Video URL',
                  icon: FontAwesomeIcons.video,
                ),
                const SizedBox(height: 20),
                // Create Product Button
                controller.isLoading.value
                    ? const CircularProgressIndicator()
                    : ElevatedButton.icon(
                  onPressed: () async {
                    await controller.createProduct((product, {errorMessage}) {
                      if (product != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Product created successfully!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      } else {
                        print(errorMessage);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Error: $errorMessage'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    });
                  },
                  icon: const Icon(FontAwesomeIcons.save, color: Colors.white),
                  label: const Text('Create Product',
                      style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  // Helper method to build TextFields
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.deepPurple),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      ),
    );
  }
}
