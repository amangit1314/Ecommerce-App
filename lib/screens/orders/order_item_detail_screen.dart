import 'package:flutter/material.dart';
import 'package:soni_store_app/utils/constants.dart';

import '../../components/default_button.dart';
import '../../models/models.dart';

class OrderItemDetailScreen extends StatelessWidget {
  final Order order;
  const OrderItemDetailScreen({super.key, required this.order});

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
                        // text order status
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.amber,
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
                                  "Order Id: ",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  order.productId,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: kPrimaryColor,
                                  ),
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
                              order.address,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              order.number,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Text(
                              order.address.split(' ')[2],
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
}
