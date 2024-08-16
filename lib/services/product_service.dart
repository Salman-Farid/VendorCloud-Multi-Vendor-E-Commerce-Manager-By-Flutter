import 'dart:convert';
import 'package:get/get.dart';
import 'package:karmalab_assignment/constants/network_constants.dart';
import 'package:karmalab_assignment/controllers/base_controller.dart';
import 'package:karmalab_assignment/services/base/auth_client.dart';
import 'package:karmalab_assignment/services/shared_pref_service.dart';
import '../controllers/product_controller.dart';
import '../models/product_model.dart';

class ProductService extends BaseController {
  final SharedPrefService _prefService = SharedPrefService();
  final BaseClient _baseClient = BaseClient();
  late  final Product? product;





  Future<Product?> getProducts() async {
    try {
      final sessionId = await _prefService.getSessionId();
      var response = await _baseClient.get(
        NetworkConstants.getProducts,
        header: {'Cookie': "connect.sid=$sessionId"},
      ).catchError(handleError);

      if (response != null) {
        //List<dynamic> data = response;
        return Product.fromJson(response);
      }
    } catch (e) {
      print('Error fetching products: $e');
    }
    return null;
  }

  Future<Product?> getProductById(String id) async {
    try {
      final sessionId = await _prefService.getSessionId();
      var response = await _baseClient.get(
        NetworkConstants.getProductById(id),
        header: {'Cookie': "connect.sid=$sessionId"},
      ).catchError(handleError);

      if (response != null) {
        //final productResponse = jsonDecode(response);
        //List<dynamic> data = productResponse['data'];
        return Product.fromJson(response);
      }
    } catch (e) {
      print('Error fetching product by ID: $e');
    }
    return null;
  }









  // // Fetch all products
  // Future<List<Product>?> getProducts() async {
  //   try {
  //     final sessionId = await _prefService.getSessionId();
  //     var response = await _baseClient.get(
  //       NetworkConstants.getProducts,
  //       header: {'Cookie': "connect.sid=$sessionId"},
  //     ).catchError(handleError);
  //
  //     if (response != null) {
  //       List<dynamic> data = response;
  //       return data.map((json) => Product.fromJson(json)).toList();
  //     }
  //   } catch (e) {
  //     print('Error fetching products: $e');
  //   }
  //   return null;
  // }
  //
  // // Fetch product by ID
  // Future<List<Product>?> getProductById(String id) async {
  //   try {
  //     final sessionId = await _prefService.getSessionId();
  //     var response = await _baseClient.get(
  //       NetworkConstants.getProductById(id),
  //       header: {'Cookie': "connect.sid=$sessionId"},
  //     ).catchError(handleError);
  //
  //     if (response != null) {
  //       final productResponse = jsonDecode(response); // Assuming response is a JSON string
  //       List<Product> products = [];
  //       for (var item in productResponse['data']) {
  //         products.add(Product.fromJson(item));
  //       }
  //       return products;
  //     }
  //   } catch (e) {
  //     print('Error fetching products: $e');
  //   }
  //   return null;
  // }
  // Create a new product
  Future<Product?> createProduct(dynamic object) async {
    try {
      final sessionId = await _prefService.getSessionId();
      var response = await _baseClient.post(
        NetworkConstants.createProduct,
        object,
        header: {
          'Cookie': "connect.sid=$sessionId",
          'Content-Type': "application/json",
        },
      ).catchError(handleError);

      if (response != null) {
        var data = response['data'];
        return Product.fromJson((data));
      }
    } catch (e) {
      print('Error creating product: $e');
    }
    return null;
  }

  // Update product by ID
  Future<bool> updateProductById(String id, dynamic object) async {
    try {
      final sessionId = await _prefService.getSessionId();
      var response = await _baseClient.patch(
        NetworkConstants.updateProductById(id),
        object,
        header: {
          'Cookie': "connect.sid=$sessionId",
          'Content-Type': "application/json",
        },
      ).catchError(handleError);

      if (response != null) {
        return true;
      }
    } catch (e) {
      print('Error updating product by ID: $e');
    }
    return false;
  }

  // Delete product by ID
  Future<bool> deleteProductById(String id) async {
    try {
      final sessionId = await _prefService.getSessionId();
      var response = await _baseClient.delete(
        NetworkConstants.deleteProductById(id),
        header: {'Cookie': "connect.sid=$sessionId"},
      ).catchError(handleError);

      if (response != null) {
        return true;
      }
    } catch (e) {
      print('Error deleting product by ID: $e');
    }
    return false;
  }

  // Toggle like on a product
  Future<bool> toggleLikeProduct(String productId) async {
    try {
      final sessionId = await _prefService.getSessionId();
      var response = await _baseClient.post(
        NetworkConstants.toggleLikeProduct(productId),
        null,
        header: {'Cookie': "connect.sid=$sessionId"},
      ).catchError(handleError);

      if (response != null) {
        return true;
      }
    } catch (e) {
      print('Error toggling like on product: $e');
    }
    return false;
  }

  // Get reviews by product ID
  Future<List<Reviews>?> getReviewsByProductId(String productId) async {
    try {
      final sessionId = await _prefService.getSessionId();
      var response = await _baseClient.get(
        NetworkConstants.getReviewsByProductId(productId),
        header: {'Cookie': "connect.sid=$sessionId"},
      ).catchError(handleError);

      if (response != null) {
        List<dynamic> data = json.decode(response);
        return data.map((json) => Reviews.fromJson(json)).toList();
      }
    } catch (e) {
      print('Error fetching reviews by product ID: $e');
    }
    return null;
  }

  // Create a new review
  Future<Reviews?> createReview(dynamic object) async {
    try {
      final sessionId = await _prefService.getSessionId();
      var response = await _baseClient.post(
        NetworkConstants.createReview,
        object,
        header: {
          'Cookie': "connect.sid=$sessionId",
          'Content-Type': "application/json",
        },
      ).catchError(handleError);

      if (response != null && response.containsKey('data')) {
        var data = response['data'];
        return Reviews.fromJson((data));
      }
    } catch (e) {
      print('Error creating review: $e');
    }
    return null;
  }

  // Delete review by ID
  Future<bool> deleteReviewById(String reviewId) async {
    try {
      final sessionId = await _prefService.getSessionId();
      var response = await _baseClient.delete(
        NetworkConstants.deleteReviewById(reviewId),
        header: {'Cookie': "connect.sid=$sessionId"},
      ).catchError(handleError);

      if (response != null) {
        return true;
      }
    } catch (e) {
      print('Error deleting review by ID: $e');
    }
    return false;
  }
}