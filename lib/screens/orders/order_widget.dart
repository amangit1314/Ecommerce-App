import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import '../../utils/size_config.dart';

class OrderWidget extends StatelessWidget {
  final String? productImage;
  final int quantity;
  final String orderId;
  final String productName;
  final double orderPrice;
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
          SizedBox(
            height: getProportionateScreenHeight(100),
            width: getProportionateScreenWidth(100),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: productImage != null
                  ? Image.network(
                      productImage!,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const CircularProgressIndicator();
                      },
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.error),
                    )
                  : const Icon(Icons.shopping_cart),
            ),
          ),
          const SizedBox(width: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Quantity: $quantity',
                  style: TextStyle(
                    fontSize: 14,
                    color: kTextColor.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Order ID: $orderId',
                  style: TextStyle(
                    fontSize: 14,
                    color: kTextColor.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Order Price: \$$orderPrice',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Ordered Date: $orderDate',
                  style: TextStyle(
                    fontSize: 14,
                    color: kTextColor.withOpacity(0.6),
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
