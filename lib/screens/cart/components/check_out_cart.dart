import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:soni_store_app/providers/address_provider.dart';
import 'package:soni_store_app/utils/constants.dart';
import 'package:uuid/uuid.dart';

import '../../../components/default_button.dart';
import '../../../models/models.dart';
import '../../../providers/providers.dart';
import '../../../utils/size_config.dart';

class CheckoutCard extends StatefulWidget {
  const CheckoutCard({Key? key}) : super(key: key);

  @override
  State<CheckoutCard> createState() => _CheckoutCardState();
}

class _CheckoutCardState extends State<CheckoutCard> {
  Map<String, dynamic>? paymentIntent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenWidth(15),
        horizontal: getProportionateScreenWidth(30),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -15),
            blurRadius: 20,
            color: const Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  height: getProportionateScreenWidth(40),
                  width: getProportionateScreenWidth(40),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F6F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SvgPicture.asset("assets/icons/receipt.svg"),
                ),
                const Spacer(),
                const Text("Add voucher code"),
                const SizedBox(width: 10),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: kTextColor,
                )
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            Consumer4<CartProvider, AuthProvider, OrderProvider,
                ProductProvider>(
              builder: (context, cartProvider, authProvider, orderProvider,
                  productProvider, _) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: "Total:\n",
                        children: [
                          TextSpan(
                            text: "₹ ${cartProvider.totalPrice}",
                            style: const TextStyle(
                              fontSize: 16,
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(190),
                      child: DefaultButton(
                        btnColor: kPrimaryColor,
                        txtColor: Colors.white,
                        text: "Check Out",
                        press: () {
                          showPaymentDialog(
                            context,
                            authProvider.user.uid,
                            orderProvider,
                            productProvider,
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void showLocalNotification(
    String? title,
    String? body,
    BigTextStyleInformation? bigTextStyleInformation,
  ) {
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

  Future<void> showPaymentDialog(
    BuildContext context,
    String userId,
    OrderProvider orderProvider,
    ProductProvider productProvider,
  ) async {
    bool success = false;
    String orderStatus = 'Processing';

    String generateOrderId() {
      const uuid = Uuid();
      return uuid.v4();
    }

    String orderId = generateOrderId();

    // Get the cart items from the cart provider
    CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: false);
    AddressProvider addressProvider =
        Provider.of<AddressProvider>(context, listen: false);
    List<Product> cartItems = cartProvider.cartItems;

    log('---------------');
    log('ORDER_ID = $orderId');
    log('---------------');
    log('USER_ID = $userId');
    log('---------------');

    double totalPrice = 0.0;
    List<Map<String, dynamic>> orderItems = [];

    // Create order items and calculate total price
    for (int i = 0; i < cartItems.length; i++) {
      Product cartItem = cartItems[i];
      String productId = cartItems[i].id;
      String productImage = cartItems[i].images.first;
      int quantity = cartItem.quantity;
      double price = double.parse(cartItems[i].price.toString());
      totalPrice += price * quantity;

      Map<String, dynamic> orderItem = {
        'productId': productId,
        'productImage': productImage,
        'quantity': quantity,
        'price': price,
      };

      orderItems.add(orderItem);
    }

    log('ORDER_ITEMS = $orderItems');
    log('---------------');
    log('TOTAL_PRICE = $totalPrice');
    log('---------------');

    Order order = Order(
      size: productProvider.selectedSize,
      color: productProvider.selectedColor,
      addressProvider.selectedAddress.phone,
      address: addressProvider.selectedAddress.address +
          addressProvider.selectedAddress.pincode,
      orderedDate: DateTime.now().toString(),
      uid: userId,
      orderStatus: orderStatus,
      amount: totalPrice,
      productId: 'cart_order_${generateOrderId().substring(0, 8)}',
      productImage: cartItems.isNotEmpty ? cartItems.first.images.first : '',
      quantity: orderItems.length,
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
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
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
                      await orderProvider.addOrder(
                        orderData: order.toMap(),
                        uid: userId,
                      );
                      success = true;
                      showLocalNotification(
                        'Order Placed Successfully ✔🎉',
                        'Your order is placed successfully',
                        BigTextStyleInformation(
                          'Your order of ${order.amount} is placed, \n estimated delivery in next 2 hours.',
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
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
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
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
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
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
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
