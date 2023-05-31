import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soni_store_app/providers/auth_provider.dart';

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
    this.productImage,
  }) : super(key: key);

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  final CollectionReference _refOrders =
      FirebaseFirestore.instance.collection('orders');

  Future<List<models.Order>> fetchProductsFromFirestore(
      AuthProvider authProvider) async {
    final List<models.Order> orders = [];
    // filtering if order status is Processing
    final QuerySnapshot snapshot = await _refOrders
        .where('orderStatus', isEqualTo: 'Processing')
        .where('uid', isEqualTo: authProvider.user.uid)
        .get();
    for (var element in snapshot.docs) {
      orders.add(models.Order.fromMap(element.data() as Map<String, dynamic>));
    }
    return orders;
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
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
                child: FutureBuilder<List<models.Order>>(
                  future: fetchProductsFromFirestore(authProvider),
                  builder: (context, snapshot) {
                    final List<models.Order> orders = snapshot.data ?? [];

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

                    if (snapshot.hasError) {
                      log('------------------------------');
                      log(snapshot.error.toString());
                      log('------------------------------');
                      return const Center(
                        child: Text('Something went wrong'),
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

                              return OrderWidget(
                                productImage: orders[index].productImage,
                                quantity: orders[index].quantity,
                                orderId: orders[index].orderId,
                                productName: productName ??
                                    'Unknown', // Use the retrieved product name or a default value if it's null.
                                orderPrice: orders[index].amount,
                                orderDate: orders[index].orderedDate,
                              );
                            }
                          },
                        );
                      },
                    );
                  },
                ),
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
                image: NetworkImage(
                  productImage ?? 'https://example.com/default-image.jpg',
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
