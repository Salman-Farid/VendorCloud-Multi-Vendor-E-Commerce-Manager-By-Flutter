import 'dart:convert';
import 'package:get/get.dart';
import 'package:karmalab_assignment/services/shared_pref_service.dart';
import '../../../services/base/auth_client.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../constants/network_constants.dart';
import '../models/order_model.dart';

class OrderRepository extends GetxController {
  static OrderRepository get instance => Get.find();

  final SharedPrefService _prefService = SharedPrefService();
  final BaseClient _baseClient = BaseClient();

  Future<List<OrderModel>> fetchUserOrders(String Id, {int page = 1, int limit = 10}) async {
    try {
      print('the id is........................................$Id');
      final sessionId = await _prefService.getSessionId();
      final response = await _baseClient.get(
        NetworkConstants.getUserOrders(Id, page: page, limit: limit),
        header: {'Cookie': "connect.sid=$sessionId"},
      ).catchError((e) => throw CustomApiException('Failed to load orders'));

      if (response != null && response.containsKey('data')) {
        return (response['data'] as List).map((order) => OrderModel.fromJson(order)).toList();
      }
    } catch (e) {
      throw 'Something went wrong while fetching Order Information. Try again later.';
    }
    return [];
  }

  Future<List<OrderModel>> fetchVendorOrders(String Id, {int page = 1, int limit = 10}) async {
    try {
      final sessionId = await _prefService.getSessionId();
      final response = await _baseClient.get(
        NetworkConstants.getUserOrders(Id, page: page, limit: limit),
        header: {'Cookie': "connect.sid=$sessionId"},
      ).catchError((e) => throw CustomApiException('Failed to load orders'));

      if (response['body'] != null && response['body'].containsKey('data')) {
        return (response['body']['data'] as List).map((order) => OrderModel.fromJson(order)).toList();
      }
    } catch (e) {
      throw 'Something went wrong while fetching Order Information. Try again later.';
    }
    return [];
  }




  Future<bool> updateOrderStatus(String orderId, String newStatus) async {
    try {
      print('the id is .............................$orderId');
      final sessionId = await _prefService.getSessionId();
      final response = await _baseClient.patch(
        NetworkConstants.updateOrderStatus(orderId),
        {'status': newStatus},
        header: {'Cookie': "connect.sid=$sessionId"},
      ).catchError((e) => throw CustomApiException('Failed to update order status'));
      return response != null && response['success'] == true;
    } catch (e) {
      throw 'Failed to update order status. Please try again.';
    }
  }






}
