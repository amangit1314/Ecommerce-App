import 'package:flutter/material.dart';

import '../../components/custom_bottom_nav_bar.dart';
import '../../utils/constants.dart';
import '../../utils/enums.dart';
import 'order_detail_screen.dart';
import 'subscreens/subscreens.dart';

class RecentsScreen extends StatefulWidget {
  const RecentsScreen({super.key});

  @override
  State<RecentsScreen> createState() => _RecentsScreenState();
}

class _RecentsScreenState extends State<RecentsScreen>
    with TickerProviderStateMixin {
  late AnimationController bottomSheetAnimationController;

  @override
  void initState() {
    super.initState();
    bottomSheetAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      reverseDuration: const Duration(milliseconds: 500),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bottomSheetAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Orders",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: kPrimaryColor,
              ),
        ),
        backgroundColor: Colors.white,
        leading: const Icon(
          Icons.arrow_back_ios,
          color: kPrimaryColor,
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              'Orders history',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          ProcessingOrders(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const OrderDetailScreen(
                    statusName: 'Processing',
                    orderCategory: 'Pants',
                    orderName: 'Adididas Boxers',
                    orderPrice: '₹ 500',
                  ),
                ),
              );
            },
          ),
          AwaitingPaymentOrder(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const OrderDetailScreen(
                    statusName: 'Awaiting Payments',
                    orderCategory: 'Pants',
                    orderName: 'Adididas Boxers',
                    orderPrice: '₹ 500',
                  ),
                ),
              );
            },
          ),
          DeliveredOrders(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const OrderDetailScreen(
                    statusName: 'Delivered Orders',
                    orderCategory: 'Pants',
                    orderName: 'Adididas Boxers',
                    orderPrice: '₹ 500',
                  ),
                ),
              );
            },
          ),
          ReturnedOrders(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const OrderDetailScreen(
                    statusName: 'Returned Orders',
                    orderCategory: 'Pants',
                    orderName: 'Adididas Boxers',
                    orderPrice: '₹ 500',
                  ),
                ),
              );
            },
          ),
          CancledOrders(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const OrderDetailScreen(
                    statusName: 'Cancled Orders',
                    orderCategory: 'Pants',
                    orderName: 'Adididas Boxers',
                    orderPrice: '₹ 500',
                  ),
                ),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(
        selectedMenu: MenuState.wallet,
      ),
    );
  }
}
