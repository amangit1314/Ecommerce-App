// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:soni_store_app/providers/providers.dart';
import 'package:soni_store_app/screens/details/components/product_description.dart';
import 'package:soni_store_app/screens/details/components/product_images.dart';
import 'package:soni_store_app/screens/details/components/rating_tile.dart';
import 'package:soni_store_app/screens/details/components/reviews_sheet.dart';
import 'package:soni_store_app/screens/details/components/top_rounded_container.dart';

import '../../../components/section_tile.dart';
import '../../../models/order.dart';
import '../../../models/product.dart';
import '../../../utils/constants.dart';
import '../../../utils/size_config.dart';
import '../../cart/cart_screen.dart';
import '../../home/components/fashion/fashions.dart';
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
                    product: widget.product,
                    image: widget.product.images.first,
                  ),

                  // * similar items
                  // SimilarProducts(product: widget.product),
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

class BuyNowButton extends StatelessWidget {
  const BuyNowButton({
    Key? key,
    required this.width,
    required this.price,
    required this.widget,
    required this.product,
  }) : super(key: key);

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
                      widget: widget,
                      width: width,
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
    required this.widget,
    required this.width,
    required this.price,
    required this.product,
    required this.quantity,
  });

  final double width;
  final String price;
  final Product product;
  final AfterBuyNowButtonSheet widget;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Column(
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
                color: kPrimaryColor,
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
                    "Continue Shopping",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  },
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
                color: kPrimaryColor,
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
                    await showPaymentDialog(context, product);
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> showPaymentDialog(BuildContext context, Product product) async {
    CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: false);
    OrderProvider orderProvider =
        Provider.of<OrderProvider>(context, listen: false);
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);

    bool success = false;
    String orderStatus = 'Processing';

    Order order = Order(
      orderId: DateTime.now().toString(),
      uid: userProvider.getUser.uid,
      orderedDate: DateTime.now(),
      productId: product.id,
      amount: double.parse(price),
      productImage: product.images.first,
      // address: userProvider.getUser.addresses!.first ?? 'No address found',
      quantity: quantity,
      orderStatus: orderStatus,
    );

    try {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Center(
              child: Text(
                'Checkout With',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor,
                    ),
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () async {
                    await orderProvider
                        .addOrder(
                      order,
                      userProvider.getUser.uid,
                    )
                        .then((value) {
                      success = true;
                      Navigator.pop(context);
                    }).catchError((e) {
                      success = false;
                      Navigator.pop(context);
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    height: getProportionateScreenHeight(50),
                    margin: const EdgeInsets.only(
                      top: 15,
                      left: 15,
                      right: 15,
                    ),
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        'Cash',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    Get.snackbar(
                      'Information ℹ',
                      'This functionality is yet to be implemented! 🙏',
                      backgroundColor: Colors.yellow,
                      colorText: Colors.black,
                      snackPosition: SnackPosition.BOTTOM,
                    );

                    // if (order != null) {
                    //   await orderProvider.addOrder(
                    //       order!, userProvider.getUser.uid);
                    //   success = true;
                    //   Navigator.pop(context);
                    // }
                  },
                  child: Container(
                    width: double.infinity,
                    height: getProportionateScreenHeight(50),
                    margin: const EdgeInsets.only(
                      top: 15,
                      left: 15,
                      right: 15,
                    ),
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        'Online Payment',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    cartProvider.addToCart(product);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const CartScreen(),
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: getProportionateScreenHeight(50),
                    margin: const EdgeInsets.only(
                      top: 15,
                      left: 15,
                      right: 15,
                    ),
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        'Go to Cart',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: double.infinity,
                    height: getProportionateScreenHeight(50),
                    margin: const EdgeInsets.only(
                      top: 15,
                      left: 15,
                      right: 15,
                    ),
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        'Cancel',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    } catch (e) {
      success = false;
      debugPrint('Error occurred while adding the order: $e');
    }

    if (success) {
      Get.snackbar(
        'Success',
        'Order added successfully! 🎉',
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      Get.snackbar(
        'Error',
        'Failed to add order! ❗⚠',
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
      );
    }
  }
}

class SimilarProducts extends StatelessWidget {
  const SimilarProducts({
    super.key,
    required this.widget,
  });
  final DetailFirebaseBody widget;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SectionTitle(
            title: 'Similar Products',
            press: () {},
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(15)),
        Container(
          height: 250,
          padding: const EdgeInsets.only(left: 20.0),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 6,
            itemBuilder: (context, index) {
              return GestureDetector(
                child: Container(
                  width: 170,
                  margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.only(
                    top: 8,
                    left: 8,
                    right: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: kPrimaryColor.withOpacity(.2),
                    ),
                  ),
                  child: FashionsCard(product: widget.product),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
