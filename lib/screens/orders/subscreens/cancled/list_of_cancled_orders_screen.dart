import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soni_store_app/utils/size_config.dart';

import '../../../../providers/providers.dart';
import '../../../../utils/constants.dart';
import '../../../loading/shimmer_box.dart';
import '../../order_widget.dart';

class ListOfCancledOrdersScreen extends StatefulWidget {
  final String statusName;
  final String? productImage;

  const ListOfCancledOrdersScreen({
    Key? key,
    required this.statusName,
    this.productImage,
  }) : super(key: key);

  @override
  State<ListOfCancledOrdersScreen> createState() =>
      _ListOfCancledOrdersScreenState();
}

class _ListOfCancledOrdersScreenState extends State<ListOfCancledOrdersScreen> {
  late AuthProvider authProvider;
  late Stream<QuerySnapshot> orderStream;

  @override
  void initState() {
    super.initState();
    authProvider = context.read<AuthProvider>();
    orderStream = FirebaseFirestore.instance
        .collection('orders')
        .where('uid', isEqualTo: authProvider.user.uid)
        .where('orderStatus', isEqualTo: 'Cancled')
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
                            return OrderWidget(
                              productImage: orderData['productImage'] ??
                                  'https://www.getillustrations.com/packs/gradient-marker-vector-illustrations/scenes/_1x/e-commerce%20_%20online,%20shopping,%20buy,%20purchase,%20empty,%20cart,%20order_md.png',
                              orderId: orderData['productId'],
                              productName: productName ?? 'Cart Order',
                              quantity: orderData['quantity'],
                              orderPrice: orderData['amount'].toString(),
                              orderDate: orderData['orderedDate'],
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
