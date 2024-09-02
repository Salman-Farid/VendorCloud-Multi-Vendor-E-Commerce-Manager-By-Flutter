import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/product_model.dart';
import '../services/product_service.dart';
import 'image_controller.dart';
import 'user_controller.dart';

class ProductController extends GetxController {
  final ProductService _productService = ProductService();
  final MediaController mediaController = Get.put(MediaController());
  final UserController userController = Get.find<UserController>();

  // Product details controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _slugController = TextEditingController();
  // final TextEditingController _priceController = TextEditingController();
  // final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _summaryController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _videoController = TextEditingController();
  final TextEditingController _subCategoryController = TextEditingController();
  final TextEditingController _warrantyController = TextEditingController();

  // Product variant controllers_
  final TextEditingController _variantNameController = TextEditingController();

  final TextEditingController _variantPriceController = TextEditingController();
  final TextEditingController _variantDiscountController = TextEditingController();
  final TextEditingController _variantQuantityController = TextEditingController();
  final TextEditingController _variantColorController = TextEditingController();
  final TextEditingController _variantMaterialController = TextEditingController();
  final TextEditingController _variantSizeController = TextEditingController();
  final TextEditingController _variantGenderController = TextEditingController();
  final TextEditingController _variantImageController = TextEditingController();

  // Packaging details controllers
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _widthController = TextEditingController();
  final TextEditingController _dimensionController = TextEditingController();

  var isLoading = false.obs;
  var productList = <Product>[].obs;

  @override
  void onInit() {
    _initializeVariantControllers();
    super.onInit();
  }

  // Getters for the controllers
  TextEditingController get nameController => _nameController;
  TextEditingController get slugController => _slugController;
  // TextEditingController get priceController => _priceController;
  // TextEditingController get quantityController => _quantityController;
  TextEditingController get summaryController => _summaryController;
  TextEditingController get descriptionController => _descriptionController;
  TextEditingController get categoryController => _categoryController;
  TextEditingController get brandController => _brandController;
  TextEditingController get videoController => _videoController;
  TextEditingController get subCategoryController => _subCategoryController;
  TextEditingController get warrantyController => _warrantyController;
  TextEditingController get weightController => _weightController;
  TextEditingController get heightController => _heightController;
  TextEditingController get widthController => _widthController;
  TextEditingController get dimensionController => _dimensionController;

  // Variant Controllers Getters
  TextEditingController get variantNameController => _variantNameController;
  TextEditingController get variantPriceController => _variantPriceController;
  TextEditingController get variantSizeController => _variantSizeController;
  TextEditingController get variantDiscountController => _variantDiscountController;
  TextEditingController get variantQuantityController => _variantQuantityController;
  TextEditingController get variantMaterialController => _variantMaterialController;
  TextEditingController get variantGenderController => _variantGenderController;
  TextEditingController get variantColorController => _variantColorController;

//variant index

  var variantCount = 1.obs;
  var variantNameControllers = <TextEditingController>[].obs;
  var variantPriceControllers = <TextEditingController>[].obs;
  var variantQuantityControllers = <TextEditingController>[].obs;
  var variantSizeControllers = <TextEditingController>[].obs;
  var variantColorControllers = <TextEditingController>[].obs;
  var variantMaterialControllers = <TextEditingController>[].obs;
  var variantGenderControllers = <TextEditingController>[].obs;


  void _initializeVariantControllers() {
    variantNameControllers.add(TextEditingController());
    variantPriceControllers.add(TextEditingController());
    variantQuantityControllers.add(TextEditingController());
    variantSizeControllers.add(TextEditingController());
    variantColorControllers.add(TextEditingController());
    variantMaterialControllers.add(TextEditingController());
    variantGenderControllers.add(TextEditingController());
  }

  void setVariantCount(int count) {
    variantCount.value = count;
    while (variantNameControllers.length < count) {
      _initializeVariantControllers();
    }
    while (variantNameControllers.length > count) {
      variantNameControllers.removeLast();
      variantPriceControllers.removeLast();
      variantQuantityControllers.removeLast();
      variantSizeControllers.removeLast();
      variantColorControllers.removeLast();
      variantMaterialControllers.removeLast();
      variantGenderControllers.removeLast();
    }
  }

  void updateVariantImage(String variantId) async {
    await mediaController.imagePickerAndBase64Conversion(variantId: variantId);
    final variantImageBase64 = mediaController.variantImageBase64;
    mediaController.setVariantImage(variantId, variantImageBase64);
  }





  // Getter for products
  List<Product> get products => productList;

  // Add method to pick additional images
  Future<void> pickAdditionalImages() async {
    await mediaController.pickAdditionalImages();
  }

  bool validate() {
    final name = nameController.text.trim();
    // final price = priceController.text.trim();
    // final quantity = quantityController.text.trim();
    final coverPhoto = mediaController.imageBase64;
    final additionalImages = mediaController.additionalImagesBase64;

    if (name.isEmpty  || coverPhoto.isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Please fill all required fields',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    // if (double.tryParse(price) == null) {
    //   Get.snackbar(
    //     'Validation Error',
    //     'Price must be a valid number.',
    //     snackPosition: SnackPosition.BOTTOM,
    //   );
    //   return false;
    // }

    // if (int.tryParse(quantity) == null) {
    //   Get.snackbar(
    //     'Validation Error',
    //     'Quantity must be a valid number.',
    //     snackPosition: SnackPosition.BOTTOM,
    //   );
    //   return false;
    // }

    if (additionalImages.isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Please upload at least one additional image.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    return true;
  }

  // Create product
  Future<void> createProduct(Function(bool, {String? errorMessage})? onCreate) async {
    final valid = validate();
    final user = userController.user.value;
    if (valid) {
      final product = Product(
        user: user!.id,
        coverPhoto: mediaController.imageBase64,
        video: mediaController.videoBase64.isNotEmpty
            ? mediaController.videoBase64
            : videoController.text,
        name: nameController.text,
        slug: slugController.text,
        summary: summaryController.text,
        description: descriptionController.text,
        category: categoryController.text,
        subCategory: subCategoryController.text,
        images: mediaController.additionalImagesBase64,
        brand: brandController.text,
        warranty: warrantyController.text,
        packaging: Packaging(
          weight: weightController.text,
          height: heightController.text,
          width: widthController.text,
          dimension: dimensionController.text,
        ),
        variants: [
          ProductVariant(
            user: user.id,
            name: variantNameController.text,
            price: int.tryParse(variantPriceController.text) ?? 0,
            discount: int.tryParse(variantDiscountController.text) ?? 0,
            quantity: int.tryParse(variantQuantityController.text) ?? 0,
            material: variantMaterialController.text,
            size: variantSizeController.text,
            gender: variantGenderController.text,
            color: variantColorController.text,
            image: mediaController.getVariantImage('variant_$variantCount'),
          ),
        ],
      );

      try {
        isLoading.value = true;
        final createdProduct = await _productService.createProduct(product.toJson());
        isLoading.value = false;
        if (onCreate != null) {
          onCreate(createdProduct);
        }
      } catch (e) {
        isLoading.value = false;
        if (onCreate != null) onCreate(false, errorMessage: e.toString());
      }
    }
  }

  // Fetch all products
  Future<void> getProducts() async {
    try {
      isLoading.value = true;
      final productResponse = await _productService.getProducts();
      isLoading.value = false;
      if (productResponse != null && productResponse.data != null) {
        productList.assignAll(productResponse.data!);
      } else {
        productList.clear();
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to fetch products: $e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  // Fetch product by ID
  Future<void> getProductById(String id, Function(Product, {String? errorMessage})?) async {
  try {
  isLoading.value = true;
  final productResponse = await _productService.getProductById(id);
  isLoading.value = false;
  if (productResponse != null && productResponse.data != null) {
  productList.assignAll(productResponse.data!);
  } else {
  productList.clear();
  }
  } catch (e) {
  isLoading.value = false;
  Get.snackbar('Error', 'Failed to fetch products: $e',
  snackPosition: SnackPosition.BOTTOM);
  }
}

// Update product
Future<void> updateProductById(String id, Product product, Function(bool, {String? errorMessage})? onUpdate) async {
  try {
    isLoading.value = true;
    final bool isUpdated = await _productService.updateProductById(id, product.toJson());
    isLoading.value = false;

    if (isUpdated) {
      if (onUpdate != null) onUpdate(true);
    } else {
      if (onUpdate != null) onUpdate(false, errorMessage: 'Failed to update product.');
    }
  } catch (e) {
    isLoading.value = false;
    if (onUpdate != null) onUpdate(false, errorMessage: e.toString());
  }
}

// Delete product
Future<void> deleteProduct(String id, Function(bool, {String? errorMessage})? onDelete) async {
  try {
    isLoading.value = true;
    final bool isDeleted = await _productService.deleteProductById(id);
    isLoading.value = false;

    if (isDeleted) {
      productList.removeWhere((product) => product.id == id);
      if (onDelete != null) onDelete(true);
    } else {
      if (onDelete != null) onDelete(false, errorMessage: 'Failed to delete product.');
    }
  } catch (e) {
    isLoading.value = false;
    if (onDelete != null) onDelete(false, errorMessage: e.toString());
  }
}
}











// //
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../models/product_model.dart';
// import '../services/product_service.dart';
// import 'image_controller.dart';
// import 'user_controller.dart';
//
// class ProductController extends GetxController {
//   final ProductService _productService = ProductService();
//   final MediaController mediaController = Get.put(MediaController());
//
//   final UserController userController = Get.find<UserController>();
//
//   // Controllers for product details
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _slugController = TextEditingController();
//   final TextEditingController _priceController = TextEditingController();
//   final TextEditingController _quantityController = TextEditingController();
//   final TextEditingController _summaryController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();
//   final TextEditingController _categoryController = TextEditingController();
//   final TextEditingController _brandController = TextEditingController();
//   final TextEditingController _sizeController = TextEditingController();
//   final TextEditingController _videoController = TextEditingController();
//   final TextEditingController _discountController = TextEditingController();
//   final TextEditingController _subCategoryController = TextEditingController();
//   final TextEditingController _warrantyController = TextEditingController();
//
//   // Controllers for packaging details
//   final TextEditingController _weightController = TextEditingController();
//   final TextEditingController _heightController = TextEditingController();
//   final TextEditingController _widthController = TextEditingController();
//   final TextEditingController _dimensionController = TextEditingController();
//
//   var isLoading = false.obs;
//   var productList = <Product>[].obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//   }
//
//   // Getters for the controllers
//   TextEditingController get nameController => _nameController;
//   TextEditingController get slugController => _slugController;
//   TextEditingController get priceController => _priceController;
//   TextEditingController get quantityController => _quantityController;
//   TextEditingController get summaryController => _summaryController;
//   TextEditingController get descriptionController => _descriptionController;
//   TextEditingController get categoryController => _categoryController;
//   TextEditingController get brandController => _brandController;
//   TextEditingController get videoController => _videoController;
//   TextEditingController get subCategoryController => _subCategoryController;
//   TextEditingController get warrantyController => _warrantyController;
//   TextEditingController get weightController => _weightController;
//   TextEditingController get heightController => _heightController;
//   TextEditingController get widthController => _widthController;
//   TextEditingController get dimensionController => _dimensionController;
//
//   // Getter for products
//   List<Product> get products => productList;
//
//   // Add method to pick additional images
//   Future<void> pickAdditionalImages() async {
//     await mediaController.pickAdditionalImages();
//   }
//
//   bool validate() {
//     final name = nameController.text.trim();
//     final price = priceController.text.trim();
//     final quantity = quantityController.text.trim();
//     final coverPhoto = mediaController.imageBase64;
//     final additionalImages = mediaController.additionalImagesBase64;
//
//     if (name.isEmpty ||
//         price.isEmpty ||
//         quantity.isEmpty ||
//         coverPhoto.isEmpty) {
//       Get.snackbar(
//         'Validation Error',
//         'Please fill all required fields and upload a cover photo.',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//       return false;
//     }
//
//     if (double.tryParse(price) == null) {
//       Get.snackbar(
//         'Validation Error',
//         'Price must be a valid number.',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//       return false;
//     }
//
//     if (int.tryParse(quantity) == null) {
//       Get.snackbar(
//         'Validation Error',
//         'Quantity must be a valid number.',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//       return false;
//     }
//
//     if (additionalImages.isEmpty) {
//       Get.snackbar(
//         'Validation Error',
//         'Please upload at least one additional image.',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//       return false;
//     }
//
//     return true;
//   }
//
//   // Create product
//   Future<void> createProduct(
//       Function(bool, {String? errorMessage})? onCreate) async {
//     final valid = validate();
//     final user = userController.user.value;
//     if (valid) {
//       final product = Product(
//         user: user!.id,
//         coverPhoto: mediaController.imageBase64,
//         video: mediaController.videoBase64.isNotEmpty
//             ? mediaController.videoBase64
//             : videoController.text,
//         name: nameController.text,
//         slug: slugController.text,
//         price: int.tryParse(priceController.text) ?? 0,
//         quantity: int.tryParse(quantityController.text) ?? 0,
//         summary: summaryController.text,
//         description: descriptionController.text,
//         category: categoryController.text,
//         subCategory: subCategoryController.text,
//         images: mediaController.additionalImagesBase64,
//         brand: brandController.text,
//         warranty: warrantyController.text,
//         packaging: Packaging(
//           weight: weightController.text,
//           height: heightController.text,
//           width: widthController.text,
//           dimension: dimensionController.text,
//         ),
//       );
//
//       try {
//         isLoading.value = true;
//         final createdProduct =
//             await _productService.createProduct(product.toJson());
//         isLoading.value = false;
//         if (onCreate != null) {
//           onCreate(createdProduct);
//         }
//       } catch (e) {
//         isLoading.value = false;
//         if (onCreate != null) onCreate(false, errorMessage: e.toString());
//       }
//     }
//   }
//
//   // Fetch all products
//   Future<void> getProducts() async {
//     try {
//       isLoading.value = true;
//       final productResponse = await _productService.getProducts();
//       isLoading.value = false;
//       if (productResponse != null && productResponse.data != null) {
//         productList.assignAll(productResponse.data!);
//       } else {
//         productList.clear();
//       }
//     } catch (e) {
//       isLoading.value = false;
//       Get.snackbar('Error', 'Failed to fetch products: $e',
//           snackPosition: SnackPosition.BOTTOM);
//     }
//   }
//
//   // Fetch product by ID
//   Future<void> getProductById(
//       String id, Function(Product, {String? errorMessage})?) async {
//     try {
//       isLoading.value = true;
//       final productResponse = await _productService.getProductById(id);
//       isLoading.value = false;
//       if (productResponse != null && productResponse.data != null) {
//         productList.assignAll(productResponse.data!);
//       } else {
//         productList.clear();
//       }
//     } catch (e) {
//       isLoading.value = false;
//       Get.snackbar('Error', 'Failed to fetch products: $e',
//           snackPosition: SnackPosition.BOTTOM);
//     }
//   }
//
// //Update product
// Future<void> updateProductById(String id, Product product,
//     Function(bool, {String? errorMessage})? onUpdate) async {
//   try {
//     isLoading.value = true;
//     final bool isUpdated = await _productService.updateProductById(id, product.toJson());
//     isLoading.value = false;
//
//     if (isUpdated) {
//       if (onUpdate != null) onUpdate(true); // Call the callback with success
//     } else {
//       if (onUpdate != null) onUpdate(false, errorMessage: 'Failed to update product.');
//     }
//   } catch (e) {
//     isLoading.value = false;
//     if (onUpdate != null) onUpdate(false, errorMessage: e.toString());
//   }
// }
//
//
//
// // Delete product
//   Future<void> deleteProduct(
//       String id, Function(bool, {String? errorMessage})? onDelete) async {
//     try {
//       isLoading.value = true;
//       final success = await _productService.deleteProductById(id);
//       isLoading.value = false;
//       if (onDelete != null) onDelete(success);
//     } catch (e) {
//       isLoading.value = false;
//       if (onDelete != null) onDelete(false, errorMessage: e.toString());
//     }
//   }
// }
