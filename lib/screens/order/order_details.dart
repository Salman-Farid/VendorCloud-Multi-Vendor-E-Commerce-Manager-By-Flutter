import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:karmalab_assignment/models/order_model.dart';
import 'package:karmalab_assignment/screens/order/widgets/need_help.dart';
import 'package:karmalab_assignment/utils/constants/colors.dart';
import 'package:karmalab_assignment/utils/constants/sizes.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../common/widgets/custom_shapes/containers/rounded_container.dart';

// class OrderDetailsScreen extends StatelessWidget {
//   final OrderModel order;
//
//   const OrderDetailsScreen({Key? key, required this.order}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final String shortOrderId = order.sId?.substring(order.sId!.length - 6) ?? '';
//
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Order Details',
//               style: Get.textTheme.titleMedium?.copyWith(
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Text(
//               '#$shortOrderId',
//               style: Get.textTheme.bodySmall?.copyWith(color: Colors.grey),
//             ),
//           ],
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             const SizedBox(height: Sizes.spaceBtwSections),
//             _buildOrderTimeline(),
//             Padding(
//               padding: const EdgeInsets.all(Sizes.defaultSpace),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildOrderStatusCard(),
//                   const SizedBox(height: Sizes.spaceBtwSections),
//                   _buildProductDetails(),
//                   const SizedBox(height: Sizes.spaceBtwSections),
//                   _buildShippingDetails(),
//                   const SizedBox(height: Sizes.spaceBtwSections),
//                   _buildPaymentSummary(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: _buildBottomBar(),
//     );
//   }
//
//   Widget _buildOrderTimeline() {
//     return RoundedContainer(
//       padding: const EdgeInsets.symmetric(vertical: Sizes.lg, horizontal: Sizes.lg),
//       margin: const EdgeInsets.symmetric(horizontal: Sizes.defaultSpace),
//       backgroundColor: Colors.white,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           TimelineTile(
//             isFirst: true,
//             endChild: _buildTimelineChild(
//               'Order Placed',
//               true,
//               'Your order has been placed successfully',
//               order.formattedOrderDate ?? '',
//               Iconsax.shopping_cart,
//             ),
//             beforeLineStyle: const LineStyle(
//               color: Colors.green,
//               thickness: 3,
//             ),
//             indicatorStyle: IndicatorStyle(
//               width: 25,
//               height: 25,
//               indicator: Container(
//                 decoration: const BoxDecoration(
//                   color: Colors.green,
//                   shape: BoxShape.circle,
//                 ),
//                 child: const Icon(
//                   Iconsax.shopping_cart,
//                   color: Colors.white,
//                   size: 15,
//                 ),
//               ),
//             ),
//           ),
//           TimelineTile(
//             endChild: _buildTimelineChild(
//               'Processing',
//               order.status == 'pending',
//               'Your order is being processed',
//               'Estimated processing time: 1-2 days',
//               Iconsax.box,
//             ),
//             beforeLineStyle: LineStyle(
//               color: order.status == 'pending' ? Colors.green : Colors.grey.shade300,
//               thickness: 3,
//             ),
//             indicatorStyle: IndicatorStyle(
//               width: 25,
//               height: 25,
//               indicator: Container(
//                 decoration: BoxDecoration(
//                   color: order.status == 'pending' ? Colors.green : Colors.grey.shade300,
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(
//                   Iconsax.box,
//                   color: order.status == 'pending' ? Colors.white : Colors.grey.shade400,
//                   size: 15,
//                 ),
//               ),
//             ),
//           ),
//           TimelineTile(
//             isLast: true,
//             endChild: _buildTimelineChild(
//               'Completed',
//               order.status == 'COMPLETED',
//               'Your order has been delivered',
//               order.status == 'COMPLETED' ? 'Delivered successfully' : 'Pending delivery',
//               Iconsax.verify,
//             ),
//             beforeLineStyle: LineStyle(
//               color: order.status == 'COMPLETED' ? Colors.green : Colors.grey.shade300,
//               thickness: 3,
//             ),
//             indicatorStyle: IndicatorStyle(
//               width: 25,
//               height: 25,
//               indicator: Container(
//                 decoration: BoxDecoration(
//                   color: order.status == 'COMPLETED' ? Colors.green : Colors.grey.shade300,
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(
//                   Iconsax.verify,
//                   color: order.status == 'COMPLETED' ? Colors.white : Colors.grey.shade400,
//                   size: 15,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTimelineChild(
//       String title,
//       bool isActive,
//       String description,
//       String date,
//       IconData icon,
//       ) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: Sizes.lg, vertical: Sizes.md),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: Get.textTheme.titleSmall?.copyWith(
//               color: isActive ? AppColors.primary : Colors.grey,
//               fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
//             ),
//           ),
//           const SizedBox(height: Sizes.xs),
//           Text(
//             description,
//             style: Get.textTheme.bodySmall?.copyWith(
//               color: Colors.grey,
//             ),
//           ),
//           const SizedBox(height: Sizes.xs),
//           Text(
//             date,
//             style: Get.textTheme.bodySmall?.copyWith(
//               color: Colors.grey.shade600,
//               fontSize: 11,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildOrderStatusCard() {
//     return RoundedContainer(
//       padding: const EdgeInsets.all(Sizes.md),
//       backgroundColor: Colors.white,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Current Status',
//                     style: Get.textTheme.titleMedium?.copyWith(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: Sizes.xs),
//                   Text(
//                     order.orderStatusText ?? 'Processing',
//                     style: Get.textTheme.bodyLarge?.copyWith(
//                       color: _getStatusColor(),
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//               Icon(
//                 _getStatusIcon(),
//                 color: _getStatusColor(),
//                 size: Sizes.iconLg,
//               ),
//             ],
//           ),
//           const Divider(height: Sizes.lg),
//           Text(
//             'Last Updated: ${order.formattedOrderDate ?? 'Not Available'}',
//             style: Get.textTheme.bodySmall?.copyWith(color: Colors.grey),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildProductDetails() {
//     // Safely handle null variants list and find matching variant
//     final variants = order.product?.variants;
//     final selectedVariant = variants != null
//         ? variants.firstWhereOrNull((variant) => variant.id == order.variantId)
//         : null;
//
//     return RoundedContainer(
//       padding: const EdgeInsets.all(Sizes.md),
//       backgroundColor: Colors.white,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Product Details',
//             style: Get.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: Sizes.md),
//           Row(
//             children: [
//               _buildProductImage(selectedVariant),
//               const SizedBox(width: Sizes.md),
//               Expanded(
//                 child: _buildProductInfo(selectedVariant),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildProductImage(dynamic selectedVariant) {
//     final hasValidImage = selectedVariant?.image != null &&
//         selectedVariant!.image.toString().isNotEmpty;
//
//     if (hasValidImage) {
//       return ClipRRect(
//         borderRadius: BorderRadius.circular(Sizes.sm),
//         child: Image.network(
//           selectedVariant.image,
//           width: 80,
//           height: 80,
//           fit: BoxFit.cover,
//           errorBuilder: (context, error, stackTrace) => _buildPlaceholderImage(),
//         ),
//       );
//     }
//
//     return _buildPlaceholderImage();
//   }
//
//   Widget _buildPlaceholderImage() {
//     return Container(
//       width: 80,
//       height: 80,
//       decoration: BoxDecoration(
//         color: Colors.grey.shade200,
//         borderRadius: BorderRadius.circular(Sizes.sm),
//       ),
//       child: const Icon(
//         Iconsax.image,
//         color: Colors.grey,
//         size: 30,
//       ),
//     );
//   }
//
//   Widget _buildProductInfo(dynamic selectedVariant) {
//     final productName = order.product?.name;
//     final variantName = selectedVariant?.name;
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           productName ?? 'Product Not Found',
//           style: Get.textTheme.titleSmall,
//           maxLines: 2,
//           overflow: TextOverflow.ellipsis,
//         ),
//         const SizedBox(height: Sizes.xs),
//         if (variantName != null) ...[
//           Text(
//             'Variant: $variantName',
//             style: Get.textTheme.bodyMedium?.copyWith(color: Colors.grey),
//           ),
//           const SizedBox(height: Sizes.xs),
//         ],
//         Text(
//           'Quantity: ${order.quantity ?? 0}',
//           style: Get.textTheme.bodyMedium?.copyWith(color: Colors.grey),
//         ),
//         const SizedBox(height: Sizes.xs),
//         Text(
//           '\$${order.price ?? 0}',
//           style: Get.textTheme.titleMedium?.copyWith(
//             color: AppColors.primary,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildShippingDetails() {
//     return RoundedContainer(
//       padding: const EdgeInsets.all(Sizes.md),
//       backgroundColor: Colors.white,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Shipping Details',
//             style: Get.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: Sizes.md),
//           _buildInfoRow(Iconsax.user, 'Name', order.shippingInfo?.name ?? 'Not provided'),
//           _buildInfoRow(
//             Iconsax.location,
//             'Address',
//             _formatAddress(),
//           ),
//           _buildInfoRow(Iconsax.call, 'Phone', order.shippingInfo?.phone ?? 'Not provided'),
//           _buildInfoRow(Iconsax.message, 'Email', order.shippingInfo?.email ?? 'Not provided'),
//         ],
//       ),
//     );
//   }
//
//   String _formatAddress() {
//     final info = order.shippingInfo;
//     final components = [
//       info?.address1,
//       info?.city,
//       info?.state,
//       info?.country,
//     ].where((component) => component != null && component.isNotEmpty);
//
//     return components.isEmpty ? 'Address not provided' : components.join(', ');
//   }
//
//   Widget _buildInfoRow(IconData icon, String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: Sizes.sm),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(icon, size: 20, color: Colors.grey),
//           const SizedBox(width: Sizes.sm),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   label,
//                   style: Get.textTheme.bodySmall?.copyWith(color: Colors.grey),
//                 ),
//                 Text(
//                   value,
//                   style: Get.textTheme.bodyMedium,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildPaymentSummary() {
//     // Convert each component to double, defaulting to 0.0 if null or invalid
//     final shippingCharge = double.tryParse(order.shippingCharge ?? '0') ?? 0.0;
//     final commission = double.tryParse(order.commission ?? '0') ?? 0.0;
//     final vat = double.tryParse(order.vat ?? '0') ?? 0.0;
//     final transactionCost = double.tryParse(order.transactionCost ?? '0') ?? 0.0;
//     final price = order.price ?? 0.0;
//
//     // Calculate the total
//     final total = price + shippingCharge + commission + vat + transactionCost;
//
//     return RoundedContainer(
//       padding: const EdgeInsets.all(Sizes.md),
//       backgroundColor: Colors.white,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Payment Summary',
//             style: Get.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: Sizes.md),
//           _buildPriceRow('Subtotal', price),
//           _buildPriceRow('Shipping Fee', shippingCharge),
//           _buildPriceRow('Commission', commission),
//           _buildPriceRow('VAT', vat),
//           _buildPriceRow('Transaction Cost', transactionCost),
//           const Padding(
//             padding: EdgeInsets.symmetric(vertical: Sizes.sm),
//             child: Divider(),
//           ),
//           _buildPriceRow(
//             'Total',
//             total,
//             textStyle: Get.textTheme.titleMedium?.copyWith(
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildPriceRow(String label, dynamic amount, {TextStyle? textStyle}) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: Sizes.xs),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(label, style: textStyle ?? Get.textTheme.bodyMedium),
//           Text(
//             '\$$amount',
//             style: textStyle ?? Get.textTheme.bodyMedium,
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildBottomBar() {
//     return Container(
//       padding: const EdgeInsets.all(Sizes.defaultSpace),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             spreadRadius: 1,
//             blurRadius: 10,
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: TextButton.icon(
//               onPressed: () {
//                 Get.to(() => const OrderHelpScreen());
//
//               },
//               icon: const Icon(Iconsax.message_question),
//               label: const Text('Need Help?'),
//               style: TextButton.styleFrom(
//                 foregroundColor: Colors.grey,
//               ),
//             ),
//           ),
//           const SizedBox(width: Sizes.sm),
//         ],
//       ),
//     );
//   }
//
//   IconData _getStatusIcon() {
//     switch (order.status) {
//       case 'COMPLETED':
//         return Iconsax.tick_circle5;
//       case 'CANCELLED':
//         return Iconsax.close_circle5;
//       default:
//         return Iconsax.timer;
//     }
//   }
//
//   Color _getStatusColor() {
//     switch (order.status) {
//       case 'COMPLETED':
//         return Colors.green;
//       case 'CANCELLED':
//         return Colors.red;
//       default:
//         return Colors.orange;
//     }
//   }
// }

class OrderDetailsScreen extends StatelessWidget {
  final OrderModel order;

  const OrderDetailsScreen({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String shortOrderId =
        order.sId?.substring(order.sId!.length - 6) ?? '';

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Details',
              style: Get.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '#$shortOrderId',
              style: Get.textTheme.bodySmall?.copyWith(color: Colors.grey),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: Sizes.spaceBtwSections),
            _buildOrderTimeline(),
            Padding(
              padding: const EdgeInsets.all(Sizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildOrderStatusCard(),
                  const SizedBox(height: Sizes.spaceBtwSections),
                  _buildProductDetails(),
                  const SizedBox(height: Sizes.spaceBtwSections),
                  _buildShippingDetails(),
                  const SizedBox(height: Sizes.spaceBtwSections),
                  _buildPaymentSummary(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildOrderTimeline() {
    return RoundedContainer(
      padding:
          const EdgeInsets.symmetric(vertical: Sizes.lg, horizontal: Sizes.lg),
      margin: const EdgeInsets.symmetric(horizontal: Sizes.defaultSpace),
      backgroundColor: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TimelineTile(
            isFirst: true,
            endChild: _buildTimelineChild(
              'Order Placed',
              true,
              'Your order has been placed successfully',
              order.formattedOrderDate ?? '',
              Iconsax.shopping_cart,
            ),
            beforeLineStyle: const LineStyle(
              color: Colors.green,
              thickness: 3,
            ),
            indicatorStyle: IndicatorStyle(
              width: 25,
              height: 25,
              indicator: Container(
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Iconsax.shopping_cart,
                  color: Colors.white,
                  size: 15,
                ),
              ),
            ),
          ),
          TimelineTile(
            endChild: _buildTimelineChild(
              'Processing',
              order.status == 'pending',
              'Your order is being processed',
              'Estimated processing time: 1-2 days',
              Iconsax.box,
            ),
            beforeLineStyle: LineStyle(
              color: order.status == 'pending'
                  ? Colors.green
                  : Colors.grey.shade300,
              thickness: 3,
            ),
            indicatorStyle: IndicatorStyle(
              width: 25,
              height: 25,
              indicator: Container(
                decoration: BoxDecoration(
                  color: order.status == 'pending'
                      ? Colors.green
                      : Colors.grey.shade300,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Iconsax.box,
                  color: order.status == 'pending'
                      ? Colors.white
                      : Colors.grey.shade400,
                  size: 15,
                ),
              ),
            ),
          ),
          TimelineTile(
            isLast: true,
            endChild: _buildTimelineChild(
              'Completed',
              order.status == 'COMPLETED',
              'Your order has been delivered',
              order.status == 'COMPLETED'
                  ? 'Delivered successfully'
                  : 'Pending delivery',
              Iconsax.verify,
            ),
            beforeLineStyle: LineStyle(
              color: order.status == 'COMPLETED'
                  ? Colors.green
                  : Colors.grey.shade300,
              thickness: 3,
            ),
            indicatorStyle: IndicatorStyle(
              width: 25,
              height: 25,
              indicator: Container(
                decoration: BoxDecoration(
                  color: order.status == 'COMPLETED'
                      ? Colors.green
                      : Colors.grey.shade300,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Iconsax.verify,
                  color: order.status == 'COMPLETED'
                      ? Colors.white
                      : Colors.grey.shade400,
                  size: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineChild(String title, bool isActive, String description,
      String date, IconData icon) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: Sizes.lg, vertical: Sizes.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Get.textTheme.titleSmall?.copyWith(
              color: isActive ? AppColors.primary : Colors.grey,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          const SizedBox(height: Sizes.xs),
          Text(
            description,
            style: Get.textTheme.bodySmall?.copyWith(
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: Sizes.xs),
          Text(
            date,
            style: Get.textTheme.bodySmall?.copyWith(
              color: Colors.grey.shade600,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderStatusCard() {
    return RoundedContainer(
      padding: const EdgeInsets.all(Sizes.md),
      backgroundColor: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Current Status',
                    style: Get.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: Sizes.xs),
                  Text(
                    order.orderStatusText,
                    style: Get.textTheme.bodyLarge?.copyWith(
                      color: _getStatusColor(),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Icon(
                _getStatusIcon(),
                color: _getStatusColor(),
                size: Sizes.iconLg,
              ),
            ],
          ),
          const Divider(height: Sizes.lg),
          Text(
            'Last Updated: ${order.formattedOrderDate}',
            style: Get.textTheme.bodySmall?.copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildProductDetails() {
    final selectedVariant = order.product?.variants.firstWhere((variant) => variant.id == order.variantId);


    return RoundedContainer(
      padding: const EdgeInsets.all(Sizes.md),
      backgroundColor: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Product Details',
            style: Get.textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: Sizes.md),
          Row(
            children: [
              selectedVariant?.image != null &&
                      selectedVariant!.image.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(Sizes.sm),
                      child: Image.network(
                        selectedVariant.image,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(Sizes.sm),
                      ),
                      child: const Icon(
                        Iconsax.image,
                        color: Colors.grey,
                        size: 30,
                      ),
                    ),
              const SizedBox(width: Sizes.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.product?.name ?? 'Product Name',
                      style: Get.textTheme.titleSmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: Sizes.xs),
                    Text(
                      'Quantity: ${order.quantity}',
                      style: Get.textTheme.bodyMedium
                          ?.copyWith(color: Colors.grey),
                    ),
                    const SizedBox(height: Sizes.xs),
                    Text(
                      '\$${order.price}',
                      style: Get.textTheme.titleMedium?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildShippingDetails() {
    return RoundedContainer(
      padding: const EdgeInsets.all(Sizes.md),
      backgroundColor: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Shipping Details',
            style: Get.textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: Sizes.md),
          _buildInfoRow(Iconsax.user, 'Name', order.shippingInfo?.name ?? ''),
          _buildInfoRow(
            Iconsax.location,
            'Address',
            '${order.shippingInfo?.address1 ?? ''}, ${order.shippingInfo?.city ?? ''}, ${order.shippingInfo?.state ?? ''}, ${order.shippingInfo?.country ?? ''}',
          ),
          _buildInfoRow(Iconsax.call, 'Phone', order.shippingInfo?.phone ?? ''),
          _buildInfoRow(
              Iconsax.message, 'Email', order.shippingInfo?.email ?? ''),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Sizes.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.grey),
          const SizedBox(width: Sizes.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Get.textTheme.bodySmall?.copyWith(color: Colors.grey),
                ),
                Text(
                  value,
                  style: Get.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentSummary() {
// Convert each component to double, defaulting to 0.0 if null or invalid
    final shippingCharge = double.tryParse(order.shippingCharge ?? '0') ?? 0.0;
    final commission = double.tryParse(order.commission ?? '0') ?? 0.0;
    final vat = double.tryParse(order.vat ?? '0') ?? 0.0;
    final transactionCost =
        double.tryParse(order.transactionCost ?? '0') ?? 0.0;

// Calculate the total
    final total = (order.price ?? 0) +
        shippingCharge +
        commission +
        vat +
        transactionCost;

    return RoundedContainer(
      padding: const EdgeInsets.all(Sizes.md),
      backgroundColor: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Summary',
            style: Get.textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: Sizes.md),
          _buildPriceRow('Subtotal', order.price ?? 0),
          _buildPriceRow('Shipping Fee', shippingCharge ?? ''),
          _buildPriceRow('Commision', commission ?? ''),
          _buildPriceRow('Vat', vat ?? ''),
          _buildPriceRow('Transaction Cost', transactionCost ?? ''),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: Sizes.sm),
            child: Divider(),
          ),
          _buildPriceRow(
            'Total',
            total,
            textStyle: Get.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, dynamic amount, {TextStyle? textStyle}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Sizes.xs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: textStyle ?? Get.textTheme.bodyMedium),
          Text(
            '\$$amount',
            style: textStyle ?? Get.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(Sizes.defaultSpace),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextButton.icon(
              onPressed: () {
                Get.to(() => const OrderHelpScreen());
              },
              icon: const Icon(Iconsax.message_question),
              label: const Text('Need Help?'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.grey,
              ),
            ),
          ),
          const SizedBox(width: Sizes.sm),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                // Get.off(() => ProductDetailScreen(product: order.product));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
              child: const Text('Reorder'),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getStatusIcon() {
    switch (order.status) {
      case 'COMPLETED':
        return Iconsax.tick_circle5;
      case 'CANCELLED':
        return Iconsax.close_circle5;
      default:
        return Iconsax.timer;
    }
  }

  Color _getStatusColor() {
    switch (order.status) {
      case 'COMPLETED':
        return Colors.green;
      case 'CANCELLED':
        return Colors.red;
      default:
        return Colors.orange;
    }
  }
}
