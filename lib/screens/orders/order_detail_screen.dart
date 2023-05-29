import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/models.dart' as models;
import '../../utils/constants.dart';
import '../../utils/size_config.dart';
import '../home/components/popular/popular_product.dart';

class OrderDetailScreen extends StatefulWidget {
  final String statusName;
  final String orderCategory;
  final String orderName;
  final String orderPrice;
  final String? productImage;

  const OrderDetailScreen({
    Key? key,
    required this.statusName,
    required this.orderCategory,
    required this.orderName,
    required this.orderPrice,
    this.productImage,
  }) : super(key: key);

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  final CollectionReference _refOrders =
      FirebaseFirestore.instance.collection('orders');

  Future<List<models.Order>> fetchProductsFromFirestore() async {
    final List<models.Order> orders = [];
    // filtering if order status is Processing
    final QuerySnapshot snapshot =
        await _refOrders.where('orderStatus', isEqualTo: 'Processing').get();
    for (var element in snapshot.docs) {
      orders.add(models.Order.fromMap(element.data() as Map<String, dynamic>));
    }
    return orders;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.statusName,
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                // Wrap the StreamBuilder with Expanded
                child: FutureBuilder<List<models.Order>>(
                  future: fetchProductsFromFirestore(),
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

                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: orders.length,
                      itemBuilder: (context, index) {
                        return OrderWidget(
                          productImage: orders[index].productImage,
                          quantity: orders[index].quantity,
                          orderId: orders[index].orderId,
                          productId: orders[index].productId,
                          orderPrice: orders[index].amount,
                          orderDate: orders[index].orderedDate,
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
}

class OrderWidget extends StatelessWidget {
  final String? productImage;
  final int quantity;
  final String orderId;
  final String productId;
  final double orderPrice;
  final String orderDate;

  const OrderWidget({
    Key? key,
    this.productImage,
    required this.quantity,
    required this.orderId,
    required this.productId,
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
                  orderId,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                ),

                // * productid
                Text(
                  productId,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: kPrimaryColor,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                ),

                // * date
                Text(
                  orderDate,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: kPrimaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                      ),
                ),

                // * price and quantity
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      orderPrice.toString(),
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: kPrimaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                    Text(
                      quantity.toString(),
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
