
import 'package:flutter/material.dart';
import 'package:karmalab_assignment/screens/order/widgets/orders_list.dart';
import 'package:karmalab_assignment/utils/constants/sizes.dart';

import '../../common/widgets/appbar/appbar.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: Text('My Orders', style: Theme.of(context).textTheme.headlineSmall), showBackArrow: true),
      body: const Padding(
        padding: EdgeInsets.all(Sizes.defaultSpace),
        child: OrdersListItems(),
      ),
    );
  }
}
