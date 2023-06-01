import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:soni_store_app/providers/providers.dart';
import 'package:soni_store_app/screens/cart/components/cart_card.dart';
import 'package:soni_store_app/utils/size_config.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
      ),
      child: Consumer2<CartProvider, AuthProvider>(
        builder: (context, cartProvider, authProvider, child) {
          return ListView.builder(
            itemCount: cartProvider.cartItems.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              // display every cart item from cartProvider
              child: Dismissible(
                key: Key(cartProvider.cartItems[index].id),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  setState(() {
                    cartProvider.cartItems.removeAt(index);
                  });
                  cartProvider.removeFromCart(
                    cartProvider.cartItems[index],
                    authProvider.user.uid,
                  );
                },
                background: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFE6E6),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Spacer(),
                      SvgPicture.asset("assets/icons/Trash.svg"),
                    ],
                  ),
                ),
                child: CartCard(
                  cart: cartProvider.cartItems[index],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
