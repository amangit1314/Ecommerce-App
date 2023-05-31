import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../models/models.dart';
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
  }) : super(key: key);

  final double width;
  final String price;
  final String productId;
  final String productImage;
  final AfterBuyNowButtonSheet widget;
  final int quantity;
  final String userId;

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
                  color: Colors.deepOrange,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextButton(
                  child: const Text(
                    "Continue Shopping",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
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
                top: 15,
                left: 15,
                right: 15,
                bottom: 25,
              ),
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
                  color: Colors.deepOrange,
                  borderRadius: BorderRadius.circular(15),
                ),
                child:
                    Consumer<AuthProvider>(builder: (context, authProvider, _) {
                  return TextButton(
                    child: const Text(
                      "Checkout",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () async {
                      await showPaymentDialog(
                        context,
                        userId,
                        productId,
                        productImage,
                      );
                    },
                  );
                }),
              ),
            ),
          ],
        );
      },
    );
  }

  // ...

  Future<void> showPaymentDialog(
    BuildContext context,
    String userId,
    String productId,
    String productImage,
  ) async {
    CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: false);
    OrderProvider orderProvider =
        Provider.of<OrderProvider>(context, listen: false);

    bool success = false;
    String orderStatus = 'Processing';

    String generateOrderId() {
      const uuid = Uuid();
      return uuid.v4();
    }

    String orderId = generateOrderId();

    log('---------------');
    log('ORDER_ID = $orderId');
    log('---------------');
    log('USER_ID = $userId');
    log('---------------');
    log('PRODUCT_ID = $productId');
    log('---------------');
    log('PRODUCT_IMAGE = $productImage');
    log('---------------');
    log('PRICE = ${price.toString()}');
    log('---------------');
    log('QUANTITY = ${quantity.toString()}');
    log('---------------');
    log('ORDER STATUS = $orderStatus');
    log('---------------');

    Order order = Order(
      uid: userId,
      orderId: orderId,
      orderedDate: DateTime.now().toString(),
      productId: productId,
      amount: double.parse(price),
      productImage: productImage,
      quantity: quantity,
      orderStatus: orderStatus,
    );

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
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
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
                      log(order.toString());
                      log('---------------');
                      await orderProvider
                          .addOrder(order: order, uid: userId, oid: orderId)
                          .then((value) => success = true);
                      success = true;
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
                        'Cash',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
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
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    cartProvider.addToCart(widget.widget.product);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const CartScreen(),
                      ),
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
                        'Go to Cart',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
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
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
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
      log('---------------');
      log('USER_ID = $userId');
      log('---------------');
      log('PRICE = ${price.toString()}');
      log('---------------');
      log('QUANTITY = ${quantity.toString()}');
      log('---------------');
    } else {
      Get.snackbar(
        'Error',
        'Failed to add order! ❗⚠',
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
      );
    }
  }
}
