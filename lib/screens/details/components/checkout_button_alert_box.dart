// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../providers/address_provider.dart';
import '../../../providers/providers.dart';
import '../../../utils/constants.dart';
import '../../../utils/size_config.dart';
import '../../cart/cart_screen.dart';
import '../../home/home_screen.dart';
import 'components.dart';

class CheckoutButtonAlertBox extends StatelessWidget {
  const CheckoutButtonAlertBox({
    Key? key,
    required this.widget,
    required this.width,
    required this.price,
    required this.quantity,
    required this.productId,
    required this.userId,
    required this.productImage,
    required this.size,
    required this.color,
  }) : super(key: key);

  final double width;
  final String price;
  final String productId;
  final String productImage;
  final AfterBuyNowButtonSheet widget;
  final int quantity;
  final String userId;
  final String size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Column(
          children: [
            // * continue shopping button
            Container(
              width: double.infinity,
              height: getProportionateScreenHeight(50),
              margin: const EdgeInsets.only(top: 45, left: 15, right: 15),
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                height: getProportionateScreenWidth(65),
                width: getProportionateScreenWidth(width),
                padding: EdgeInsets.only(
                  bottom: getProportionateScreenHeight(2),
                  top: getProportionateScreenHeight(2),
                ),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextButton(
                  child: const Text(
                    "Continue Shopping",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  },
                ),
              ),
            ),

            // * checkout button
            Container(
              width: double.infinity,
              height: getProportionateScreenHeight(50),
              margin: const EdgeInsets.only(
                  top: 15, left: 15, right: 15, bottom: 25),
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                height: getProportionateScreenWidth(65),
                width: getProportionateScreenWidth(width),
                padding: EdgeInsets.only(
                  bottom: getProportionateScreenHeight(2),
                  top: getProportionateScreenHeight(2),
                ),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextButton(
                  child: const Text(
                    "Checkout",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onPressed: () async {
                    await showPaymentDialog(
                        context, userId, productId, productImage, quantity);
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void showLocalNotification(String? title, String? body,
      BigTextStyleInformation? bigTextStyleInformation) {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      channelDescription: 'channel_description',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: false,
      playSound: true,
      styleInformation: bigTextStyleInformation,
    );
    NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    FlutterLocalNotificationsPlugin().show(
      0,
      title,
      body,
      platformChannelSpecifics,
    );
  }

  Future<void> showPaymentDialog(BuildContext context, String userId,
      String productId, String productImage, int quantity) async {
    CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: false);
    OrderProvider orderProvider =
        Provider.of<OrderProvider>(context, listen: false);
    AddressProvider addressProvider =
        Provider.of<AddressProvider>(context, listen: false);
    ProductProvider productProvider =
        Provider.of<ProductProvider>(context, listen: false);

    bool success = false;
    String orderStatus = 'Processing';

    String? orderId;

    String generateOrderId() {
      const uuid = Uuid();
      return uuid.v4();
    }

    orderId = generateOrderId();

    log('---------------');
    log('USER_ID = $userId');
    log('---------------');
    log('PRODUCT_ID = $productId');
    log('---------------');
    log('PRODUCT_IMAGE = $productImage');
    log('---------------');
    log('PRICE = ${price.toString()}');
    log('---------------');
    log('SIZE = $size');
    log('---------------');
    log('COLOR = $color');
    log('---------------');
    log('QUANTITY = ${quantity.toString()}');
    log('---------------');
    log('ORDER STATUS = $orderStatus');
    log('---------------');
    log('---------------');
    log('ORDER ID = $orderId');
    log('---------------');

    final orderData = {
      'orderId': orderId,
      'number': addressProvider.selectedAddress.phone,
      'size': productProvider.selectedSize,
      'color': productProvider.selectedColor.value
          .toRadixString(16)
          .padLeft(8, '0')
          .toUpperCase(),
      'address': addressProvider.selectedAddress.address +
          addressProvider.selectedAddress.pincode,
      'uid': userId,
      'orderedDate': DateTime.now().toString(),
      'productId': productId,
      'amount': double.parse(price),
      'productImage': productImage,
      'quantity': quantity,
      'orderStatus': orderStatus,
    };

    final productData = {
      'categories': widget.widget.product.categories,
      'id': productId,
      'title': widget.widget.product.title,
      'description': widget.widget.product.description,
      'images': widget.widget.product.images,
      'price': int.parse(price),
      'rating': widget.widget.product.rating,
      'isFavourite': widget.widget.product.isFavourite,
      'isPopular': widget.widget.product.isFavourite,
      'colors': widget.widget.product.colors,
      'sizes': widget.widget.product.sizes,
      'quantity': quantity,
    };

    try {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Center(
              child: Text(
                'Checkout With',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: kPrimaryColor,
                    ),
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () async {
                    try {
                      log('---------------');
                      log(orderData.toString());
                      log('---------------');

                      await orderProvider
                          .addOrder(orderData: orderData, uid: userId)
                          .then((value) {
                        success = true;
                        log('---------------');
                        log('ORDER_ID = $value');
                        orderId = value;
                      });

                      success = true;

                      showLocalNotification(
                        'Order Placed Successfully ✔🎉',
                        'Your order is placed successfully',
                        BigTextStyleInformation(
                          'Your order of ${orderData['amount'] as double} is placed, \n estimated delivery in next 2 hours.',
                          htmlFormatBigText: true,
                          contentTitle: 'Order Placed Successfully ✔🎉',
                        ),
                      );
                    } catch (error) {
                      log('---------------');
                      log(error.toString());
                      log('---------------');
                      success = false;
                    } finally {
                      Navigator.pop(context);
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: getProportionateScreenHeight(50),
                    margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        'Cash on Delivery',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.snackbar(
                      'Information ℹ',
                      'This functionality is yet to be implemented! 🙏',
                      backgroundColor: Colors.yellow,
                      colorText: Colors.black,
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: getProportionateScreenHeight(50),
                    margin: const EdgeInsets.only(
                      top: 15,
                      left: 15,
                      right: 15,
                    ),
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        'Online Payment',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    cartProvider.addToCartFromDetails(
                      productData,
                      userId,
                    );
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const CartScreen(),
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: getProportionateScreenHeight(50),
                    margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        'Go to Cart',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: double.infinity,
                    height: getProportionateScreenHeight(50),
                    margin: const EdgeInsets.only(
                      top: 15,
                      left: 15,
                      right: 15,
                    ),
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        'Cancel',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
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
    } catch (e) {
      success = false;
      log('Error occurred while adding the order: $e');
    }

    if (success) {
      Get.snackbar(
        'Success',
        'Order added successfully! 🎉',
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
      );

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
        (route) => false, // Remove all existing routes from the stack
      );
      log('---------------');
      log('USER_ID = $userId');
      log('---------------');
      log('PRICE = ${price.toString()}');
      log('---------------');
      log('QUANTITY = ${quantity.toString()}');
      log('---------------');
      log('ORDER STATUS = $orderStatus');
      log('---------------');
      log('ORDER ID = $orderId');
      log('---------------');
    } else {
      Get.snackbar(
        'Error',
        'Failed to add order. Please try again! 😕',
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
      );
    }
  }
}
