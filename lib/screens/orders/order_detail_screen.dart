import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// class OrderDetailScreen extends StatelessWidget {
//   final String statusName;
//   const OrderDetailScreen({Key? key, required this.statusName})
//       : super(key: key);
//   void showLocalNotification(String? title, String? body,
//       BigTextStyleInformation? bigTextStyleInformation) {
//     AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//       'channel_id',
//       'channel_name',
//       channelDescription: 'channel_description',
//       importance: Importance.high,
//       priority: Priority.high,
//       showWhen: false,
//       playSound: true,
//       styleInformation: bigTextStyleInformation,
//     );
//     NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);
//     FlutterLocalNotificationsPlugin()
//         .show(0, title, body, platformChannelSpecifics);
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text(
//           statusName,
//           style: Theme.of(context).textTheme.titleLarge!.copyWith(
//                 color: kPrimaryColor,
//               ),
//         ),
//         backgroundColor: Colors.white,
//         leading: GestureDetector(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: const Icon(
//             Icons.arrow_back_ios,
//             color: kPrimaryColor,
//           ),
//         ),
//         elevation: 0,
//         centerTitle: true,
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 child: Consumer<OrderProvider>(
//                   builder: (context, orderProvider, _) {
//                     final orders = orderProvider.orders;
//                     if (orderProvider.isLoading) {
//                       return const Center(child: CircularProgressIndicator());
//                     }
//                     if (orderProvider.hasError) {
//                       return const Center(child: Text('Something went wrong'));
//                     }
//                     if (orders.isEmpty) {
//                       return const Center(child: Text('You have no orders'));
//                     }
//                     return ListView.separated(
//                       scrollDirection: Axis.vertical,
//                       itemCount: orders.length,
//                       separatorBuilder: (context, index) {
//                         return const SizedBox(height: 8);
//                       },
//                       itemBuilder: (context, index) {
//                         final order = orders[index];
//                         final String? productName = orderProvider
//                             .getProductName(orders[index].orderId) as String?;
//                         return OrderWidget(
//                           productImage: order.productImage,
//                           quantity: order.quantity,
//                           orderId: order.orderId,
//                           productName: productName ?? 'Cart Order',
//                           orderPrice: order.amount,
//                           orderDate: order.orderedDate,
//                         );
//                       },
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// * --------------------------------------------------

// class OrderDetailScreen extends StatefulWidget {
//   final String statusName;
//   const OrderDetailScreen({
//     Key? key,
//     required this.statusName,
//   }) : super(key: key);
//   // create state
//   @override
//   State<OrderDetailScreen> createState() => _OrderDetailScreenState();
// }
// class _OrderDetailScreenState extends State<OrderDetailScreen> {
//   final CollectionReference refOrders =
//       FirebaseFirestore.instance.collection('orders');
//   Future<List<models.Order>> fetchProductsFromFirestore(
//       AuthProvider authProvider) async {
//     final List<models.Order> orders = [];
//     final QuerySnapshot snapshot = await refOrders
//         .where('orderStatus', isEqualTo: 'Processing')
//         .where('uid', isEqualTo: authProvider.user.uid)
//         .get();
//     for (var element in snapshot.docs) {
//       orders.add(models.Order.fromMap(element.data() as Map<String, dynamic>));
//     }
//     return orders;
//   }
//   @override
//   Widget build(BuildContext context) {
//     final authProvider = Provider.of<AuthProvider>(context, listen: false);
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(''),
//         backgroundColor: Colors.white,
//         leading: GestureDetector(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: const Icon(
//             Icons.arrow_back_ios,
//             color: kPrimaryColor,
//           ),
//         ),
//         elevation: 0,
//         centerTitle: true,
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: Column(
//             children: [
//               Expanded(
//                 child: FutureBuilder<List<models.Order>>(
//                   future: fetchProductsFromFirestore(authProvider),
//                   builder: (context, snapshot) {
//                     final List<models.Order> orders = snapshot.data ?? [];
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return const CircularProgressIndicator(); // Show a loading indicator while fetching the product name.
//                     }
//                     if (snapshot.hasError) {
//                       return const Text('Some error occured ❌');
//                     }
//                     if (orders.isEmpty) {
//                       return const Center(child: Text('You have no orders'));
//                     }
//                     return ListView.separated(
//                       scrollDirection: Axis.vertical,
//                       itemCount: orders.length,
//                       separatorBuilder: (context, index) {
//                         return const SizedBox(height: 8);
//                       },
//                       itemBuilder: (context, index) {
//                         final productName =
//                             getProductName(orders[index].productId) as String?;
//                         return OrderWidget(
//                           productImage: orders[index].productImage,
//                           quantity: orders[index].quantity,
//                           orderId: orders[index].orderId,
//                           orderPrice: orders[index].amount,
//                           productName: productName ?? 'Cart Order',
//                           orderDate: orders[index].orderedDate,
//                         );
//                       },
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<String?> getProductName(String productId) async {
//     try {
//       var productDoc = await FirebaseFirestore.instance
//           .collection('products')
//           .doc(productId)
//           .get();
//       var productData = productDoc.data();
//       if (productData != null) {
//         return productData['title'] as String?;
//       }
//     } catch (error) {
//       log('Failed to get product name: $error');
//     }
//     return null; // Return null if the product is not found or if an error occurs.
//   }
// }

// * --------------------------------------------------

import '../../models/product.dart';
import '../../providers/auth_provider.dart';
import '../../utils/constants.dart';
import 'order_widget.dart';

class OrderDetailScreen extends StatefulWidget {
  final String statusName;
  final String? productImage;

  const OrderDetailScreen({
    Key? key,
    required this.statusName,
    this.productImage,
  }) : super(key: key);

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  List<Product> products = []; // List to store fetched products

  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthProvider>();
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
                    .where('uid', isEqualTo: authProvider.user.uid)
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
                    child: ListView.separated(
                      itemCount: orderCount,
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 8);
                      },
                      itemBuilder: (context, index) {
                        DocumentSnapshot orderSnapshot = orderDocuments[index];
                        Map<String, dynamic> orderData =
                            orderSnapshot.data() as Map<String, dynamic>;
                        final Future<String?> productName =
                            getProductName(orderData['productId']);
                        return FutureBuilder<String?>(
                          future: productName,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              // Show a loading indicator while waiting for the data
                              return const CircularProgressIndicator();
                            }
                            if (snapshot.hasError) {
                              // Show an error message if an error occurs
                              return Text('Error: ${snapshot.error}');
                            }
                            final String? productName = snapshot.data;
                            return OrderWidget(
                              productImage: orderData['productImage'] ??
                                  'https://www.getillustrations.com/packs/gradient-marker-vector-illustrations/scenes/_1x/e-commerce%20_%20online,%20shopping,%20buy,%20purchase,%20empty,%20cart,%20order_md.png',
                              orderId: orderData['orderId'],
                              // productName: 'Cart Order',
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
      var productDoc = await FirebaseFirestore.instance
          .collection('products')
          .doc(productId)
          .get();
      var productData = productDoc.data();
      if (productData != null) {
        return productData['title'] as String?;
      }
    } catch (error) {
      log('Failed to get product name: $error');
    }
    return null; // Return null if the product is not found or if an error occurs.
  }
}
