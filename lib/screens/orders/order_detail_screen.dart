import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/product.dart';
import '../../utils/constants.dart';
import '../../utils/size_config.dart';

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
  List<Product> products = []; // List to store fetched products

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
                    widget.statusName,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: kPrimaryColor,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('orders')
                    .where('orderStatus', isEqualTo: 'Processing')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  List<DocumentSnapshot> orderDocuments = snapshot.data!.docs;
                  int orderCount = orderDocuments.length;

                  return Expanded(
                    child: ListView.builder(
                      itemCount: orderCount,
                      itemBuilder: (context, index) {
                        DocumentSnapshot orderSnapshot = orderDocuments[index];
                        Map<String, dynamic> orderData =
                            orderSnapshot.data() as Map<String, dynamic>;

                        return OrderWidget(
                          productImage: orderData['productImage'],
                          orderCategory: orderData['orderCategory'],
                          orderName: orderData['orderName'],
                          orderPrice: orderData['orderPrice'],
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
}

class OrderWidget extends StatelessWidget {
  final String? productImage;
  final String orderCategory;
  final String orderName;
  final String orderPrice;

  const OrderWidget({
    Key? key,
    this.productImage,
    required this.orderCategory,
    required this.orderName,
    required this.orderPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: kPrimaryColor.withOpacity(.3),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            height: getProportionateScreenHeight(100),
            width: getProportionateScreenWidth(100),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(
                  productImage ??
                      'https://theproductmanager.b-cdn.net/wp-content/uploads/sites/4/2020/05/what-does-a-product-manager-do-featured-image-01-800x800.png',
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
                Text(
                  orderCategory,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                ),
                Text(
                  orderName,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  orderPrice,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
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
    );
  }
}
