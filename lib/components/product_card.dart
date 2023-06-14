import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    this.width = 150,
    this.aspectRatio = 1.02,
    required this.productImage,
    this.productName = 'Gaming',
    this.productDesc = 'These are from gaming category',
    this.color = Colors.white,
    this.addedToCart = false,
    required this.price,
    this.onTap,
  }) : super(key: key);

  final double width, aspectRatio;
  final String productImage;
  final String productName;
  final String productDesc;
  final Color color;
  final String price;
  final bool addedToCart;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: width,
            height: 110,
            decoration: BoxDecoration(
              color: color.withOpacity(.3),
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: AssetImage(
                  productImage,
                ),
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
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: GestureDetector(
                  onTap: onTap ?? () {},
                  child: Container(
                    height: 40,
                    width: 40,
                    color: kPrimaryColor.withOpacity(0.1),
                    child: Icon(
                      addedToCart
                          ? Icons.shopping_bag
                          : Icons.shopping_bag_outlined,
                      size: 14,
                      color: kPrimaryColor,
                    ),
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
