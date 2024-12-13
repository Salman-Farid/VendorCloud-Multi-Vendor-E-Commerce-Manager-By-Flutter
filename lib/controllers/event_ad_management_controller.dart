
import 'package:get/get.dart';
import 'package:karmalab_assignment/controllers/product_controller.dart';
import 'package:karmalab_assignment/controllers/user_controller.dart';
import '../models/event_model.dart';
import '../models/pachakge_model.dart';
import '../models/product_model.dart';
import '../services/ad_package_service.dart';
import '../services/add_product_to_event_package_service.dart';
import '../utils/popups/loaders.dart';

// class GenericController<T> extends GetxController {
//   final GenericRepository<T> repository;
//
//   GenericController(this.repository);
//
//
//   final ProductController productController = Get.put(ProductController());
//   RxList<Product> eventProducts = <Product>[].obs;
//   final _eventProductRepository = EventProductRepository();
//   final error = ''.obs;
//   final UserController userController = Get.find<UserController>();
//
//
//   final RxList<T> items = <T>[].obs;
//   final RxBool isLoading = false.obs;
//   int currentPage = 1;  // Start from 1 instead of 0
//   final int limit = 10;
//   bool hasMoreData = true;
//
//   Future<void> fetchItems({bool isLoadMore = false}) async {
//     if (!isLoadMore) {
//       currentPage = 1;
//       items.clear();
//       hasMoreData = true;
//     }
//
//     if (!hasMoreData || isLoading.value) return;
//
//     try {
//       isLoading.value = true;
//       final newItems = await repository.fetchItems(
//         page: currentPage,
//         limit: limit,
//       );
//
//       if (newItems.isEmpty || newItems.length < limit) {
//         hasMoreData = false;
//       }
//
//       if (isLoadMore) {
//         items.addAll(newItems);
//       } else {
//         items.value = newItems;  // Use .value to prevent unnecessary rebuilds
//       }
//
//       if (hasMoreData) currentPage++;
//     } catch (e) {
//       Loaders.warningSnackBar(title: 'Error', message: e.toString());
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//
//
//
//
//
//
//
//
//
//
//   @override
//   void onInit() {
//     super.onInit();
//     getProducts();
//   }
//
//   void getProducts() {
//     productController.getProducts();
//   }
//
//   // Check if a product is selected (in eventProducts)
//   bool isProductSelected(Product product) {
//     return eventProducts.any((eventProduct) => eventProduct.id == product.id);
//   }
//
//   void toggleProductSelection(Product product) {
//     if (isProductSelected(product)) {
//       eventProducts.remove(product);
//     } else {
//       eventProducts.add(product);
//     }
//   }
//
//
//   Future<void> add_product_to_event_or_package(Product product, String eventId,
//       {Function(bool, {String? errorMessage})? onComplete}) async {
//     try {
//       isLoading.value = true;
//       error.value = '';
//
//       final user = userController.user.value;
//       if (user == null) {
//         throw 'User not found';
//       }
//
//       final eventProductData = {
//         'user': user.id,
//         'product': product.id,
//         'event': eventId,
//         'name': product.name,
//       };
//
//       final success = await _eventProductRepository.addProductToEvent(eventProductData);
//
//       if (success) {
//         removeProductFromGrid(product);
//         if (onComplete != null) onComplete(true);
//       } else {
//         if (onComplete != null)
//           onComplete(false,
//               errorMessage: 'Failed to add ${product.name} to event');
//       }
//     } catch (e) {
//       error.value = e.toString();
//       if (onComplete != null) onComplete(false, errorMessage: e.toString());
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   Future<void> deleteEventProduct(String eventProductId) async {
//     if (eventProductId.isEmpty) return;
//     try {
//       isLoading.value = true;
//       error.value = '';
//
//       final success =
//       await _eventProductRepository.deleteEventProduct(eventProductId);
//
//       if (success) {
//         eventProducts
//             .removeWhere((eventProduct) => eventProduct.id == eventProductId);
//         Get.snackbar('Success', 'Product removed from event');
//       } else {
//         Get.snackbar('Error', 'Failed to remove product from event');
//       }
//     } catch (e) {
//       error.value = e.toString();
//       Get.snackbar('Error', e.toString());
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   Future<void> getEventProducts() async {
//     try {
//       isLoading.value = true;
//       error.value = '';
//
//       final result = await _eventProductRepository.getEventProducts();
//       if (result != null) {
//         eventProducts.value = result;
//       }
//     } catch (e) {
//       error.value = e.toString();
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   void removeProductFromEvent(Product product) {
//     eventProducts.remove(product);
//     productController.products.add(product);
//     Get.snackbar('Success', '${product.name} removed from event');
//   }
//
//   void removeProductFromGrid(Product product) {
//     productController.products.remove(product);
//     eventProducts.add(product);
//   }
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//   void reset() {
//     currentPage = 1;
//     items.clear();
//     hasMoreData = true;
//     isLoading.value = false;
//   }
// }



class GenericController<T> extends GetxController {

  final GenericRepository<T> repository;
  final bool isPackageScreen;

  RxList<EventProducts> eventProducts = <EventProducts>[].obs;
  RxList<PackageProducts> packageProducts = <PackageProducts>[].obs;



  GenericController(this.repository, {this.isPackageScreen = false});

  final ProductController productController = Get.put(ProductController());
 // final _eventProductRepository = EventProductRepository();
  final error = ''.obs;
  final UserController userController = Get.find<UserController>();


  final RxList<T> items = <T>[].obs;
  final RxBool isLoading = false.obs;
  int currentPage = 1;
  final int limit = 10;
  bool hasMoreData = true;

  void syncProducts() {
    if (items.isEmpty) return;

    if (isPackageScreen) {
      // Get the first item from items list
      Package package = (items.first as Package);
      var selectedProducts = package.packageProducts ?? [];

      // Update available products
      var availableProducts = productController.products.toList();
      availableProducts.removeWhere((product) =>
          selectedProducts.any((pp) => pp.product?.id == product.id));
      productController.productList.value = availableProducts;

      // Update package products
      packageProducts.value = selectedProducts;
    } else {
      // Get the first item from items list
      Event event = (items.first as Event);
      var selectedProducts = event.eventProducts ?? [];

      // Update available products
      var availableProducts = productController.products.toList();
      availableProducts.removeWhere((product) => selectedProducts.any((ep) => ep.product?.id == product.id));
      productController.productList.value = availableProducts;

      // Update event products
      eventProducts.value = selectedProducts;
    }
  }





  Future<void> fetchItems({bool isLoadMore = false}) async {
    if (!isLoadMore) {
      currentPage = 1;
      items.clear();
      hasMoreData = true;
    }

    if (!hasMoreData || isLoading.value) return;

    try {
      isLoading.value = true;
      final newItems = await repository.fetchItems(
        page: currentPage,
        limit: limit,
      );

      if (newItems.isEmpty || newItems.length < limit) {
        hasMoreData = false;
      }

      if (isLoadMore) {
        items.addAll(newItems);
      } else {
        items.value = newItems;
      }

      syncProducts();

      if (hasMoreData) currentPage++;
    } catch (e) {
      Loaders.warningSnackBar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }


  void reset() {
    currentPage = 1;
    items.clear();
    hasMoreData = true;
    isLoading.value = false;
  }
}
