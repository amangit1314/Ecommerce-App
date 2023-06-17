import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:soni_store_app/models/models.dart' as models;
import 'package:soni_store_app/utils/constants.dart';
import 'package:soni_store_app/utils/size_config.dart';

import '../../../components/rounded_icon_button.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    Key? key,
    required this.cart,
    required this.quantity,
    required this.onDecrease,
    required this.onIncrease,
  }) : super(key: key);

  final models.Product cart;
  final int quantity;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: getProportionateScreenWidth(85),
          child: AspectRatio(
            aspectRatio: 1,
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
        const SizedBox(width: 12),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cart.title,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 6),
            Text.rich(
              TextSpan(
                text: "\$${cart.price}",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: kPrimaryColor,
                    ),
                children: [
                  TextSpan(
                    text: " x",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  TextSpan(
                    text: " $quantity",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: kTextColor,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const Spacer(),
        Row(
          children: [
            RoundedIconBtn(
              icon: Icons.remove,
              showShadow: quantity == 1 ? false : true,
              press: onDecrease,
            ),
            SizedBox(width: getProportionateScreenWidth(8)),
            Text(
              quantity.toString(),
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: getProportionateScreenWidth(8)),
            RoundedIconBtn(
              icon: Icons.add,
              showShadow: true,
              press: onIncrease,
            ),
          ],
        ),
      ],
    );
  }
}
