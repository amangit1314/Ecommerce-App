import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:soni_store_app/providers/order_provider.dart';

import '../../utils/constants.dart';
import 'order_widget.dart';

class OrderDetailScreen extends StatelessWidget {
  final String statusName;

  const OrderDetailScreen({Key? key, required this.statusName})
      : super(key: key);

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
    FlutterLocalNotificationsPlugin()
        .show(0, title, body, platformChannelSpecifics);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          statusName,
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
                child: Consumer<OrderProvider>(
                  builder: (context, orderProvider, _) {
                    final orders = orderProvider.orders;

                    if (orderProvider.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (orderProvider.hasError) {
                      return const Center(child: Text('Something went wrong'));
                    }

                    if (orders.isEmpty) {
                      return const Center(child: Text('You have no orders'));
                    }

                    return ListView.separated(
                      scrollDirection: Axis.vertical,
                      itemCount: orders.length,
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 8);
                      },
                      itemBuilder: (context, index) {
                        final order = orders[index];
                        final String? productName = orderProvider
                            .getProductName(orders[index].orderId) as String?;
                        return OrderWidget(
                          productImage: order.productImage,
                          quantity: order.quantity,
                          orderId: order.orderId,
                          productName: productName ?? 'Cart Order',
                          orderPrice: order.amount,
                          orderDate: order.orderedDate,
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
