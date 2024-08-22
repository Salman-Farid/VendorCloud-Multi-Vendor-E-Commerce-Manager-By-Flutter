import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/order_model.dart';


class OrderDetailsScreen extends StatelessWidget {
  final Order order;

  OrderDetailsScreen({required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOrderInfo(),
            SizedBox(height: 20),
            _buildProductList(),
            SizedBox(height: 20),
            _buildShippingInfo(),
            SizedBox(height: 20),
            _buildTotalSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderInfo() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Order #${order.id.substring(0, 8)}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Date: ${order.formattedDate}'),
            Text('Status: ${order.status.capitalize}'),
            Text('Payment: ${order.paymentType.capitalize}'),
          ],
        ),
      ),
    );
  }

  Widget _buildProductList() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Products', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            ...order.products.map((product) => Padding(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${product.quantity}x Product ${product.id.substring(0, 8)}'),
                  Text('${order.currency.toUpperCase()} ${(product.price * product.quantity).toStringAsFixed(2)}'),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildShippingInfo() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Shipping Information', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Name: ${order.shippingInfo.name}'),
            Text('Email: ${order.shippingInfo.email}'),
            Text('Phone: ${order.shippingInfo.phone}'),
            Text('Address: ${order.shippingInfo.address1}, ${order.shippingInfo.city}, ${order.shippingInfo.state}, ${order.shippingInfo.country}'),
            Text('Postcode: ${order.shippingInfo.postcode}'),
            Text('Delivery Method: ${order.shippingInfo.method}'),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalSection() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Subtotal'),
                Text('${order.currency.toUpperCase()} ${order.totalAmount.toStringAsFixed(2)}'),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Delivery Fee'),
                Text('${order.currency.toUpperCase()} ${order.shippingInfo.deliveryFee.toStringAsFixed(2)}'),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  '${order.currency.toUpperCase()} ${(order.totalAmount + order.shippingInfo.deliveryFee).toStringAsFixed(2)}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
