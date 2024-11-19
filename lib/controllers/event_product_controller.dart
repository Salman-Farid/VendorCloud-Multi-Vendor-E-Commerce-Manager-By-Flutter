import 'dart:ui';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:karmalab_assignment/controllers/product_controller.dart';
import 'package:karmalab_assignment/controllers/user_controller.dart';
import '../models/product_model.dart';
import '../services/add_product_to_event_package_service.dart';

class EventManagementController extends GetxController {
  static EventManagementController get instance => Get.find();

  final ProductController productController = Get.put(ProductController());
  RxList<Product> eventProducts = <Product>[].obs; // Products in the event
  RxList<Product> availableProducts = <Product>[].obs; // Products not in the event
  RxBool isLoading = false.obs;

  final _eventProductRepository = EventProductRepository();
  final error = ''.obs;
  final UserController userController = Get.find<UserController>();

  @override
  void onInit() {
    super.onInit();
    syncProductsWithEvent();
  }

  /// Fetch products from server and sync available and event products
  Future<void> syncProductsWithEvent() async {
    try {
      isLoading.value = true;

      // Fetch all available products from the product controller
      productController.getProducts();
      final allProducts = productController.products;

      // Fetch a single event product from the repository
      final eventProduct = await _eventProductRepository.getEventProducts();

      if (eventProduct != null) {
        // Add the single event product to the eventProducts list
        if (!eventProducts.any((p) => p.id == eventProduct.id)) {
          eventProducts.add(eventProduct);
        }

        // Remove the event product from availableProducts
        availableProducts.value = allProducts
            .where((product) => product.id != eventProduct.id)
            .toList();
      } else {
        Get.snackbar('Error', 'Failed to fetch event products.');
      }
    } catch (e) {
      error.value = e.toString();
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// Mock API call to fetch product IDs assigned to an event
  /// Add product to event and update lists
  Future<void> addProductToEventOrPackage(Product product, String parentId) async {
    try {
      isLoading.value = true;
      error.value = '';

      final user = userController.user.value;
      if (user == null) throw 'User not found';

      final productData = {
        'user': user.id,
        'product': product.id,
        'parentId': parentId,
        'name': product.name,
      };

      final success = await _eventProductRepository.addProductToPackage(productData);

      if (success) {
        removeProductFromAvailable(product); // Sync lists after adding
        Get.snackbar('Success', '${product.name} added successfully');
      } else {
        Get.snackbar('Error', 'Failed to add ${product.name}');
      }
    } catch (e) {
      error.value = e.toString();
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// Remove product from available and add to event products
  void removeProductFromAvailable(Product product) {
    availableProducts.remove(product);
    eventProducts.add(product);
  }

  /// Remove product from event and update lists
  Future<void> removeProductFromEvent(String productId) async {
    try {
      isLoading.value = true;

      final success = await _eventProductRepository.deletePackageProduct(productId);

      if (success) {
        // Update lists
        final product = eventProducts.firstWhere((prod) => prod.id == productId,);
        if (product != null) {
          eventProducts.remove(product);
          availableProducts.add(product);
        }
        Get.snackbar('Success', 'Product removed successfully');
      } else {
        Get.snackbar('Error', 'Failed to remove product');
      }
    } catch (e) {
      error.value = e.toString();
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
