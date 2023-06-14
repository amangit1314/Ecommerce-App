import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../components/default_button.dart';
import '../../models/models.dart' as models;
import '../../utils/constants.dart';
import '../../utils/size_config.dart';
import '../details/reviews/add_review_screen.dart';

class OrderItemDetailScreen extends StatelessWidget {
  final models.Order order;
  const OrderItemDetailScreen({Key? key, required this.order})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * .4,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(order.productImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                FutureBuilder<String>(
                  future: getProductNameById(order.productId),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return CustomAppBar(
                        color: Colors.transparent,
                        image: order.productImage,
                        name: snapshot.data!,
                        category: '',
                      );
                    } else if (snapshot.hasError) {
                      log('Failed to retrieve product name: ${snapshot.error}');
                    }
                    return const SizedBox();
                  },
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, top: 15.0, bottom: 10, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Order Details',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        // text order status
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: order.orderStatus == 'Delivered'
                                ? Colors.green
                                : Colors.amber,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            order.orderStatus,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15.0, right: 15.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.local_shipping_outlined,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  "Order Name: ",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                FutureBuilder<String>(
                                  future: getProductNameById(order.productId),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Text(
                                        snapshot.data!,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                            decorationThickness: 1.5,
                                            decoration:
                                                TextDecoration.underline,
                                            decorationColor: kPrimaryColor,
                                            fontWeight: FontWeight.w600),
                                      );
                                    } else if (snapshot.hasError) {
                                      log('Failed to retrieve product name: ${snapshot.error}');
                                    }
                                    return const SizedBox();
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Order Date: ',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  order.orderedDate.split(' ')[0],
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Quantity:',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "${order.quantity}",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
                child: Divider(color: Colors.black12, height: 1),
              ),
              Container(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Delivery Location',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        // pin icon
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.pin_drop,
                            color: Colors.grey,
                          ),
                        ),

                        // sizedbox width 8
                        const SizedBox(width: 12),

                        // column of address and pincode
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              order.address != ''
                                  ? order.address
                                  : 'No Address Selected',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              order.number != ''
                                  ? order.number
                                  : '+91 1234567890',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Text(
                              order.address != ''
                                  ? order.address.split(' ')[2]
                                  : 'Not Set',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Divider(color: Colors.black12, height: 1),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      " Amount:  \$${order.amount}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                    const Text(
                      "Estimated delivery in 2 hours",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: DefaultButton(
                  text: 'Go Back',
                  txtColor: Colors.white,
                  press: () {
                    Navigator.of(context).pop();
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Future<String> getProductNameById(String id) async {
    try {
      final productDoc =
          await FirebaseFirestore.instance.collection('products').doc(id).get();
      final productData = productDoc.data();

      if (productData != null) {
        return productData['title'] as String;
      }
    } catch (error) {
      log('Failed to get product name: $error');
    }
    return 'Cart Order';
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color? color;
  final String image;
  final String name;
  final String category;

  const CustomAppBar({
    Key? key,
    this.color,
    required this.image,
    required this.name,
    required this.category,
  }) : super(key: key);

  @override
  Size get preferredSize => AppBar().preferredSize;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
        ),
        padding: EdgeInsets.only(
          left: getProportionateScreenWidth(20),
          top: getProportionateScreenHeight(10),
          right: getProportionateScreenWidth(10),
        ),
        child: Row(
          children: [
            SizedBox(
              height: getProportionateScreenWidth(40),
              width: getProportionateScreenWidth(40),
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: kPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60),
                  ),
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.zero,
                ),
                onPressed: () => Navigator.pop(context),
                child: Center(
                  child: SvgPicture.asset(
                    "assets/icons/Back ICon.svg",
                    height: 15,
                    // colorFilter  white color
                  ),
                ),
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                // add review screen
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AddReviewScreen(
                      name: name,
                      category: category,
                      image: image,
                    ),
                  ),
                );
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                // child: SvgPicture.asset("assets/icons/Star Icon.svg"),
                child: const Icon(Icons.star_border_outlined),
              ),
            )
          ],
        ),
      ),
    );
  }
}


/**
 * import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../components/default_button.dart';
import '../../models/models.dart' as models;
import '../../utils/constants.dart';

class OrderItemDetailScreen extends StatelessWidget {
  final models.Order order;

  const OrderItemDetailScreen({Key? key, required this.order})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .4,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              image: DecorationImage(
                image: NetworkImage(order.productImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, top: 15.0, bottom: 10, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Order Details',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: order.orderStatus == 'Delivered'
                                ? Colors.green
                                : Colors.amber,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            order.orderStatus,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15.0, right: 15.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.local_shipping_outlined,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  "Order Name: ",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                FutureBuilder<String>(
                                  future: getProductNameById(order.productId),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return ZigZagDecorationLine(
                                        width: 150,
                                        height: 18,
                                        color: kPrimaryColor,
                                        thickness: 1,
                                        zigzagHeight: 6,
                                        child: Text(
                                          snapshot.data!,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      );
                                    } else if (snapshot.hasError) {
                                      log('Failed to retrieve product name: ${snapshot.error}');
                                    }
                                    return const SizedBox();
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Order Date: ',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  order.orderedDate.split(' ')[0],
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Quantity:',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "${order.quantity}",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
                child: Divider(color: Colors.black12, height: 1),
              ),
              Container(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Delivery Location',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.pin_drop,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              order.address != ''
                                  ? order.address
                                  : 'No Address Selected',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              order.number != ''
                                  ? order.number
                                  : '+91 1234567890',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Text(
                              order.address != ''
                                  ? order.address.split(' ')[2]
                                  : 'Not Set',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Divider(color: Colors.black12, height: 1),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      " Amount:  \$${order.amount}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                    const Text(
                      "Estimated delivery in 2 hours",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: DefaultButton(
                  text: 'Go Back',
                  txtColor: Colors.white,
                  press: () {
                    Navigator.of(context).pop();
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Future<String> getProductNameById(String id) async {
    try {
      final productDoc =
          await FirebaseFirestore.instance.collection('products').doc(id).get();
      final productData = productDoc.data();

      if (productData != null) {
        return productData['title'] as String;
      }
    } catch (error) {
      log('Failed to get product name: $error');
    }
    return 'Cart Order';
  }
}

class ZigZagDecorationLine extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final double thickness;
  final double zigzagHeight;
  final Widget child;

  const ZigZagDecorationLine({
    Key? key,
    required this.width,
    required this.height,
    required this.color,
    required this.thickness,
    required this.zigzagHeight,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ZigZagPainter(
        color: color,
        thickness: thickness,
        zigzagHeight: zigzagHeight,
      ),
      child: SizedBox(
        width: width,
        height: height,
        child: child,
      ),
    );
  }
}

class ZigZagPainter extends CustomPainter {
  final Color color;
  final double thickness;
  final double zigzagHeight;

  ZigZagPainter({
    required this.color,
    required this.thickness,
    required this.zigzagHeight,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..style = PaintingStyle.stroke;

    final path = Path();
    final double halfHeight = size.height / 2;

    path.moveTo(0, halfHeight);
    for (double x = 0; x < size.width; x += zigzagHeight) {
      path.lineTo(x + zigzagHeight / 2, halfHeight + zigzagHeight / 2);
      path.lineTo(x + zigzagHeight, halfHeight);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

 */