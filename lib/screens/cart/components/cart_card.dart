import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soni_store_app/models/product.dart'; // Import the correct product model
import 'package:soni_store_app/providers/cart_provider.dart';
import 'package:soni_store_app/utils/size_config.dart';

import '../../../utils/constants.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Product cart;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    // Check if the product is already in the cartItems list
    final existingProduct = cartProvider.cartItems.firstWhere(
      (product) => product.id == cart.id,
      orElse: () {
        return Product(
          id: cart.id,
          title: cart.title, // Include the title when creating a new product
          price: cart.price, images: [],
          quantity: 1,
        );
      },
    );

    // Calculate the quantity
    final int quantity = existingProduct.quantity;

    return Row(
      children: [
        SizedBox(
          width: 88,
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
              existingProduct.title, // Use the title from existingProduct
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.black, fontSize: 14),
              maxLines: 2,
            ),
            const SizedBox(height: 10),
            Text.rich(
              TextSpan(
                text:
                    "\$${existingProduct.price}", // Use the price from existingProduct
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: kPrimaryColor,
                ),
                children: [
                  TextSpan(
                    text: " x ",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  TextSpan(
                    text: " x $quantity",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.w600,
                        ),
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
