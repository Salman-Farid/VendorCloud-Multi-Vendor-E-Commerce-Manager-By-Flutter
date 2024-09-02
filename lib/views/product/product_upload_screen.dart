import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:karmalab_assignment/views/product/widgets/additioal_images.dart';
import 'package:karmalab_assignment/views/product/widgets/categoryDropDown.dart';
import 'package:karmalab_assignment/views/product/widgets/coverphoto.dart';
import 'package:karmalab_assignment/views/product/widgets/packaging.dart';
import 'package:karmalab_assignment/views/product/widgets/subCategoryDropDown.dart';
import 'package:karmalab_assignment/views/product/widgets/textField.dart';
import 'package:karmalab_assignment/views/product/widgets/video.dart';
import '../../controllers/product_controller.dart';
import '../../controllers/category_controller.dart';
import '../commonWidgets/handleButtonOperation.dart';

class ProductCreationScreen extends GetView<ProductController> {
  static const routeName = "/productUploadScreen";

  final CategoryController categoryController = Get.put(CategoryController());

  final List<String> colorOptions = [
    'Red', 'Blue', 'Green', 'Yellow', 'Black', 'White', 'Purple', 'Orange', 'Pink', 'Brown'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Product', style: TextStyle(color: Colors.white)),
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
                  coverPhotoSection(controller: controller),
                  const SizedBox(height: 32),
                  AdditionalImagesSection(controller: controller),
                  const SizedBox(height: 32),
                  videoSection(controller: controller),
                  const SizedBox(height: 32),
                  const Text('Product Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
                  const SizedBox(height: 16),
                  buildTextField(controller: controller.nameController, label: 'Name', icon: FontAwesomeIcons.tag),
                  const SizedBox(height: 16),
                  buildTextField(controller: controller.slugController, label: 'Slug', icon: FontAwesomeIcons.link),

                  const SizedBox(height: 16),
                  buildTextField(controller: controller.summaryController, label: 'Summary', icon: FontAwesomeIcons.alignLeft, maxLines: 3),
                  const SizedBox(height: 16),
                  buildTextField(controller: controller.descriptionController, label: 'Description', icon: FontAwesomeIcons.alignJustify, maxLines: 5),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(child: DropDownButtonForCategory(categoryController: categoryController)),
                      const SizedBox(width: 16),
                      Expanded(child: DropDownButtonSubCategory(categoryController: categoryController, controller: controller)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(child: buildTextField(controller: controller.brandController, label: 'Brand', icon: FontAwesomeIcons.trademark)),
                      const SizedBox(width: 16),
                      Expanded(child: buildTextField(controller: controller.warrantyController, label: 'Warranty', icon: FontAwesomeIcons.shield)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  packaging(controller: controller),
                  const SizedBox(height: 32),

                  // Product Variants Section
                  const Text('Product Variants', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<int>(
                          decoration: const InputDecoration(
                            labelText: 'Number of Variants',
                            border: OutlineInputBorder(),
                          ),
                          value: controller.variantCount.value,
                          items: List.generate(10, (index) => DropdownMenuItem(
                            value: index + 1,
                            child: Text('${index + 1}'),
                          )),
                          onChanged: (value) {
                            controller.setVariantCount(value!);
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ...List.generate(controller.variantCount.value, (index) => _buildVariantFields(index)),

                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: controller.isLoading.value ? null : _handleCreateProduct,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.deepPurple,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: const BorderSide(color: Colors.deepPurple),
                      ),
                      elevation: 0,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: controller.isLoading.value
                          ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
                          strokeWidth: 2.0,
                        ),
                      )
                          : const Text('Create Product', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
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

  Widget _buildVariantFields(int index) {
    final image = controller.mediaController.getVariantImage('variant_$index').split(',').last;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Variant ${index + 1}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        buildTextField(controller: controller.variantNameControllers[index], label: 'Name', icon: FontAwesomeIcons.tag),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(child: buildTextField(controller: controller.variantPriceControllers[index], label: 'Price', icon: FontAwesomeIcons.dollarSign, keyboardType: TextInputType.number)),
            const SizedBox(width: 8),
            Expanded(child: buildTextField(controller: controller.variantQuantityControllers[index], label: 'Quantity', icon: FontAwesomeIcons.cubes, keyboardType: TextInputType.number)),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(child: buildTextField(controller: controller.variantSizeControllers[index], label: 'Size', icon: FontAwesomeIcons.rulerCombined)),
            const SizedBox(width: 8),
            Expanded(
              child: DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Color',
                  border: OutlineInputBorder(),
                ),
                value: controller.variantColorControllers[index].text.isEmpty ? null : controller.variantColorControllers[index].text,
                items: colorOptions.map((color) => DropdownMenuItem(value: color, child: Text(color))).toList(),
                onChanged: (value) {
                  controller.variantColorControllers[index].text = value!;
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(child: buildTextField(controller: controller.variantMaterialControllers[index], label: 'Material', icon: FontAwesomeIcons.tshirt)),
            const SizedBox(width: 8),
            Expanded(child: buildTextField(controller: controller.variantGenderControllers[index], label: 'Gender', icon: FontAwesomeIcons.venusMars)),
          ],
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => controller.updateVariantImage('variant_$index'),
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Obx(() => controller.mediaController.getVariantImage('variant_$index').isEmpty
                ? const Icon(Icons.add_photo_alternate, size: 40, color: Colors.grey)
                :

            Image.memory(base64Decode(image), fit: BoxFit.cover)
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  void _handleCreateProduct() {
    handleApiCallButton(
      controller.createProduct,
      successMessage: 'Product created successfully!',
      errorMessage: 'Failed to create product. Please try again.',
      onSuccess: () {
        // Get.back();
      },
      onError: (error) {
        // Optionally, handle specific error cases here
      },
    );
  }
}

















// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:karmalab_assignment/views/product/widgets/additioal_images.dart';
// import 'package:karmalab_assignment/views/product/widgets/categoryDropDown.dart';
// import 'package:karmalab_assignment/views/product/widgets/coverphoto.dart';
// import 'package:karmalab_assignment/views/product/widgets/packaging.dart';
// import 'package:karmalab_assignment/views/product/widgets/subCategoryDropDown.dart';
// import 'package:karmalab_assignment/views/product/widgets/textField.dart';
// import 'package:karmalab_assignment/views/product/widgets/video.dart';
// import '../../controllers/product_controller.dart';
// import '../../controllers/category_controller.dart';
// import '../commonWidgets/handleButtonOperation.dart';
//
// class ProductCreationScreen extends GetView<ProductController> {
//   static const routeName = "/productUploadScreen";
//
//   final CategoryController categoryController = Get.put(CategoryController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title:
//             const Text('Create Product', style: TextStyle(color: Colors.white)),
//         backgroundColor: Colors.deepPurple,
//         elevation: 0,
//       ),
//       body: Container(
//         color: Colors.white,
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(24.0),
//             child: Obx(() {
//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   // Cover Photo Section
//                   coverPhotoSection(controller: controller),
//                   const SizedBox(height: 32),
//                   // Additional Images Section
//                   AdditionalImagesSection(controller: controller),
//                   const SizedBox(height: 32),
//                   // Video Upload Section
//                   videoSection(controller: controller),
//                   const SizedBox(height: 32),
//                   // Product Details Section
//                   const Text('Product Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepPurple),),
//                   const SizedBox(height: 16),
//                   buildTextField(controller: controller.nameController, label: 'Name', icon: FontAwesomeIcons.tag,),
//                   const SizedBox(height: 16),
//                   buildTextField(controller: controller.slugController, label: 'Slug', icon: FontAwesomeIcons.link,),
//                   const SizedBox(height: 16),
//                   Row(
//                     children: [
//                       Expanded(child: buildTextField(controller: controller.priceController, label: 'Price', icon: FontAwesomeIcons.dollarSign, keyboardType: TextInputType.number,),),
//                       const SizedBox(width: 16),
//                       Expanded(child: buildTextField(controller: controller.quantityController, label: 'Quantity', icon: FontAwesomeIcons.cubes, keyboardType: TextInputType.number,),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 16),
//                   buildTextField(controller: controller.summaryController, label: 'Summary', icon: FontAwesomeIcons.alignLeft, maxLines: 3,),
//                   const SizedBox(height: 16),
//                   buildTextField(controller: controller.descriptionController, label: 'Description', icon: FontAwesomeIcons.alignJustify, maxLines: 5,),
//                   const SizedBox(height: 16),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: DropDownButtonForCategory(categoryController: categoryController),),
//                       const SizedBox(width: 16),
//                       Expanded(child: DropDownButtonSubCategory(categoryController: categoryController, controller: controller),
//                       )
//                     ],
//                   ),
//                   const SizedBox(height: 16),
//                   Row(
//                     children: [
//                       Expanded(child: buildTextField(controller: controller.brandController, label: 'Brand', icon: FontAwesomeIcons.trademark),),
//                       const SizedBox(width: 16),
//                       Expanded(child: buildTextField(controller: controller.warrantyController, label: 'Warranty', icon: FontAwesomeIcons.shield),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 16),
//                   packaging(controller: controller),
//                   const SizedBox(height: 32),
//                   // Create Product Button
//                   ElevatedButton(
//                     onPressed: controller.isLoading.value
//                         ? null
//                         : _handleCreateProduct,
//                     style: ElevatedButton.styleFrom(
//                       foregroundColor: Colors.deepPurple,
//                       backgroundColor: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(30),
//                         side: const BorderSide(color: Colors.deepPurple),
//                       ),
//                       elevation: 0,
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 16.0),
//                       child: controller.isLoading.value
//                           ? const SizedBox(
//                               width: 24,
//                               height: 24,
//                               child: CircularProgressIndicator(
//                                 valueColor: AlwaysStoppedAnimation<Color>(
//                                     Colors.deepPurple),
//                                 strokeWidth: 2.0,
//                               ),
//                             )
//                           : const Text('Create Product', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.deepPurple),),
//                     ),
//                   ),
//                 ],
//               );
//             }),
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _handleCreateProduct() {handleApiCallButton(controller.createProduct,
//       successMessage: 'Product created successfully!',
//       errorMessage: 'Failed to create product. Please try again.',
//       onSuccess: () {
//         // Get.back();
//       },
//       onError: (error) {
//         // Optionally, handle specific error cases here
//       },
//     );
//   }
//
//
// }