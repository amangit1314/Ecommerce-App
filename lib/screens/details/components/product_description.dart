import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:soni_store_app/providers/cart_provider.dart';

import '../../../models/product.dart';
import '../../../utils/constants.dart';
import '../../../utils/size_config.dart';

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
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20),
              vertical: getProportionateScreenHeight(15),
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
                            '4.4',
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
                child:
                    Consumer<CartProvider>(builder: (context, cartProvider, _) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.product.isFavourite =
                            !widget.product.isFavourite;
                      });
                      // add this product to cart using provider
                      cartProvider.addItemCart(widget.product);
                    },
                    child: Container(
                      padding: EdgeInsets.all(getProportionateScreenWidth(15)),
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
                        color: widget.product.isFavourite
                            ? const Color(0xFFFF4848)
                            : const Color(0xFFDBDEE4),
                        height: getProportionateScreenWidth(16),
                      ),
                    ),
                  );
                }),
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
          Padding(
            padding: EdgeInsets.only(
              left: getProportionateScreenWidth(20),
              right: getProportionateScreenWidth(20),
              top: 10,
            ),
            child: GestureDetector(
              onTap: () {
                showBottomSheet(
                  enableDrag: false,
                  context: context,
                  builder: (index) {
                    return BottomSheet(
                      animationController: bottomSheetAnimationController,
                      backgroundColor: Colors.grey[200],
                      onClosing: () {},
                      builder: (index) {
                        return Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: getProportionateScreenHeight(30),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Product Details',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge),
                                  const Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: const FaIcon(
                                      FontAwesomeIcons.circleXmark,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: getProportionateScreenHeight(10),
                              ),
                              // Container(
                              //   height: 40,
                              //   width: double.infinity,
                              //   decoration: BoxDecoration(
                              //     color: Colors.grey[300],
                              //     borderRadius: BorderRadius.circular(10),
                              //     image: const DecorationImage(
                              //       image: AssetImage('assets/images/'),
                              //     ),
                              //   ),
                              // ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Story',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    widget.product.description,
                                    maxLines: 3,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: getProportionateScreenHeight(10),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Details',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        children: const [
                                          Text('• '),
                                          Text(' PS4 Gaming Control'),
                                        ],
                                      ),
                                      Row(
                                        children: const [
                                          Text('• '),
                                          Text(' PS4 Gaming Control'),
                                        ],
                                      ),
                                      Row(
                                        children: const [
                                          Text('• '),
                                          Text(' PS4 Gaming Control'),
                                        ],
                                      ),
                                      Row(
                                        children: const [
                                          Text('• '),
                                          Text(' PS4 Gaming Control'),
                                        ],
                                      ),
                                      Row(
                                        children: const [
                                          Text('• '),
                                          Text(' PS4 Gaming Control'),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: getProportionateScreenHeight(10),
                              ),
                              Text(
                                'Style',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: getProportionateScreenHeight(10),
                              ),
                              Text(
                                'Design',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: getProportionateScreenHeight(10),
                              ),
                              Text(
                                'Fabric',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              },
              child: Container(
                height: getProportionateScreenHeight(60),
                decoration: BoxDecoration(
                  // border on top and bottom side
                  border: Border(
                    top: BorderSide(
                      color: kPrimaryColor.withOpacity(.3),
                      width: 1,
                    ),
                    bottom: BorderSide(
                      color: kPrimaryColor.withOpacity(.3),
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.wallet,
                          size: 12,
                          color: kPrimaryColor,
                        ),
                        SizedBox(width: getProportionateScreenWidth(10)),
                        const Text(
                          "Product Details",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: kPrimaryColor),
                        ),
                      ],
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: kPrimaryColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20),
              // vertical: 10,
            ),
            child: GestureDetector(
              onTap: () {
                showBottomSheet(
                  enableDrag: false,
                  context: context,
                  builder: (index) {
                    return BottomSheet(
                      animationController: bottomSheetAnimationController,
                      backgroundColor: Colors.grey[200],
                      onClosing: () {},
                      builder: (index) {
                        return Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [],
                          ),
                        );
                      },
                    );
                  },
                );
              },
              child: Container(
                height: getProportionateScreenHeight(60),
                decoration: BoxDecoration(
                  // border on top and bottom side
                  border: Border(
                    top: BorderSide(
                      color: kPrimaryColor.withOpacity(.3),
                      width: 1,
                    ),
                    bottom: BorderSide(
                      color: kPrimaryColor.withOpacity(.3),
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.truckDroplet,
                          size: 12,
                          color: kPrimaryColor,
                        ),
                        SizedBox(width: getProportionateScreenWidth(10)),
                        const Text(
                          "Shipping Address",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: kPrimaryColor),
                        ),
                      ],
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: kPrimaryColor,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
