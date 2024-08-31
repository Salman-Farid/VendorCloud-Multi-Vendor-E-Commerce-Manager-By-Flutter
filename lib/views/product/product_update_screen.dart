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
import '../../models/product_model.dart';

class ProductUpdateScreen extends GetView<ProductController> {
  static const routeName = "/productUpdateScreen";
  final Product product;

  ProductUpdateScreen({Key? key, required this.product}) : super(key: key);
  final CategoryController categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    _initializeControllers();

    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Update Product', style: TextStyle(color: Colors.white)),
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
                  _buildProductDetailsSection(),
                  const SizedBox(height: 32),
                  packaging(
                    controller: controller,
                  ),
                  const SizedBox(height: 32),
                  _buildUpdateButton(),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  void _initializeControllers() {
    controller.nameController.text = product.name ?? '';
    controller.slugController.text = product.slug ?? '';
    //controller.priceController.text = product.price?.toString() ?? '';
    //controller.quantityController.text = product.quantity?.toString() ?? '';
    controller.summaryController.text = product.summary ?? '';
    controller.descriptionController.text = product.description ?? '';
    controller.categoryController.text = product.category ?? '';
    controller.subCategoryController.text = product.subCategory ?? '';
    controller.brandController.text = product.brand ?? '';
   // controller.videoController.text = product.video ?? '';
    controller.warrantyController.text = product.warranty ?? '';
    controller.weightController.text = product.packaging?.weight ?? '';
    controller.heightController.text = product.packaging?.height ?? '';
    controller.widthController.text = product.packaging?.width ?? '';
    controller.dimensionController.text = product.packaging?.dimension ?? '';

    try {
      // Initialize media controllers
      if (product.coverPhoto != null && product.coverPhoto.secureUrl != null) {
        String coverPhotoUrl =
            "https://baburhaatbd.com${product.coverPhoto.secureUrl}";
        print('The cover photo url is: $coverPhotoUrl');
        controller.mediaController.setCoverPhoto(coverPhotoUrl);
      }

      if (product.images != null) {
        List<String> imageUrls = product.images!
            .where((image) => image != null && image.secureUrl != null)
            .map((dynamic image) => "https://baburhaatbd.com${image.secureUrl}")
            .toList();
        controller.mediaController.setAdditionalImages(imageUrls);
      }

      if (product.video != null && product.video.secureUrl != null) {
        String videoUrl = "https://baburhaatbd.com${product.video.secureUrl}";
        controller.mediaController.setVideo(videoUrl);
      }
    } catch (e) {
      print('Error initializing media controllers: $e');
      Get.snackbar('Error', 'Failed to load product media');
    }
  }

  Widget _buildProductDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Product Details',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple),
        ),
        const SizedBox(height: 16),
        buildTextField(
            controller: controller.nameController,
            label: 'Name',
            icon: FontAwesomeIcons.tag),
        const SizedBox(height: 16),
        buildTextField(
            controller: controller.slugController,
            label: 'Slug',
            icon: FontAwesomeIcons.link),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
                child: buildTextField(
                    controller: controller.priceController,
                    label: 'Price',
                    icon: FontAwesomeIcons.dollarSign,
                    keyboardType: TextInputType.number)),
            const SizedBox(width: 16),
            Expanded(
                child: buildTextField(
                    controller: controller.quantityController,
                    label: 'Quantity',
                    icon: FontAwesomeIcons.cubes,
                    keyboardType: TextInputType.number)),
          ],
        ),
        const SizedBox(height: 16),
        buildTextField(
            controller: controller.summaryController,
            label: 'Summary',
            icon: FontAwesomeIcons.alignLeft,
            maxLines: 3),
        const SizedBox(height: 16),
        buildTextField(
            controller: controller.descriptionController,
            label: 'Description',
            icon: FontAwesomeIcons.alignJustify,
            maxLines: 5),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
                child: DropDownButtonForCategory(
                    categoryController: categoryController)),
            const SizedBox(width: 16),
            Expanded(
                child: DropDownButtonSubCategory(
                    categoryController: categoryController,
                    controller: controller)),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: buildTextField(
                  controller: controller.brandController,
                  label: 'Brand',
                  icon: FontAwesomeIcons.trademark),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: buildTextField(
                  controller: controller.warrantyController,
                  label: 'Warranty',
                  icon: FontAwesomeIcons.shield),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildUpdateButton() {
    return ElevatedButton(
      onPressed: controller.isLoading.value ? null : _handleUpdateProduct,
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
            : const Text(
                'Update Product',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple),
              ),
      ),
    );
  }

  //
  // void _handleUpdateProduct() async {
  //   final Map<String, dynamic> productData = {
  //     'id': product.id,
  //     'user': product.user,
  //     'video': controller.mediaController.videoBase64.isNotEmpty
  //         ? controller.mediaController.videoBase64
  //         : controller.videoController.text,
  //     'name': controller.nameController.text,
  //     'slug': controller.slugController.text,
  //     'price': int.tryParse(controller.priceController.text) ?? 0,
  //     'quantity': int.tryParse(controller.quantityController.text) ?? 0,
  //     'summary': controller.summaryController.text,
  //     'description': controller.descriptionController.text,
  //     'category': controller.categoryController.text,
  //     'subCategory': controller.subCategoryController.text,
  //     'images': controller.mediaController.additionalImagesBase64,
  //     'brand': controller.brandController.text,
  //     'warranty': controller.warrantyController.text,
  //     'packaging': Packaging(
  //       weight: controller.weightController.text,
  //       height: controller.heightController.text,
  //       width: controller.widthController.text,
  //       dimension: controller.dimensionController.text,
  //     ),
  //   };
  //
  //   if (controller.mediaController.imageBase64 != null) {
  //     productData['coverPhoto'] = controller.mediaController.imageBase64;
  //   }
  //
  //   final updatedProduct = Product.fromMap(productData);
  //
  //   await controller.updateProductById(
  //     product.id!,
  //     updatedProduct,
  //         (updatedProduct, {errorMessage}) {
  //       if (updatedProduct != null) {
  //         ScaffoldMessenger.of(Get.context!).showSnackBar(
  //           const SnackBar(
  //             duration: Duration(seconds: 3),
  //             content: Text('Product updated successfully!'),
  //             backgroundColor: Colors.green,
  //           ),
  //         );
  //         Get.back();
  //       } else {
  //         ScaffoldMessenger.of(Get.context!).showSnackBar(
  //           SnackBar(
  //             content: Text('Error: $errorMessage'),
  //             backgroundColor: Colors.red,
  //           ),
  //         );
  //       }
  //     },
  //   );
  // }
  //
  //

  void _handleUpdateProduct() async {
    final updatedProduct = Product(
      id: product.id,
      user: product.user,
      coverPhoto: controller.mediaController.imageBase64,
      video: controller.mediaController.videoBase64.isNotEmpty
          ? controller.mediaController.videoBase64
          : controller.videoController.text,
      name: controller.nameController.text,
      slug: controller.slugController.text,
      price: int.tryParse(controller.priceController.text) ?? 0,
      quantity: int.tryParse(controller.quantityController.text) ?? 0,
      summary: controller.summaryController.text,
      description: controller.descriptionController.text,
      category: controller.categoryController.text,
      subCategory: controller.subCategoryController.text,
      images: controller.mediaController.additionalImagesBase64,
      brand: controller.brandController.text,
      warranty: controller.warrantyController.text,
      packaging: Packaging(
        weight: controller.weightController.text,
        height: controller.heightController.text,
        width: controller.widthController.text,
        dimension: controller.dimensionController.text,
      ),
    );

    await controller.updateProductById(
      product.id!,
      updatedProduct,
      (updatedProduct, {errorMessage}) {
        if (updatedProduct != null) {
          ScaffoldMessenger.of(Get.context!).showSnackBar(
            const SnackBar(
              duration: Duration(seconds: 3),
              content: Text('Product updated successfully!'),
              backgroundColor: Colors.green,
            ),
          );
          Get.back();
        } else {
          ScaffoldMessenger.of(Get.context!).showSnackBar(
            SnackBar(
              content: Text('Error: $errorMessage'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
    );
  }
}
