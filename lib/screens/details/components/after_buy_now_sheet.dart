import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soni_store_app/providers/product_provider.dart';
import 'package:soni_store_app/screens/details/components/body.dart';
import 'package:soni_store_app/screens/details/components/color_dots.dart';
import 'package:soni_store_app/screens/details/components/size_dots.dart';

import '../../../components/rounded_icon_button.dart';
import '../../../models/order.dart';
import '../../../models/product.dart';
import '../../../utils/size_config.dart';

class AfterBuyNowButtonSheet extends StatefulWidget {
  const AfterBuyNowButtonSheet({
    Key? key,
    required this.widget,
    required this.width,
    required this.order,
    required this.product,
  }) : super(key: key);

  final DetailFirebaseBody widget;
  final double width;
  final Order order;
  final Product product;

  @override
  State<AfterBuyNowButtonSheet> createState() => _AfterBuyNowButtonSheetState();
}

class _AfterBuyNowButtonSheetState extends State<AfterBuyNowButtonSheet> {
  int quantity = 1;

  // function to calculate total price
  int calculateTotalPrice(String price) {
    int totalPrice = 0;
    totalPrice = int.parse(price) * quantity;
    return totalPrice;
  }

  int totalPrice(int price) {
    int totalPrice = 0;
    totalPrice = price * quantity;
    return totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Consumer<ProductProvider>(
          builder: (context, productProvider, _) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 30, left: 15.0, right: 15.0, bottom: 15.0),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Unit price",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  fontSize: 12,
                                ),
                          ),
                          Text(
                            '₹ ${widget.product.price}',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Quantity",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  fontSize: 12,
                                ),
                          ),
                          Row(
                            children: [
                              RoundedIconBtn(
                                icon: Icons.remove,
                                press: () {
                                  if (quantity > 1) {
                                    // Decrease the quantity
                                    setState(() {
                                      quantity--;
                                    });
                                  }
                                },
                              ),
                              SizedBox(width: getProportionateScreenWidth(8)),
                              Text(
                                quantity.toString(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: getProportionateScreenWidth(8)),
                              RoundedIconBtn(
                                icon: Icons.add,
                                showShadow: true,
                                press: () {
                                  // Increase the quantity
                                  setState(() {
                                    quantity++;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // *
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Divider(
                    color: Colors.grey.shade300,
                    height: 5,
                    thickness: 1,
                  ),
                ),

                // * select color
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 15.0, right: 15.0, top: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          "Select Color",
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontSize: 12,
                                  ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: ColorDots(product: widget.widget.product),
                      ),
                    ],
                  ),
                ),

                // * select size
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 15.0, right: 15.0, top: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          "Select Size",
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontSize: 12,
                                  ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: SizeDots(product: widget.widget.product),
                      ),
                    ],
                  ),
                ),

                // * button
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: getProportionateScreenWidth(65),
                    margin: const EdgeInsets.only(
                        left: 15, top: 10, right: 15, bottom: 25),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: getProportionateScreenWidth(widget.width * .4),
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
                                "₹ ${totalPrice(widget.product.price).toString()}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              const Text(
                                "Total price",
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
                          width: getProportionateScreenWidth(widget.width * .3),
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
                              "Checkout",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              // show model sheet with a image and two button of continue shopping and checkout
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: const Color(0xFFF6F7F9),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(40),
                                    topLeft: Radius.circular(40),
                                  ),
                                ),
                                builder: (context) => DraggableScrollableSheet(
                                  expand: false,
                                  initialChildSize: 0.5,
                                  maxChildSize: 0.9,
                                  builder: (context, scrollController) {
                                    return SingleChildScrollView(
                                      controller: scrollController,
                                      child: AddedWidget(
                                        order: widget.order,
                                        price: totalPrice(widget.product.price)
                                            .toString(),
                                        width:
                                            MediaQuery.of(context).size.width,
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
