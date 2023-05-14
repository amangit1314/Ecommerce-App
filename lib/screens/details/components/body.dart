import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:soni_store_app/screens/details/components/color_dots.dart';
import 'package:soni_store_app/screens/details/components/product_description.dart';
import 'package:soni_store_app/screens/details/components/product_images.dart';
import 'package:soni_store_app/screens/details/components/top_rounded_container.dart';

import '../../../components/section_tile.dart';
import '../../../models/product.dart';
import '../../../resources/data/static_data.dart';
import '../../../utils/constants.dart';
import '../../../utils/size_config.dart';
import '../detail_screen.dart';

class Body extends StatefulWidget {
  final Product product;

  const Body({Key? key, required this.product}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
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
    final width = MediaQuery.of(context).size.width;
    return ListView(
      children: [
        ProductImages(product: widget.product),
        TopRoundedContainer(
          color: Colors.white,
          child: Column(
            children: [
              ProductDescription(
                product: widget.product,
                pressOnSeeMore: () {},
              ),
              const RatingTile(),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20),
                  vertical: 10,
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
                              FontAwesomeIcons.starHalf,
                              size: 12,
                              color: kPrimaryColor,
                            ),
                            SizedBox(width: getProportionateScreenWidth(10)),
                            const Text(
                              "Reviews",
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
              Column(
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
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => DetailsScreen(
                                  product: demoProducts[index],
                                ),
                              ),
                            );
                          },
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 148,
                                  width: 170,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        'https://picsum.photos/250?image=9',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 2.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Category',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Colors.grey.shade700,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: const [
                                          Text(
                                            'Macbook Air',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          // const SizedBox(width: 6),
                                          // const Spacer(),
                                          // ClipRRect(
                                          //   borderRadius: BorderRadius.circular(20),
                                          //   child: GestureDetector(
                                          //     onTap:
                                          //         //onTap ??
                                          //         () {
                                          //       // add to cart with provider
                                          //     },
                                          //     child: Container(
                                          //       height: 40,
                                          //       width: 40,
                                          //       color: kPrimaryColor.withOpacity(0.1),
                                          //       child: const Icon(
                                          //         // Icons.shopping_bag_outlined,
                                          //         // addedToCart!
                                          //         //     ? Icons.shopping_bag
                                          //         //     :
                                          //         Icons.shopping_bag_outlined,
                                          //         size: 14,
                                          //         color: kPrimaryColor,
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(
                                      right: 8.0, top: 4, bottom: 8),
                                  child: Text(
                                    '\$ 1000',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: kPrimaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: TopRoundedContainer(
                  color: const Color(0xFFF6F7F9),
                  child: Column(
                    children: [
                      ColorDots(product: widget.product),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 15.0),
                        child: Divider(
                          color: Colors.grey.shade300,
                          height: 5,
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$ 25.00',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 20),
                              padding: const EdgeInsets.all(7),
                              width: SizeConfig.screenWidth * 0.6,
                              decoration: BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Add to cart',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                  ),
                                  IconButton(
                                    icon: const FaIcon(
                                      FontAwesomeIcons.bagShopping,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: getProportionateScreenWidth(65),
                        margin: const EdgeInsets.only(
                            left: 15, right: 15, bottom: 25),
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
                                children: const [
                                  Text(
                                    "\$ 12.5",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
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
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class RatingTile extends StatelessWidget {
  const RatingTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text.rich(
                TextSpan(
                  text: '4.4 ',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  children: [
                    TextSpan(
                      text: '/5',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const Text(
                'Based on 250 reviews',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: const [
                  FaIcon(
                    FontAwesomeIcons.solidStar,
                    color: Colors.amber,
                    size: 18,
                  ),
                  FaIcon(
                    FontAwesomeIcons.solidStar,
                    color: Colors.amber,
                    size: 18,
                  ),
                  FaIcon(
                    FontAwesomeIcons.solidStar,
                    color: Colors.amber,
                    size: 18,
                  ),
                  FaIcon(
                    FontAwesomeIcons.solidStar,
                    color: Colors.amber,
                    size: 18,
                  ),
                  FaIcon(
                    FontAwesomeIcons.solidStarHalf,
                    color: Colors.amber,
                    size: 18,
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: [
              Row(
                children: [
                  Row(
                    children: const [
                      Text(
                        '5',
                        style: TextStyle(
                          letterSpacing: 5,
                          fontSize: 8,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        'Star',
                        style: TextStyle(
                          fontSize: 8,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: getProportionateScreenWidth(5)),
                  Container(
                    height: 5,
                    width: getProportionateScreenWidth(100),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade700,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 5,
                          width: getProportionateScreenWidth(50),
                          decoration: const BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Row(
                    children: const [
                      Text(
                        '4',
                        style: TextStyle(
                          fontSize: 8,
                          letterSpacing: 5,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        'Star',
                        style: TextStyle(
                          fontSize: 8,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: getProportionateScreenWidth(5)),
                  Container(
                    height: 5,
                    width: getProportionateScreenWidth(100),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade700,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 5,
                          width: getProportionateScreenWidth(35),
                          decoration: const BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Row(
                    children: const [
                      Text(
                        '3',
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                          letterSpacing: 5,
                        ),
                      ),
                      Text(
                        'Star',
                        style: TextStyle(
                          fontSize: 8,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: getProportionateScreenWidth(5)),
                  Container(
                    height: 5,
                    width: getProportionateScreenWidth(100),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade700,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 5,
                          width: getProportionateScreenWidth(0),
                          decoration: const BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Row(
                    children: const [
                      Text(
                        '2',
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                          letterSpacing: 5,
                        ),
                      ),
                      Text(
                        'Star',
                        style: TextStyle(
                          fontSize: 8,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: getProportionateScreenWidth(5)),
                  Container(
                    height: 5,
                    width: getProportionateScreenWidth(100),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade700,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 5,
                          width: getProportionateScreenWidth(5),
                          decoration: const BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Row(
                    children: const [
                      Text(
                        '1',
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                          letterSpacing: 5,
                        ),
                      ),
                      Text(
                        'Star',
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: getProportionateScreenWidth(5)),
                  Container(
                    height: 5,
                    width: getProportionateScreenWidth(100),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade700,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 5,
                          width: getProportionateScreenWidth(5),
                          decoration: const BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DetailFirebaseBody extends StatefulWidget {
  final Product product;

  const DetailFirebaseBody({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<DetailFirebaseBody> createState() => _DetailFirebaseBodyState();
}

class _DetailFirebaseBodyState extends State<DetailFirebaseBody>
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
    final width = MediaQuery.of(context).size.width;
    return ListView(
      children: [
        ProductImagesFirebase(
          product: widget.product,
        ),
        TopRoundedContainer(
          color: Colors.white,
          child: Column(
            children: [
              ProductDescription(
                product: widget.product,
                pressOnSeeMore: () {},
              ),
              const RatingTile(),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20),
                  vertical: 10,
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
                              FontAwesomeIcons.starHalf,
                              size: 12,
                              color: kPrimaryColor,
                            ),
                            SizedBox(width: getProportionateScreenWidth(10)),
                            const Text(
                              "Reviews",
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
              Column(
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
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => DetailsScreen(
                                  product: demoProducts[index],
                                ),
                              ),
                            );
                          },
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 148,
                                  width: 170,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        'https://picsum.photos/250?image=9',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 2.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Category',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Colors.grey.shade700,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: const [
                                          Text(
                                            'Macbook Air',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(
                                      right: 8.0, top: 4, bottom: 8),
                                  child: Text(
                                    '\$ 1000',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: kPrimaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: TopRoundedContainer(
                  color: const Color(0xFFF6F7F9),
                  child: Column(
                    children: [
                      ColorDots(product: widget.product),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 15.0),
                        child: Divider(
                          color: Colors.grey.shade300,
                          height: 5,
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$ 25.00',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 20),
                              padding: const EdgeInsets.all(7),
                              width: SizeConfig.screenWidth * 0.6,
                              decoration: BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Add to cart',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                  ),
                                  IconButton(
                                    icon: const FaIcon(
                                      FontAwesomeIcons.bagShopping,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: getProportionateScreenWidth(65),
                        margin: const EdgeInsets.only(
                            left: 15, right: 15, bottom: 25),
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
                                children: const [
                                  Text(
                                    "\$ 12.5",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
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
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
