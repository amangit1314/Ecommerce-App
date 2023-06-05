import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:soni_store_app/providers/auth_provider.dart';
import 'package:soni_store_app/providers/order_provider.dart';

import '../../models/models.dart' as models;
import '../../utils/constants.dart';
import '../../utils/size_config.dart';
import '../home/components/popular/popular_product.dart';

class OrderDetailScreen extends StatefulWidget {
  final String statusName;
  final String orderCategory;
  final String? productImage;

  const OrderDetailScreen({
    Key? key,
    required this.statusName,
    required this.orderCategory,
    this.productImage =
        'https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses_23-2149436200.jpg?w=2000',
  }) : super(key: key);

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  final CollectionReference _refOrders =
      FirebaseFirestore.instance.collection('orders');

  Future<List<models.Order>> fetchProductsFromFirestore(
      AuthProvider authProvider, String orderStaus) async {
    final List<models.Order> orders = [];
    // filtering if order status is Processing
    final QuerySnapshot snapshot = await _refOrders
        .where('orderStatus', isEqualTo: orderStaus)
        .where('uid', isEqualTo: authProvider.user.uid)
        .get();
    for (var element in snapshot.docs) {
      orders.add(models.Order.fromMap(element.data() as Map<String, dynamic>));
    }
    return orders;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.statusName,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: kPrimaryColor,
              ),
        ),
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: kPrimaryColor,
          ),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                // Wrap the StreamBuilder with Expanded
                child: Consumer2<OrderProvider, AuthProvider>(
                    builder: (context, orderProvider, authProvider, child) {
                  return FutureBuilder<List<models.Order>>(
                    future: fetchProductsFromFirestore(
                        authProvider, widget.statusName),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasError) {
                        log('------------------------------');
                        log(snapshot.error.toString());
                        log('------------------------------');
                        return const Center(
                          child: Text('Something went wrong'),
                        );
                      }

                      final List<models.Order> orders = snapshot.data ?? [];

                      if (orders.isEmpty) {
                        return const Center(child: Text('Your cart is empty'));
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: orders.length,
                            itemBuilder: (context, index) {
                              return const LoadingShimmerSkelton();
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(width: 8);
                            },
                          ),
                        );
                      }

                      return ListView.separated(
                        scrollDirection: Axis.vertical,
                        itemCount: orders.length,
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 8);
                        },
                        itemBuilder: (context, index) {
                          return FutureBuilder<String?>(
                            future: getProductName(orders[index].productId),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator(); // Show a loading indicator while fetching the product name.
                              } else if (snapshot.hasError) {
                                return const Text(
                                    'Error'); // Show an error message if an error occurred while fetching the product name.
                              } else {
                                final String? productName = snapshot.data;

                                return Dismissible(
                                  key: Key(orders[index].productId),
                                  direction: DismissDirection.endToStart,
                                  onDismissed: (direction) {
                                    orderProvider.changeOrderStatus(
                                      uid: authProvider.user.uid,
                                      oid: orders[index].orderId,
                                      orderStatus: 'Delivered',
                                    );
                                  },
                                  background: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    decoration: const BoxDecoration(
                                      color: Colors.greenAccent,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(15),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        const Spacer(),
                                        SizedBox(
                                          // height width 18
                                          height:
                                              getProportionateScreenHeight(18),
                                          // child: SvgPicture.asset(
                                          //   "assets/icons/Success.svg",
                                          //   // color: Colors.green,
                                          // ),
                                          child: const FaIcon(
                                            FontAwesomeIcons.circleCheck,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  child: OrderWidget(
                                    productImage: orders[index].productImage,
                                    quantity: orders[index].quantity,
                                    orderId: orders[index].orderId,
                                    productName: productName ??
                                        'Cart Order', // Use the retrieved product name or a default value if it's null.
                                    orderPrice: orders[index].amount,
                                    orderDate: orders[index].orderedDate,
                                  ),
                                );
                              }
                            },
                          );
                        },
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String?> getProductName(String productId) async {
    try {
      var productDoc = await FirebaseFirestore.instance
          .collection('products')
          .doc(productId)
          .get();
      var productData = productDoc.data();
      if (productData != null) {
        return productData['title'];
      }
    } catch (error) {
      log('Failed to get product name: $error');
    }
    return null; // Return null if the product is not found or if an error occurs.
  }
}

class OrderWidget extends StatelessWidget {
  final String? productImage;
  final int quantity;
  final String orderId;
  final String productName;
  final double orderPrice;
  final String orderDate;

  const OrderWidget({
    Key? key,
    this.productImage,
    required this.quantity,
    required this.orderId,
    required this.productName,
    required this.orderPrice,
    required this.orderDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: kPrimaryColor.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          Container(
            height: getProportionateScreenHeight(100),
            width: getProportionateScreenWidth(100),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                  productImage ??
                      'https://img.freepik.com/premium-vector/order-received-abstract-concept-vector-illustration_107173-31017.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // * orderid
                Text(
                  productName,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 4),
                // * orderId
                Text(
                  'OrderID: ${orderId.substring(0, 15)}',
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: kPrimaryColor,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                // const SizedBox(height: 4),
                // * date
                Text(
                  '${orderDate.split(' ')[0]} at ${orderDate.substring(10, 16)}',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: kTextColor,
                        fontSize: 10,
                        fontWeight: FontWeight.normal,
                      ),
                ),
                const SizedBox(height: 4),
                // * price and quantity
                Wrap(
                  spacing: 30,
                  children: [
                    Text(
                      'Amount: ₹ ${orderPrice.toString()}',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: kPrimaryColor,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      'Items (${quantity.toString()})',
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: kPrimaryColor,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
