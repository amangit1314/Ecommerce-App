import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import '../../utils/size_config.dart';

class OrderWidget extends StatelessWidget {
  final String? productImage;
  final int quantity;
  final String orderId;
  final String productName;
  final String orderPrice;
  final String orderDate;

  const OrderWidget({
    Key? key,
    this.productImage,
    required this.quantity,
    required this.orderId,
    required this.productName,
    required this.orderPrice,
    required this.orderDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: kPrimaryColor.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          Container(
            height: getProportionateScreenHeight(100),
            width: getProportionateScreenWidth(100),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                  productImage ??
                      'https://www.getillustrations.com/packs/gradient-marker-vector-illustrations/scenes/_1x/e-commerce%20_%20online,%20shopping,%20buy,%20purchase,%20empty,%20cart,%20order_md.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // * orderid
                  Text(
                    productName,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 4),
                  // * orderId
                  Text(
                    'OrderID: ${orderId.substring(0, 15)}',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: kPrimaryColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  // const SizedBox(height: 4),
                  // * date
                  Text(
                    '${orderDate.split(' ')[0]} at ${orderDate.substring(10, 16)}',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: kTextColor,
                          fontSize: 10,
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                  const SizedBox(height: 4),
                  // * price and quantity
                  Wrap(
                    spacing: 30,
                    children: [
                      Text(
                        'Amount: ₹ ${orderPrice.toString()}',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: kPrimaryColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      Text(
                        'Items (${quantity.toString()})',
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: kPrimaryColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
