import 'package:flutter/material.dart';
import 'package:soni_store_app/screens/details/components/after_buy_now_sheet.dart';

import '../../../models/models.dart';
import '../../../utils/size_config.dart';
import 'body.dart';

class BuyNowButton extends StatelessWidget {
  const BuyNowButton({
    Key? key,
    required this.width,
    required this.widget,
    required this.product,
  }) : super(key: key);

  final double width;
  final DetailFirebaseBody widget;

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 15,
      left: 15,
      right: 15,
      child: Container(
        height: getProportionateScreenWidth(65),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // * Black Part with the price
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
                    "₹ ${widget.product.price.toString()} ",
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

            // * Buy Now Orange Part of Button
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
                    fontWeight: FontWeight.w600,
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
