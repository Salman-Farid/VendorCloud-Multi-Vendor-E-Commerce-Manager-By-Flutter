import 'dart:ui';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:karmalab_assignment/controllers/product_controller.dart';
import '../models/product_model.dart';

class EventManagementController extends GetxController {
  final ProductController productController = Get.put(ProductController());
  RxList<Product> eventProducts = <Product>[].obs;
  final RxBool isDragging = false.obs;
  Rx<Offset> offset = const Offset(0, 0).obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getProducts();
  }



  var draggingIndex = Rxn<int>(); // Add this line

  // Add these methods to manage dragging index
  void startDragging(int index) {
    draggingIndex.value = index;
  }

  void stopDragging() {
    draggingIndex.value = null;
  }

  void setDragging(bool value) {
    isDragging.value = value;
  }

  void getProducts() {
    productController.getProducts();
  }

  // Offset state


  // Method to update offset
  void updateOffset(Offset newOffset) {
    offset.value = newOffset;
  }

  Future<bool?> addProductToEvent(Product product) async {
    isLoading.value = true;
    final url = Uri.parse('https://baburhaatbd.com/api/event-products');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'user': '66b8af66fc3c520a4f5633b0',
          'product': product.id,
          'event': '66c761bf2ccec42bb3af98f3',
          'name': product.name,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar('Success', '${product.name} added to event');
        removeProductFromGrid(product);
        return true;
      } else {
        Get.snackbar('Error', 'Failed to add ${product.name} to event');
        return false;
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading.value = false;
    }
    return null;
  }

  void removeProductFromGrid(Product product) {
    productController.products.remove(product);
    eventProducts.add(product);
  }
}
