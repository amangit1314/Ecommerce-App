import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../models/product.dart';
import '../../../utils/constants.dart';
import '../../../utils/size_config.dart';
import '../../details/detail_screen.dart';

class ProductSearchScreenItemCard extends StatelessWidget {
  const ProductSearchScreenItemCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1,
    required this.productImage,
    this.productName = 'Gaming',
    this.color = Colors.white,
    required this.price,
    this.onTap,
    required this.product,
    required this.category,
  }) : super(key: key);

  final double width, aspectRetio;
  final String productImage;
  final String productName;
  final Product product;
  final String category;

  final Color color;
  final String price;

  final VoidCallback? onTap;
  final bool isTransparent = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => DetailsScreenFirebase(
              product: product,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(6),
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            width: 1,
            color: kPrimaryColor.withOpacity(.3),
          ),
        ),
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: width,
              height: getProportionateScreenHeight(95),
              decoration: BoxDecoration(
                color: color.withOpacity(.3),
                borderRadius: BorderRadius.circular(15),
                // border kPrimary COlor

                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    productImage,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0, top: 6, bottom: 2),
              child: Text(
                product.categories.firstWhere((element) => element == category),
                style: const TextStyle(
                  fontSize: 10,
                  color: kTextColor,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
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
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0, top: 2),
              child: Text(
                price,
                style: const TextStyle(
                  fontSize: 12,
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
