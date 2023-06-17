import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:soni_store_app/utils/size_config.dart';

import '../../models/models.dart' as models;
import '../../providers/auth_provider.dart';
import '../../utils/constants.dart';
import '../loading/shimmer_box.dart';
import 'order_item_detail_screen.dart';
import 'order_widget.dart';

class OrdersListOfSelectedCategoryScreen extends StatefulWidget {
  final String statusName;
  final String? productImage;

  const OrdersListOfSelectedCategoryScreen({
    Key? key,
    required this.statusName,
    this.productImage,
  }) : super(key: key);

  @override
  State<OrdersListOfSelectedCategoryScreen> createState() =>
      _OrdersListOfSelectedCategoryScreenState();
}

class _OrdersListOfSelectedCategoryScreenState
    extends State<OrdersListOfSelectedCategoryScreen> {
  late AuthProvider authProvider;
  late Stream<QuerySnapshot> orderStream;

  @override
  void initState() {
    super.initState();
    authProvider = context.read<AuthProvider>();
    orderStream = FirebaseFirestore.instance
        .collection('orders')
        .where('uid', isEqualTo: authProvider.user.uid)
        .where('orderStatus', isEqualTo: widget.statusName)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: kPrimaryColor,
          ),
        ),
        title: Text(
          '${widget.statusName} Orders',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: kPrimaryColor,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(getProportionateScreenHeight(15)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: orderStream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: SizedBox(
                        height: getProportionateScreenHeight(120),
                        width: MediaQuery.of(context).size.width * .9,
                        child: ShimmerBox(
                          child: SizedBox(
                            height: getProportionateScreenHeight(100),
                            width: getProportionateScreenWidth(100),
                          ),
                        ),
                      ),
                    );
                  }

                  final orderDocuments = snapshot.data!.docs;
                  final orderCount = orderDocuments.length;

                  return Expanded(
                    child: ListView.separated(
                      itemCount: orderCount,
                      separatorBuilder: (context, index) {
                        return SizedBox(
                            height: getProportionateScreenHeight(8));
                      },
                      itemBuilder: (context, index) {
                        final orderSnapshot = orderDocuments[index];
                        final orderData =
                            orderSnapshot.data() as Map<String, dynamic>;
                        return FutureBuilder<String?>(
                          future: getProductName(orderData['productId']),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: SizedBox(
                                  height: getProportionateScreenHeight(120),
                                  width: MediaQuery.of(context).size.width * .9,
                                  child: ShimmerBox(
                                    child: SizedBox(
                                      height: getProportionateScreenHeight(100),
                                      width: getProportionateScreenWidth(100),
                                    ),
                                  ),
                                ),
                              );
                            }
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            }
                            final productName = snapshot.data;
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => OrderItemDetailScreen(
                                      order: models.Order(
                                        orderId: orderData['orderId'],
                                        authProvider.user.number ??
                                            "+91 7023953453",
                                        productId: orderData['productId'],
                                        productImage: orderData['productImage'],
                                        orderedDate: orderData['orderedDate'],
                                        quantity: orderData['quantity'],
                                        amount: orderData['amount'],
                                        address: orderData['address'],
                                        orderStatus: orderData['orderStatus'],
                                        color: Colors.black.value
                                            .toRadixString(16)
                                            .padLeft(8, '0')
                                            .toString(),
                                        size: orderData['size'] == ''
                                            ? orderData['size']
                                            : "XL",
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: Dismissible(
                                key: Key(orderData['orderId']),
                                onDismissed: (direction) async {
                                  if (direction ==
                                      DismissDirection.endToStart) {
                                    await FirebaseFirestore.instance
                                        .collection('orders')
                                        .doc(orderDocuments[index].id)
                                        .update({
                                      'orderStatus': 'Delivered',
                                    });
                                    log('Delivered');
                                  }
                                  if (direction ==
                                      DismissDirection.startToEnd) {
                                    if (!mounted) return;
                                    await showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        String? cancellationReason;
                                        return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          title: Center(
                                            child: Text(
                                              'Cancel Reason 😮 ?',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    color: kPrimaryColor,
                                                  ),
                                            ),
                                          ),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              RadioListTile<String>(
                                                title: Text(
                                                  'Wrong Address',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall,
                                                ),
                                                value: 'Wrong Address',
                                                groupValue: cancellationReason,
                                                onChanged: (value) {
                                                  setState(() {
                                                    cancellationReason = value;
                                                  });
                                                },
                                              ),
                                              RadioListTile<String>(
                                                title: Text(
                                                  'Change the number',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall,
                                                ),
                                                value: 'Reason 2',
                                                groupValue: cancellationReason,
                                                onChanged: (value) {
                                                  setState(() {
                                                    cancellationReason = value;
                                                  });
                                                },
                                              ),
                                              RadioListTile<String>(
                                                title: Text(
                                                  'Other Reason',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall,
                                                ),
                                                value: 'Reason 3',
                                                groupValue: cancellationReason,
                                                onChanged: (value) {
                                                  setState(() {
                                                    cancellationReason = value;
                                                  });
                                                },
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('orders')
                                                      .doc(orderDocuments[index]
                                                          .id)
                                                      .update({
                                                    'orderStatus': 'Cancled'
                                                  }).then((value) =>
                                                          Navigator.pop(
                                                              context));
                                                  log('Cancled');
                                                },
                                                child: Container(
                                                  width: double.infinity,
                                                  height:
                                                      getProportionateScreenHeight(
                                                          50),
                                                  margin: const EdgeInsets.only(
                                                    top: 15,
                                                    left: 15,
                                                    right: 15,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: kPrimaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      'Cancel Order',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleMedium!
                                                          .copyWith(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Colors.white,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  }
                                },
                                secondaryBackground: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFB1EFD1),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                  ),
                                  child: Row(
                                    children: const [
                                      Spacer(),
                                      Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                      ),
                                    ],
                                  ),
                                ),
                                background: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFFFE6E6),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/icons/Trash.svg"),
                                      const Spacer(),
                                    ],
                                  ),
                                ),
                                child: OrderWidget(
                                  productImage: orderData['productImage'] ??
                                      'https://www.getillustrations.com/packs/gradient-marker-vector-illustrations/scenes/_1x/e-commerce%20_%20online,%20shopping,%20buy,%20purchase,%20empty,%20cart,%20order_md.png',
                                  orderId: orderData['productId'],
                                  productName: productName ?? 'Cart Order',
                                  quantity: orderData['quantity'],
                                  orderPrice: orderData['amount'].toString(),
                                  orderDate: orderData['orderedDate'],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<String?> getProductName(String productId) async {
    try {
      final productDoc = await FirebaseFirestore.instance
          .collection('products')
          .doc(productId)
          .get();
      final productData = productDoc.data();
      if (productData != null) {
        return productData['title'] as String?;
      }
    } catch (error) {
      log('Failed to get product name: $error');
    }
    return null;
  }
}
