import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soni_store_app/screens/details/components/body.dart';
import 'package:soni_store_app/screens/details/components/color_dots.dart';
import 'package:soni_store_app/screens/details/components/size_dots.dart';

import '../../../components/rounded_icon_button.dart';
import '../../../providers/providers.dart';
import '../../../utils/size_config.dart';
import 'checkout_button_alert_box.dart';

class AfterBuyNowButtonSheet extends StatefulWidget {
  const AfterBuyNowButtonSheet({
    Key? key,
    required this.widget,
    required this.width,
  }) : super(key: key);

  final DetailFirebaseBody widget;
  final double width;

  @override
  State<AfterBuyNowButtonSheet> createState() => _AfterBuyNowButtonSheetState();
}

class _AfterBuyNowButtonSheetState extends State<AfterBuyNowButtonSheet> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        final productProvider =
            Provider.of<ProductProvider>(context, listen: false);
        productProvider.setProduct(widget.widget.product);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<ProductProvider, AuthProvider, OrderProvider>(
      builder: (context, productProvider, authProvider, orderProvider, _) {
        final int totalAmount = productProvider.totalPrice;
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 30,
                left: 15.0,
                right: 15.0,
                bottom: 11.0,
              ),
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
                            .copyWith(fontSize: 12),
                      ),
                      Text(
                        '₹ ${widget.widget.product.price}',
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
                            .copyWith(fontSize: 12),
                      ),
                      Row(
                        children: [
                          RoundedIconBtn(
                            icon: Icons.remove,
                            press: () {
                              productProvider.decreaseQuantity();
                            },
                          ),
                          SizedBox(width: getProportionateScreenWidth(8)),
                          Text(
                            productProvider.quantity.toString(),
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
                              productProvider.increaseQuantity();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Divider(
                color: Colors.grey.shade300,
                height: 5,
                thickness: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 15.0,
                right: 15.0,
                top: 15.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      "Select Color",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 12),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: ColorDots(
                      product: widget.widget.product,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 15.0,
                right: 15.0,
                top: 10.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      "Select Size",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 12),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: SizeDots(
                      product: widget.widget.product, oid: '',
                      // uid: authProvider.user.uid,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: getProportionateScreenWidth(65),
              margin: const EdgeInsets.only(
                left: 18,
                top: 23,
                right: 18,
                bottom: 23,
              ),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: getProportionateScreenWidth(widget.width * .4),
                    height: getProportionateScreenWidth(70),
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
                          "₹ $totalAmount",
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
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: const Color(0xFFF6F7F9),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(40),
                              topLeft: Radius.circular(40),
                            ),
                          ),
                          builder: (context) {
                            return DraggableScrollableSheet(
                              expand: false,
                              initialChildSize: 0.5,
                              maxChildSize: 0.9,
                              builder: (context, scrollController) {
                                return SingleChildScrollView(
                                  controller: scrollController,
                                  child: CheckoutButtonAlertBox(
                                    size: productProvider.selectedSize,
                                    color: productProvider.selectedColor,
                                    price:
                                        productProvider.totalPrice.toString(),
                                    width: MediaQuery.of(context).size.width,
                                    widget: widget,
                                    productId: productProvider.id,
                                    quantity: productProvider.quantity,
                                    userId: authProvider.user.uid,
                                    productImage:
                                        widget.widget.product.images.first,
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
