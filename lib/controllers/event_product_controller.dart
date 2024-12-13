import 'dart:ui';
import 'package:get/get.dart';
import '../models/product_model.dart';
import '../models/event_model.dart';
import '../models/pachakge_model.dart';
import '../services/add_product_to_event_package_service.dart';
import '../controllers/product_controller.dart';
import '../controllers/user_controller.dart';
import 'event_ad_management_controller.dart';

class EventManagementController extends GetxController {
  static EventManagementController get instance => Get.find();

  final ProductController productController = Get.put(ProductController());
  RxList<Product> eventProducts = <Product>[].obs;
  RxList<Product> availableProducts = <Product>[].obs;
  RxBool isLoading = false.obs;

  final _eventProductRepository = EventProductRepository();
  final error = ''.obs;
  final UserController userController = Get.find<UserController>();

  late final GenericController<dynamic> parentController;
  final bool isPackage;

  EventManagementController({this.isPackage = true}) {
    parentController = isPackage
        ? Get.find<GenericController<Package>>(tag: 'package')
        : Get.find<GenericController<Event>>(tag: 'event');
  }

  @override
  void onInit() {
    super.onInit();
    syncProductsWithEvent();
  }

  Future<void> syncProductsWithEvent({String? parentId}) async {
    try {
      isLoading.value = true;

      // Get all products
      await productController.getProducts();
      final allProducts = productController.products;

      // Reset lists
      eventProducts.clear();
      //availableProducts.value = allProducts;

      // If no items in parent controller, return
      if (parentController.items.isEmpty) return;

      // Determine which items to process
      final itemsToProcess = parentId != null
          ? [parentController.items.firstWhere((item) => item.sId == parentId)]
          : parentController.items;

      // Process each item
      for (var currentItem in itemsToProcess) {
        // Extract products based on whether it's package or event
        final itemProducts = isPackage
            ? currentItem.packageProducts?.map((pp) => pp.product).toList() ?? []
            : currentItem.eventProducts?.map((ep) => ep.product).toList() ?? [];

        // Add to event products if not already present
        for (var product in itemProducts) {
          if (product != null && !eventProducts.any((p) => p.id == product.id)) {
            eventProducts.add(product);
          }
        }

        // Update available products
        availableProducts.value = itemProducts.da;

        //     availableProducts.where((product) =>
        // !eventProducts.any((eventProduct) => eventProduct.id == product.id)
        // ).toList();
      }
    } catch (e) {
      error.value = e.toString();
      print('Failed to sync products: $error');
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

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

  void removeProductFromAvailable(Product product) {
    availableProducts.remove(product);
    eventProducts.add(product);
  }

  Future<void> removeProductFromEvent(String productId) async {
    try {
      isLoading.value = true;

      final success = await _eventProductRepository.deletePackageProduct(productId);

      if (success) {
        final product = eventProducts.firstWhere(
              (prod) => prod.id == productId,
          orElse: () => throw 'Product not found',
        );

        eventProducts.remove(product);
        availableProducts.add(product);

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