import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../components/custom_bottom_nav_bar.dart';
import '../../utils/constants.dart';
import '../../utils/enums.dart';
import '../../utils/size_config.dart';

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
          // orders history text
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              'Orders history',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),

          // processing
          ProcessingOrders(
            // ontap navigate and change and provide respective arguments to OrdersDetailsScreen
            onTap: () {
              // navigate to home screen using navigator.push
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const OrdersDetailScreen(
                    statusName: 'Processing',
                    orderCategory: 'Pants',
                    orderName: 'Adididas Boxers',
                    orderPrice: '₹ 500',
                  ),
                ),
              );
            },
          ),

          // awaiting payments
          AwaitingPaymentOrder(
            onTap: () {
              // navigate to home screen using navigator.push
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const OrdersDetailScreen(
                    statusName: 'Awaiting Payments',
                    orderCategory: 'Pants',
                    orderName: 'Adididas Boxers',
                    orderPrice: '₹ 500',
                  ),
                ),
              );
            },
          ),

          // delivered
          DeliveredOrders(
            onTap: () {
              // navigate to home screen using navigator.push
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const OrdersDetailScreen(
                    statusName: 'Delivered Orders',
                    orderCategory: 'Pants',
                    orderName: 'Adididas Boxers',
                    orderPrice: '₹ 500',
                  ),
                ),
              );
            },
          ),

          // returned
          ReturnedOrders(
            onTap: () {
              // navigate to home screen using navigator.push
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const OrdersDetailScreen(
                    statusName: 'Returned Orders',
                    orderCategory: 'Pants',
                    orderName: 'Adididas Boxers',
                    orderPrice: '₹ 500',
                  ),
                ),
              );
            },
          ),

          // cancled
          CancledOrders(
            onTap: () {
              // navigate to home screen using navigator.push
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const OrdersDetailScreen(
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

class CancledOrders extends StatelessWidget {
  final void Function()? onTap;
  const CancledOrders({
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: getProportionateScreenWidth(20),
        right: getProportionateScreenWidth(20),
        top: 10,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: getProportionateScreenHeight(60),
          decoration: BoxDecoration(
            // border on top and bottom side
            border: Border(
              bottom: BorderSide(
                color: kPrimaryColor.withOpacity(.3),
                width: 1,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  const FaIcon(
                    FontAwesomeIcons.circleXmark,
                    size: 12,
                    color: kPrimaryColor,
                  ),
                  SizedBox(width: getProportionateScreenWidth(10)),
                  const Text(
                    "Cancled",
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: kPrimaryColor),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  Container(
                    // height: 5,
                    // width: 8,
                    padding: const EdgeInsets.only(
                      left: 12,
                      right: 12,
                      top: 2,
                      bottom: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      '0',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: kPrimaryColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReturnedOrders extends StatelessWidget {
  final void Function()? onTap;
  const ReturnedOrders({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: getProportionateScreenWidth(20),
        right: getProportionateScreenWidth(20),
        top: 10,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: getProportionateScreenHeight(60),
          decoration: BoxDecoration(
            // border on top and bottom side
            border: Border(
              bottom: BorderSide(
                color: kPrimaryColor.withOpacity(.3),
                width: 1,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  const FaIcon(
                    FontAwesomeIcons.caretLeft,
                    size: 12,
                    color: kPrimaryColor,
                  ),
                  SizedBox(width: getProportionateScreenWidth(10)),
                  const Text(
                    "Returned",
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: kPrimaryColor),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  Container(
                    // height: 5,
                    // width: 8,
                    padding: const EdgeInsets.only(
                      left: 12,
                      right: 12,
                      top: 2,
                      bottom: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.deepPurpleAccent,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      '0',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: kPrimaryColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DeliveredOrders extends StatelessWidget {
  final void Function()? onTap;
  const DeliveredOrders({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: getProportionateScreenWidth(20),
        right: getProportionateScreenWidth(20),
        top: 10,
      ),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          height: getProportionateScreenHeight(60),
          decoration: BoxDecoration(
            // border on top and bottom side
            border: Border(
              bottom: BorderSide(
                color: kPrimaryColor.withOpacity(.3),
                width: 1,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  const FaIcon(
                    FontAwesomeIcons.truckDroplet,
                    size: 12,
                    color: kPrimaryColor,
                  ),
                  SizedBox(width: getProportionateScreenWidth(10)),
                  const Text(
                    "Delivered",
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: kPrimaryColor),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  Container(
                    // height: 5,
                    // width: 8,
                    padding: const EdgeInsets.only(
                      left: 12,
                      right: 12,
                      top: 2,
                      bottom: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      '0',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: kPrimaryColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AwaitingPaymentOrder extends StatelessWidget {
  const AwaitingPaymentOrder({
    super.key,
    this.onTap,
  });
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: getProportionateScreenWidth(20),
        right: getProportionateScreenWidth(20),
        top: 10,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: getProportionateScreenHeight(60),
          decoration: BoxDecoration(
            // border on top and bottom side
            border: Border(
              bottom: BorderSide(
                color: kPrimaryColor.withOpacity(.3),
                width: 1,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  const FaIcon(
                    FontAwesomeIcons.wallet,
                    size: 12,
                    color: kPrimaryColor,
                  ),
                  SizedBox(width: getProportionateScreenWidth(10)),
                  const Text(
                    "Awaiting Payments",
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: kPrimaryColor),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  Container(
                    // height: 5,
                    // width: 8,
                    padding: const EdgeInsets.only(
                      left: 12,
                      right: 12,
                      top: 2,
                      bottom: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      '0',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: kPrimaryColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProcessingOrders extends StatelessWidget {
  const ProcessingOrders({
    super.key,
    this.onTap,
  });
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: getProportionateScreenWidth(20),
        right: getProportionateScreenWidth(20),
        top: 10,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: getProportionateScreenHeight(60),
          decoration: BoxDecoration(
            // border on top and bottom side
            border: Border(
              bottom: BorderSide(
                color: kPrimaryColor.withOpacity(.3),
                width: 1,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  const FaIcon(
                    FontAwesomeIcons.googleWallet,
                    size: 12,
                    color: kPrimaryColor,
                  ),
                  SizedBox(width: getProportionateScreenWidth(10)),
                  const Text(
                    "Processing",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: kPrimaryColor,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  Container(
                    // height: 5,
                    // width: 8,
                    padding: const EdgeInsets.only(
                      left: 12,
                      right: 12,
                      top: 2,
                      bottom: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.indigoAccent,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      '0',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: kPrimaryColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OrdersDetailScreen extends StatelessWidget {
  final String statusName;
  final String orderCategory;
  final String orderName;
  final String orderPrice;
  const OrdersDetailScreen({
    super.key,
    required this.statusName,
    required this.orderCategory,
    required this.orderName,
    required this.orderPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: kPrimaryColor,
                    ),
                  ),
                  Text(
                    statusName,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: kPrimaryColor,
                        ),
                  ),
                ],
              ),
              // sizedbox height 10
              const SizedBox(height: 15),
              Container(
                // decoration border
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: kPrimaryColor.withOpacity(.3),
                      width: 1,
                    ),
                  ),
                ),
                // design this container to have ordered product image first in row and then second a column which should contain order category name, order name, and order price
                child: Row(
                  children: [
                    // ordered product image
                    Container(
                      height: getProportionateScreenHeight(100),
                      width: getProportionateScreenWidth(150),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/4.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    // order category name, order name, and order price
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            orderCategory,
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                          ),
                          Text(
                            orderName,
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          Text(
                            orderPrice,
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: kPrimaryColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
