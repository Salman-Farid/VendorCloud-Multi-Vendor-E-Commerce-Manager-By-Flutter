import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../controllers/product_controller.dart';

class ProductCreationScreen extends GetView<ProductController> {
  static const routeName = "/productUploadScreen";

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
                  // Cover Photo Upload Section
                  Center(
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            await controller.imageController.imagePickerAndBase64Conversion();
                          },
                          onDoubleTap: () {
                            controller.imageController.removeCoverPhoto();
                          },
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(color: Colors.deepPurple, width: 2),
                              image: controller.imageController.imageBase64.isNotEmpty
                                  ? DecorationImage(
                                image: MemoryImage(base64Decode(controller.imageController.imageBase64.split(',').last)),
                                fit: BoxFit.cover,
                              )
                                  : null,
                            ),
                            child: controller.imageController.imageBase64.isEmpty
                                ? const Icon(FontAwesomeIcons.image, color: Colors.deepPurple, size: 40)
                                : null,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.deepPurple,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(FontAwesomeIcons.camera, color: Colors.white, size: 20),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Cover Photo',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                  ),
                  const SizedBox(height: 32),

                  // Additional Images Section
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [


                      Text(
                        'Additional Images',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                      ),


                      const SizedBox(height: 16),
                      // SizedBox(
                      //   height: 100,
                      //   child: ListView.builder(
                      //     scrollDirection: Axis.horizontal,
                      //     itemCount: 3,
                      //     itemBuilder: (context, index) {
                      //       if (index < controller.imageController.additionalImagesBase64.length) {
                      //         return Padding(
                      //           padding: const EdgeInsets.only(right: 16.0),
                      //           child: GestureDetector(
                      //             onDoubleTap: () => controller.imageController.removeImage(index),
                      //             onTap: () async {
                      //               await controller.imageController.pickAdditionalImages();
                      //             },
                      //             child: Container(
                      //               width: 100,
                      //               height: 100,
                      //               decoration: BoxDecoration(
                      //                 borderRadius: BorderRadius.circular(10),
                      //                 border: Border.all(color: Colors.deepPurple, width: 2),
                      //                 image: DecorationImage(
                      //                   image: MemoryImage(base64Decode(
                      //                       controller.imageController.additionalImagesBase64[index].split(',').last)),
                      //                   fit: BoxFit.cover,
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //         );
                      //       } else {
                      //         return Padding(
                      //           padding: const EdgeInsets.only(right: 16.0),
                      //           child: GestureDetector(
                      //             onTap: () async {
                      //               await controller.imageController.pickAdditionalImages();
                      //             },
                      //             child: Container(
                      //               width: 100,
                      //               height: 100,
                      //               decoration: BoxDecoration(
                      //                 borderRadius: BorderRadius.circular(10),
                      //                 border: Border.all(color: Colors.deepPurple, width: 2),
                      //               ),
                      //               child: const Icon(FontAwesomeIcons.plus, color: Colors.deepPurple, size: 30),
                      //             ),
                      //           ),
                      //         );
                      //       }
                      //     },
                      //   ),
                      // ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(3, (index) {
                          if (index < controller.imageController.additionalImagesBase64.length) {
                            return GestureDetector(
                              onDoubleTap: () {
                                controller.imageController.removeImage(index);
                              },
                              onTap: () async {
                                await controller.imageController.pickAdditionalImages();
                              },
                              // child: CircleAvatar(
                              //   radius: 40,
                              //   backgroundImage: MemoryImage(base64Decode(
                              //       controller.imageController.additionalImagesBase64[index]
                              //           .split(',')
                              //           .last)),
                              //   backgroundColor: Colors.deepPurpleAccent,
                              // ),


                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.deepPurple, width: 2),
                                  image: DecorationImage(
                                    image: MemoryImage(base64Decode(
                                        controller.imageController.additionalImagesBase64[index].split(',').last)),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),


                            );
                          } else {
                            return GestureDetector(
                              onTap: () async {
                                await controller.imageController.pickAdditionalImages();
                              },
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.deepPurple, width: 2),
                                ),
                                child: const Icon(FontAwesomeIcons.plus, color: Colors.deepPurple, size: 30),
                              ),
                            );
                          }
                        }),
                      ),


                      const SizedBox(height: 32),
                    ],
                  ),

                  // Product Details Section
                  const Text(
                    'Product Details',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepPurple),
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
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          controller: controller.categoryController,
                          label: 'Category',
                          icon: FontAwesomeIcons.layerGroup,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildTextField(
                          controller: controller.brandController,
                          label: 'Brand',
                          icon: FontAwesomeIcons.trademark,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: controller.sizeController,
                    label: 'Size',
                    icon: FontAwesomeIcons.rulerHorizontal,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: controller.videoController,
                    label: 'Video URL',
                    icon: FontAwesomeIcons.video,
                  ),
                  const SizedBox(height: 32),

                  // Create Product Button
                  ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : () async {
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
                          : const Text(
                        'Create Product',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.deepPurple,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: BorderSide(color: Colors.deepPurple),
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
          borderSide: BorderSide(color: Colors.deepPurple, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      ),
    );
  }
}