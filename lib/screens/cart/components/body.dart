import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:soni_store_app/models/models.dart' as models;
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
      padding: EdgeInsets.only(
        left: getProportionateScreenWidth(20),
        right: getProportionateScreenWidth(20),
        top: getProportionateScreenWidth(20),
        bottom: getProportionateScreenWidth(20),
      ),
      child: Consumer2<CartProvider, AuthProvider>(
        builder: (context, cartProvider, authProvider, child) {
          return FutureBuilder<List<models.Product>>(
            future: cartProvider.getCartItems(authProvider.user.uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return const Center(child: Text('Something went wrong'));
              }

              List<models.Product> cartItems = snapshot.data ?? [];

              if (cartItems.isEmpty) {
                return const Center(child: Text('Your cart is empty'));
              }

              // Filter cartItems to remove items with the same title
              Set<String> uniqueTitles = {};
              List<models.Product> uniqueCartItems = [];
              List<int> cartItemQuantities = [];

              for (var i = 0; i < cartItems.length; i++) {
                final cartItem = cartItems[i];
                if (!uniqueTitles.contains(cartItem.title)) {
                  uniqueTitles.add(cartItem.title);
                  uniqueCartItems.add(cartItem);
                  cartItemQuantities.add(1);
                } else {
                  final index = uniqueCartItems
                      .indexWhere((item) => item.title == cartItem.title);
                  cartItemQuantities[index] += 1;
                }
              }

              return ListView.separated(
                itemCount: uniqueCartItems.length,
                separatorBuilder: (context, index) {
                  return SizedBox(height: getProportionateScreenHeight(15));
                },
                itemBuilder: (context, index) {
                  final cartItem = uniqueCartItems[index];
                  final quantity = cartItemQuantities[index];
                  return Dismissible(
                    key: Key(cartItem.id),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) async {
                      await cartProvider.removeFromCart(
                          cartItem, authProvider.user.uid);
                      setState(() {
                        cartItems.removeWhere(
                            (item) => item.title == cartItem.title);
                        uniqueCartItems.removeAt(index);
                        cartItemQuantities.removeAt(index);
                      });
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
                      cart: cartItem,
                      quantity: quantity,
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
