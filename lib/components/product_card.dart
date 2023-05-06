import 'package:flutter/material.dart';

import '../../../utils/constatns.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    this.width = 150,
    this.aspectRetio = 1.02,
    required this.productImage,
    this.productName = 'Gaming',
    this.productDesc = 'These are from gaming category',
    this.color = Colors.white,
    this.addedToCart,
  }) : super(key: key);

  final double width, aspectRetio;
  final String productImage;
  final String productName;
  final String productDesc;
  final Color color;
  final bool? addedToCart;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
        color: kPrimaryColor.withOpacity(.1),
        // color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            // padding: const EdgeInsets.all(10),

            width: width,
            height: 110,
            decoration: BoxDecoration(
              color: color.withOpacity(.3),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Image.asset(
                productImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                productName,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              // const SizedBox(width: 6),
              const Spacer(),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 40,
                  width: 40,
                  color: kPrimaryColor.withOpacity(0.1),
                  child: const Icon(
                    Icons.shopping_bag_outlined,
                    // addedToCart!
                    //     ? Icons.shopping_bag
                    //     : Icons.shopping_bag_outlined,
                    size: 14,
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0, top: 4, bottom: 8),
            child: Text(
              productDesc,
              style: const TextStyle(
                fontSize: 12,
                color: kTextColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
