import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soni_store_app/models/models.dart' as models;
import 'package:soni_store_app/providers/providers.dart';
import 'package:soni_store_app/utils/constants.dart';
import 'package:soni_store_app/utils/size_config.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final models.Product cart;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    final int quantity = cartProvider.totalCartItemQuantity;

    return Row(
      children: [
        SizedBox(
          width: getProportionateScreenWidth(88),
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(10)),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(cart.images[0]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cart.title,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.black, fontSize: 14),
              maxLines: 2,
            ),
            const SizedBox(height: 10),
            Text.rich(
              TextSpan(
                text: "\$${cart.price}",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: kPrimaryColor,
                ),
                children: [
                  TextSpan(
                    text: " x",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge, // Use appropriate text style
                  ),
                  TextSpan(
                    text: " $quantity",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge, // Use appropriate text style
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
