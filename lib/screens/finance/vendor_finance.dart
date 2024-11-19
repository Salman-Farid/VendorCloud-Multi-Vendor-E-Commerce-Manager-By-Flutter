import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:karmalab_assignment/constants/color_constants.dart';
import 'package:karmalab_assignment/models/order_model.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/order_controller.dart';

class FinanceScreen extends StatelessWidget {
  static const routeName = "/finance";
  final OrderController _orderController = OrderController();
  final scrollController = ScrollController();

  FinanceScreen({super.key}) {
    _orderController.fetchUserOrders();

    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        _orderController.fetchUserOrders(isLoadMore: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Finance Dashboard',
          style: GoogleFonts.poppins(
            color: AppColors.textPrimary,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Theme.of(context).primaryColor),
            onPressed: () => _orderController.fetchUserOrders(),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.grey.shade50],
          ),
        ),
        child: Obx(() {
          if (_orderController.isLoading.value && _orderController.orders.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final orders = _orderController.orders;

          if (orders.isEmpty && !_orderController.isLoading.value) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.inbox_outlined, size: 80, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(
                    'No Orders Available',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSummaryCards(orders),
                const SizedBox(height: 12),
                _buildOrdersTable(orders, context),
                if (_orderController.isLoading.value)
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }


  Widget _buildSummaryCards(List<OrderModel> orders) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 4,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 1.5,
      children: [
        _buildSummaryCard(
          'Total Orders',
          orders.length.toString(),
          Icons.shopping_cart,
          Colors.blue,
        ),
        _buildSummaryCard(
          'Total Revenue',
          '\$${_calculateTotalRevenue(orders)}',
          Icons.attach_money,
          Colors.green,
        ),
        _buildSummaryCard(
          'Pending Orders',
          _getPendingOrders(orders).toString(),
          Icons.pending_actions,
          Colors.orange,
        ),
        _buildSummaryCard(
          'Total Profit',
          '\$${_calculateTotalProfit(orders)}',
          Icons.trending_up,
          Colors.purple,
        ),
      ],
    );
  }

  Widget _buildSummaryCard(
      String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 3,
      shadowColor: color.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.8),
              color.withOpacity(0.6),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 20).animate().scale(duration: 300.ms).then().shimmer(),
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 8,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 6,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
          ],
        ),
      ),
    ).animate().scale(duration: 300.ms).then().fadeIn(duration: 300.ms);
  }
  Widget _buildOrdersTable(List<OrderModel> orders, BuildContext context) {
    //final screenWidth = MediaQuery.of(context).size.width;
   // final minWidth = screenWidth < 1200 ? 1200.0 : screenWidth;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
         // width: minWidth,
          child: DataTable(
            horizontalMargin: 24,
            columnSpacing: 30,
            headingRowHeight: 60,
            dataRowHeight: 65,
            headingRowColor: WidgetStateProperty.all(Colors.grey.shade50),
            columns: [
              DataColumn(
                label: Container(
                  width: 60, // Reduced width for No column
                  child: Text(
                    'No',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ),
              ),
              //_buildDataColumn('No', flex: 1),
              _buildDataColumn('Order Date', flex: 2),
              _buildDataColumn('Order Cost', flex: 2),
              _buildDataColumn('VAT', flex: 1),
              _buildDataColumn('Commission', flex: 2),
              _buildDataColumn('Transaction Fee', flex: 2),
              _buildDataColumn('Shipping Cost', flex: 2),
              _buildDataColumn('Profit', flex: 2),
              _buildDataColumn('Status', flex: 2),
              _buildDataColumn('Action', flex: 2),
            ],
            rows: List<DataRow>.generate(
              orders.length,
                  (index) => _buildDataRow(orders[index], index),
            ),
          ),
        ),
      ),
    );
  }

  DataColumn _buildDataColumn(String label, {int flex = 1}) {
    return DataColumn(
      label: Container(
        constraints: const BoxConstraints(minWidth: 80),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 15,
            color: Colors.grey.shade800,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }


  DataRow _buildDataRow(OrderModel order, int index) {
    return DataRow(
      color: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
          if (index.isEven) return Colors.grey.shade50;
          return null;
        },
      ),
      cells: [
        _buildDataCell((index + 1).toString(), minWidth: 40),
        _buildDataCell(order.formattedOrderDate),
        _buildDataCell('\$${order.price!.toStringAsFixed(2)}'),
        _buildDataCell('\$${order.vat}'),
        _buildDataCell('\$${order.commission}'),
        _buildDataCell('\$${order.transactionCost}'),
        _buildDataCell('\$${order.shippingCharge}'),
        DataCell(_buildProfitCell(formatProfit(order.profit))),
        DataCell(_buildStatusCell(order.status ?? '')),
        DataCell(_buildActionButton(
          status: order.vendorPaid ?? '',
          onPressed: () {
            // Handle action
          },
        )),
      ],
    );
  }

  String formatProfit(String profit) {
    // Convert profit from String to double, then format to 2 decimal places
    double profitValue = double.tryParse(profit) ?? 0.0;
    return profitValue.toStringAsFixed(2);
  }

  DataCell _buildDataCell(String text, {double minWidth = 100}) {
    return DataCell(
      Container(
        constraints: BoxConstraints(minWidth: minWidth),
        child: Text(
          text,
          style: GoogleFonts.poppins(fontSize: 14),
        ),
      ),
    );
  }
  Widget _buildProfitCell(String profit) {
    return Text(
      '\$$profit',
      style: GoogleFonts.poppins(
        color: double.parse(profit) >= 0 ? Colors.green : Colors.red,
        fontWeight: FontWeight.w600,
        fontSize: 14,
      ),
    );
  }

  Widget _buildStatusCell(String status) {
    final statusConfig = {
      'pending': (Colors.orange),
      'shipped': (Colors.deepPurpleAccent),
      'completed': (Colors.green),
      'cancelled': (Colors.red),
    };
    final (textColor) =statusConfig[status.toLowerCase()] ?? (Colors.grey);
    return Text(status, style: GoogleFonts.poppins(color: textColor, fontWeight: FontWeight.w600, fontSize: 14,),);}
  Widget _buildActionButton({
    required String status,
    required VoidCallback onPressed,
  }) {
    final isPaid = status.toLowerCase() == 'paid';
    return ElevatedButton(

      onPressed: onPressed,
      style: ElevatedButton.styleFrom(

        backgroundColor: isPaid ? Colors.green : Colors.blue.withOpacity(0.1),
        foregroundColor: isPaid ? Colors.white : Colors.blue,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        isPaid ? '      Paid     ':'Not-Paid',
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  double _calculateTotalRevenue(List<OrderModel> orders) {
    final totalProfit = _calculateTotalProfit(orders);
    final totalPrice = orders.fold(0.0, (sum, order) => sum + (order.price ?? 0));
    return totalPrice - totalProfit;
  }

  double _calculateTotalProfit(List<OrderModel> orders) {
    return orders.fold(0.0, (sum, order) => sum + double.parse(order.profit));
  }

  int _getPendingOrders(List<OrderModel> orders)
  {
    return orders.where((order) => order.status?.toLowerCase() == 'pending').length;
  }
}