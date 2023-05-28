import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:soni_store_app/providers/cart_provider.dart';
import 'package:soni_store_app/screens/details/components/product_details_sheet.dart';

import '../../../models/product.dart';
import '../../../utils/size_config.dart';
import '../address/shipping_address_sheet.dart';

class ProductDescription extends StatefulWidget {
  const ProductDescription({
    Key? key,
    required this.product,
    required this.pressOnSeeMore,
    this.isFav,
  }) : super(key: key);

  final Product product;
  final GestureTapCallback pressOnSeeMore;
  final bool? isFav;

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription>
    with SingleTickerProviderStateMixin {
  late AnimationController bottomSheetAnimationController;

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
  void didChangeDependencies() {
    super.didChangeDependencies();
    bottomSheetAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              right: getProportionateScreenWidth(20),
              left: getProportionateScreenWidth(20),
              bottom: getProportionateScreenHeight(15),
            ),
            child: Text(
              widget.product.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/Star Icon.svg",
                            height: getProportionateScreenHeight(14),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            widget.product.rating.toString(),
                            style: TextStyle(
                              fontSize: getProportionateScreenHeight(14),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      ' ( 126 Reviews )',
                      style: TextStyle(
                        fontSize: getProportionateScreenHeight(12),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Consumer<CartProvider>(
                  builder: (context, cartProvider, _) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.product.isFavourite =
                              !widget.product.isFavourite;
                        });

                        cartProvider.addToCart(widget.product);
                      },
                      child: Container(
                        padding:
                            EdgeInsets.all(getProportionateScreenWidth(15)),
                        width: getProportionateScreenWidth(64),
                        decoration: BoxDecoration(
                          color: widget.product.isFavourite
                              ? const Color(0xFFFFE6E6)
                              : const Color(0xFFF5F6F9),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          ),
                        ),
                        child: SvgPicture.asset(
                          "assets/icons/Cart Icon.svg",
                          colorFilter: ColorFilter.mode(
                              widget.product.isFavourite
                                  ? const Color(0xFFFF4848)
                                  : const Color(0xFFDBDEE4),
                              BlendMode.srcIn),
                          height: getProportionateScreenWidth(16),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              left: getProportionateScreenWidth(20),
              right: getProportionateScreenWidth(64),
            ),
            child: Text(
              widget.product.description,
              maxLines: 3,
            ),
          ),
          ProductDetailsSheet(
            bottomSheetAnimationController: bottomSheetAnimationController,
            widget: widget,
          ),
          ShippingAddressSheet(
            bottomSheetAnimationController: bottomSheetAnimationController,
          )
        ],
      ),
    );
  }
}
