import 'package:intl/intl.dart';

class Order {
  final String id;
  final List<Product> products;
  final String status;
  final String currency;
  final String paymentType;
  final String userId;
  final ShippingInfo shippingInfo;
  final DateTime createdAt;

  Order({
    required this.id,
    required this.products,
    required this.status,
    required this.currency,
    required this.paymentType,
    required this.userId,
    required this.shippingInfo,
    required this.createdAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['_id'],
      products: (json['products'] as List).map((p) => Product.fromJson(p)).toList(),
      status: json['status'],
      currency: json['currency'],
      paymentType: json['paymentType'],
      userId: json['user'],
      shippingInfo: ShippingInfo.fromJson(json['shippingInfo']),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  double get totalAmount => products.fold(0, (sum, product) => sum + (product.price * product.quantity));
  String get formattedDate => DateFormat('MMM d, yyyy').format(createdAt);
}

class Product {
  final String id;
  final double price;
  final int quantity;

  Product({required this.id, required this.price, required this.quantity});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['product'],
      price: json['price'].toDouble(),
      quantity: json['quantity'],
    );
  }
}

class ShippingInfo {
  final String name;
  final String email;
  final String phone;
  final String method;
  final String address1;
  final String address2;
  final String city;
  final String state;
  final int postcode;
  final String country;
  final double deliveryFee;

  ShippingInfo({
    required this.name,
    required this.email,
    required this.phone,
    required this.method,
    required this.address1,
    required this.address2,
    required this.city,
    required this.state,
    required this.postcode,
    required this.country,
    required this.deliveryFee,
  });

  factory ShippingInfo.fromJson(Map<String, dynamic> json) {
    return ShippingInfo(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      method: json['method'],
      address1: json['address1'],
      address2: json['address2'],
      city: json['city'],
      state: json['state'],
      postcode: json['postcode'],
      country: json['country'],
      deliveryFee: json['deliveryFee'].toDouble(),
    );
  }
}
