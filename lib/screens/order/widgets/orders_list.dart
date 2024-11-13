import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:karmalab_assignment/controllers/order_controller.dart';
import 'package:karmalab_assignment/screens/mainScreen/mainscreen.dart';
import 'package:karmalab_assignment/utils/constants/colors.dart';
import 'package:karmalab_assignment/utils/constants/image_strings.dart';
import 'package:karmalab_assignment/utils/constants/sizes.dart';
import '../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../common/widgets/loaders/animation_loader.dart';
import '../../../utils/helpers/cloud_helper_functions.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../order_details.dart';

class OrdersListItems extends StatelessWidget {
  static const routeName = "/order_list";

  const OrdersListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    final dark = HelperFunctions.isDarkMode(context);
    final scrollController = ScrollController();

    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        controller.fetchUserOrders(isLoadMore: true);
      }
    });

    return FutureBuilder(
      future: controller.fetchUserOrders(),
      builder: (_, snapshot) {
        final emptyWidget = AnimationLoaderWidget(
          text: 'Whoops! No Orders Yet!',
          animation: ImageStrings.orderCompletedAnimation,
          showAction: false,
        );

        final response = CloudHelperFunctions.checkMultiRecordState(
            snapshot: snapshot,
            nothingFound: emptyWidget
        );
        if (response != null) return response;

        return Obx(() {
          final orders = controller.orders;

          return ListView.separated(
            controller: scrollController,
            shrinkWrap: true,
            itemCount: orders.length + (controller.isLoading.value ? 1 : 0),
            separatorBuilder: (_, __) => const SizedBox(height: Sizes.spaceBtwItems),
            itemBuilder: (_, index) {
              if (index == orders.length) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              final order = orders[index];
              final String shortOrderId = order.sId?.substring(order.sId!.length - 6) ?? '';

              return Padding(
                padding: const EdgeInsets.fromLTRB(15, 4, 15, 4),
                child: RoundedContainer(
                  showBorder: true,
                  padding: const EdgeInsets.all(Sizes.md),
                  backgroundColor: dark ? AppColors.dark : AppColors.light,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          const Icon(Iconsax.ship),
                          const SizedBox(width: Sizes.spaceBtwItems / 2),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  order.orderStatusText,
                                  style: Theme.of(context).textTheme.bodyLarge!.apply(color: AppColors.primary, fontWeightDelta: 1),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(order.formattedOrderDate, style: Theme.of(context).textTheme.headlineSmall),
                              ],
                            ),
                          ),
                          IconButton(
                              onPressed: () => Get.to(OrderDetailsScreen(order: order)),
                              icon: const Icon(Iconsax.arrow_right_34, size: Sizes.iconSm)
                          ),
                        ],
                      ),
                      const SizedBox(height: Sizes.spaceBtwItems),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                const Icon(Iconsax.tag),
                                const SizedBox(width: Sizes.spaceBtwItems / 2),
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Order',
                                        style: Theme.of(context).textTheme.labelMedium,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        '#$shortOrderId',
                                        style: Theme.of(context).textTheme.titleMedium,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                const Icon(Iconsax.calendar),
                                const SizedBox(width: Sizes.spaceBtwItems / 2),
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Shipping date',
                                        style: Theme.of(context).textTheme.labelMedium,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        order.formattedDeliveryDate,
                                        style: Theme.of(context).textTheme.titleMedium,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
      },
    );
  }
}
