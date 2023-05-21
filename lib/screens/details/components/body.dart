// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soni_store_app/providers/providers.dart';
import 'package:soni_store_app/screens/details/components/product_description.dart';
import 'package:soni_store_app/screens/details/components/product_images.dart';
import 'package:soni_store_app/screens/details/components/rating_tile.dart';
import 'package:soni_store_app/screens/details/components/reviews_sheet.dart';
import 'package:soni_store_app/screens/details/components/top_rounded_container.dart';

import '../../../helper/stripe_helper.dart';
import '../../../models/order.dart';
import '../../../models/payment.dart';
import '../../../models/product.dart';
import '../../../utils/size_config.dart';
import '../../cart/cart_screen.dart';
import '../../home/home_screen.dart';
import 'after_buy_now_sheet.dart';

class DetailFirebaseBody extends StatefulWidget {
  const DetailFirebaseBody({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  State<DetailFirebaseBody> createState() => _DetailFirebaseBodyState();
}

class _DetailFirebaseBodyState extends State<DetailFirebaseBody>
    with SingleTickerProviderStateMixin {
  late AnimationController bottomSheetAnimationController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bottomSheetAnimationController.forward();
  }

  @override
  void initState() {
    super.initState();
    bottomSheetAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      reverseDuration: const Duration(milliseconds: 500),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        // * content
        ListView(
          children: [
            ProductImagesFirebase(product: widget.product),
            TopRoundedContainer(
              color: Colors.white,
              child: Column(
                children: [
                  // * product description
                  ProductDescription(
                    product: widget.product,
                    pressOnSeeMore: () {},
                  ),

                  // * reviews rating tile
                  const RatingTile(),

                  // * reviews
                  ReviewsSheet(
                    bottomSheetAnimationController:
                        bottomSheetAnimationController,
                  ),

                  // * similar items
                  // SimilarProducts(widget: widget),
                ],
              ),
            ),
            // * spacing
            SizedBox(
              height: getProportionateScreenHeight(120),
            ),
          ],
        ),

        // * button
        BuyNowButton(
          product: widget.product,
          width: width,
          widget: widget,
          price: widget.product.price.toString(),
        ),
      ],
    );
  }
}

// class SimilarProducts extends StatelessWidget {
//   const SimilarProducts({
//     super.key,
//     required this.widget,
//   });
//   final DetailFirebaseBody widget;
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const SizedBox(height: 10),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: SectionTitle(
//             title: 'Similar Products',
//             press: () {},
//           ),
//         ),
//         SizedBox(height: getProportionateScreenHeight(15)),
//         Container(
//           height: 250,
//           padding: const EdgeInsets.only(left: 20.0),
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: 6,
//             itemBuilder: (context, index) {
//               return GestureDetector(
//                 // onTap: () {
//                 //   Navigator.of(context).push(
//                 //     MaterialPageRoute(
//                 //       builder: (_) => DetailsScreen(
//                 //         product: demoProducts[index],
//                 //       ),
//                 //     ),
//                 //   );
//                 // },
//                 child: Container(
//                   width: 170,
//                   margin: const EdgeInsets.only(right: 10),
//                   padding: const EdgeInsets.only(
//                     top: 8,
//                     left: 8,
//                     right: 8,
//                   ),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(15),
//                     border: Border.all(
//                       color: kPrimaryColor.withOpacity(.2),
//                     ),
//                   ),
//                   child: FashionsCard(product: widget.product),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

class BuyNowButton extends StatelessWidget {
  const BuyNowButton({
    super.key,
    required this.width,
    required this.price,
    required this.widget,
    required this.product,
  });

  final double width;
  final DetailFirebaseBody widget;
  final String price;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: getProportionateScreenWidth(65),
        margin: const EdgeInsets.only(
          top: 15,
          left: 15,
          right: 15,
          bottom: 25,
        ),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: getProportionateScreenWidth(width * .4),
              height: getProportionateScreenWidth(65),
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
              ),
              padding: EdgeInsets.only(
                left: SizeConfig.screenWidth * 0.05,
                right: SizeConfig.screenWidth * 0.05,
                bottom: getProportionateScreenHeight(9),
                top: getProportionateScreenHeight(9),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "₹ $price ",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const Text(
                    "Unit price",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: getProportionateScreenWidth(65),
              width: getProportionateScreenWidth(width * .3),
              padding: EdgeInsets.only(
                bottom: getProportionateScreenHeight(2),
                top: getProportionateScreenHeight(2),
              ),
              decoration: const BoxDecoration(
                color: Colors.deepOrange,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: TextButton(
                child: const Text(
                  "Buy Now",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  final order = Order(
                    orderId: 'order_id',
                    uid: 'user_id',
                    productId: 'product_id',
                    orderedDate: DateTime.now(),
                    quantity: 1,
                    amount: 10.0,
                    address: 'Shipping address',
                    productImage: product.images.first,
                    orderStatus: 'Not Ordered',
                  );
                  // * show bottom sheet
                  showModalBottomSheet(
                    backgroundColor: const Color(0xFFF6F7F9),
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        topLeft: Radius.circular(40),
                      ),
                    ),
                    builder: (context) => AfterBuyNowButtonSheet(
                      product: product,
                      widget: widget,
                      width: width,
                      order: order,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddedWidget extends StatelessWidget {
  const AddedWidget({
    super.key,
    // required this.widget,
    required this.width,
    required this.price,
    this.order,
  });

  // final DetailFirebaseBody widget;
  final double width;
  final String price;
  final Order? order;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Column(
          // primary button with text continue shopping
          children: [
            Container(
              width: double.infinity,
              height: getProportionateScreenHeight(50),
              margin: const EdgeInsets.only(
                top: 45,
                left: 15,
                right: 15,
              ),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                height: getProportionateScreenWidth(65),
                width: getProportionateScreenWidth(width),
                padding: EdgeInsets.only(
                  bottom: getProportionateScreenHeight(2),
                  top: getProportionateScreenHeight(2),
                ),
                decoration: BoxDecoration(
                  color: Colors.deepOrange,
                  borderRadius: BorderRadius.circular(15),
                  //   bottomRight: Radius.circular(15),
                  // ),
                ),
                child: TextButton(
                    child: const Text(
                      "Continue Shopping",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      //  navigate to home with .push
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    }
                    // product: product,
                    // widget: widget
                    ),
              ),
            ),
            Container(
              width: double.infinity,
              height: getProportionateScreenHeight(50),
              margin: const EdgeInsets.only(
                top: 15,
                left: 15,
                right: 15,
                bottom: 25,
              ),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                height: getProportionateScreenWidth(65),
                width: getProportionateScreenWidth(width),
                padding: EdgeInsets.only(
                  bottom: getProportionateScreenHeight(2),
                  top: getProportionateScreenHeight(2),
                ),
                decoration: BoxDecoration(
                  color: Colors.deepOrange,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextButton(
                  child: const Text(
                    "Checkout",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () async {
                    await showPaymentDialog(context);
                    await StripeHelper.instance
                        .makePayment(price, context, order!);
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> showPaymentDialog(BuildContext context) async {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);

    // Show initial payment method dialog
    final PaymentMethod? selectedMethod = await showDialog<PaymentMethod>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Payment Method'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  userProvider.addPayment(
                    Payment(
                      id: 'payment_id',
                      uid: 'user_id',
                      paymentMethod: 'Cash',
                      paymentStatus: 'payment_status',
                      date: DateTime.now(),
                      amount: 0,
                    ),
                  );
                  Navigator.of(context).pop(PaymentMethod.cash);
                },
                child: const Text('Cash'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(PaymentMethod.online);
                },
                child: const Text('Online Payment'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(PaymentMethod.cancel);
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(PaymentMethod.goToCart);
                },
                child: const Text('Go to Cart'),
              ),
            ],
          ),
        );
      },
    );

    if (selectedMethod == PaymentMethod.cash) {
      // Show confirmation dialogs
      for (int i = 1; i <= 4; i++) {
        final bool confirmed = await showConfirmationDialog(context, i);
        if (!confirmed) {
          return; // User canceled
        }
      }

      // Make the payment using Stripe
      await StripeHelper.instance.makePayment(price, context, order!);
    } else if (selectedMethod == PaymentMethod.online) {
      // Implement online payment logic
      // ...
    } else if (selectedMethod == PaymentMethod.cancel) {
      // User canceled, do nothing
    } else if (selectedMethod == PaymentMethod.goToCart) {
      // Navigate to the cart screen

      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const CartScreen()),
      );
    }
  }

  Future<bool> showConfirmationDialog(BuildContext context, int step) async {
    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Confirmation'),
              content: Text('Step $step: Confirm payment?'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(false); // User canceled
                  },
                  child: const Text('No'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(true); // User confirmed
                  },
                  child: const Text('Yes'),
                ),
              ],
            );
          },
        ) ??
        false; // Default to false if dialog is dismissed
  }
}

enum PaymentMethod {
  cash,
  online,
  cancel,
  goToCart,
}
