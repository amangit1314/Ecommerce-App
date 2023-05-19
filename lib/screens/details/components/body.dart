import 'package:flutter/material.dart';
import 'package:soni_store_app/screens/details/components/product_description.dart';
import 'package:soni_store_app/screens/details/components/product_images.dart';
import 'package:soni_store_app/screens/details/components/rating_tile.dart';
import 'package:soni_store_app/screens/details/components/reviews_sheet.dart';
import 'package:soni_store_app/screens/details/components/top_rounded_container.dart';

import '../../../components/section_tile.dart';
import '../../../models/product.dart';
import '../../../utils/constants.dart';
import '../../../utils/size_config.dart';
import 'after_buy_now_sheet.dart';

// class Body extends StatefulWidget {
//   const Body({Key? key, required this.product}) : super(key: key);

//   final Product product;

//   @override
//   State<Body> createState() => _BodyState();
// }

// class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
//   late AnimationController bottomSheetAnimationController;

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     bottomSheetAnimationController.forward();
//   }

//   @override
//   void initState() {
//     super.initState();
//     bottomSheetAnimationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 500),
//       reverseDuration: const Duration(milliseconds: 500),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     return ListView(
//       children: [
//         ProductImages(product: widget.product),
//         TopRoundedContainer(
//           color: Colors.white,
//           child: Column(
//             children: [
//               ProductDescription(
//                 product: widget.product,
//                 pressOnSeeMore: () {},
//               ),
//               const RatingTile(),
//               Padding(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: getProportionateScreenWidth(20),
//                   vertical: 10,
//                 ),
//                 child: GestureDetector(
//                   onTap: () {
//                     showBottomSheet(
//                       enableDrag: false,
//                       context: context,
//                       builder: (index) {
//                         return BottomSheet(
//                           animationController: bottomSheetAnimationController,
//                           backgroundColor: Colors.grey[200],
//                           onClosing: () {},
//                           builder: (index) {
//                             return Padding(
//                               padding: const EdgeInsets.all(20.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: const [],
//                               ),
//                             );
//                           },
//                         );
//                       },
//                     );
//                   },
//                   child: Container(
//                     height: getProportionateScreenHeight(60),
//                     decoration: BoxDecoration(
//                       // border on top and bottom side
//                       border: Border(
//                         top: BorderSide(
//                           color: kPrimaryColor.withOpacity(.3),
//                           width: 1,
//                         ),
//                         bottom: BorderSide(
//                           color: kPrimaryColor.withOpacity(.3),
//                           width: 1,
//                         ),
//                       ),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Row(
//                           children: [
//                             const FaIcon(
//                               FontAwesomeIcons.starHalf,
//                               size: 12,
//                               color: kPrimaryColor,
//                             ),
//                             SizedBox(width: getProportionateScreenWidth(10)),
//                             const Text(
//                               "Reviews",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.w600,
//                                 color: kPrimaryColor,
//                               ),
//                             ),
//                           ],
//                         ),
//                         const Spacer(),
//                         const Icon(
//                           Icons.arrow_forward_ios,
//                           size: 12,
//                           color: kPrimaryColor,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(height: 10),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     child: SectionTitle(
//                       title: 'Similar Products',
//                       press: () {},
//                     ),
//                   ),
//                   SizedBox(height: getProportionateScreenHeight(15)),
//                   Container(
//                     height: 250,
//                     padding: const EdgeInsets.only(left: 20.0),
//                     child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: 6,
//                       itemBuilder: (context, index) {
//                         return GestureDetector(
//                           onTap: () {
//                             Navigator.of(context).push(
//                               MaterialPageRoute(
//                                 builder: (_) => DetailsScreen(
//                                   product: demoProducts[index],
//                                 ),
//                               ),
//                             );
//                           },
//                           child: Container(
//                             width: 170,
//                             margin: const EdgeInsets.only(right: 10),
//                             padding: const EdgeInsets.only(
//                               top: 8,
//                               left: 8,
//                               right: 8,
//                             ),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(15),
//                               border: Border.all(
//                                 color: kPrimaryColor.withOpacity(.2),
//                               ),
//                             ),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Container(
//                                   height: 148,
//                                   width: 170,
//                                   decoration: const BoxDecoration(
//                                     image: DecorationImage(
//                                       image: NetworkImage(
//                                         'https://picsum.photos/250?image=9',
//                                       ),
//                                       fit: BoxFit.cover,
//                                     ),
//                                     borderRadius: BorderRadius.all(
//                                       Radius.circular(10),
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(height: 8),
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 2.0),
//                                   child: Column(
//                                     children: [
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             'Category',
//                                             overflow: TextOverflow.ellipsis,
//                                             style: TextStyle(
//                                               color: Colors.grey.shade700,
//                                               fontSize: 10,
//                                               fontWeight: FontWeight.w400,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.start,
//                                         children: const [
//                                           Text(
//                                             'Macbook Air',
//                                             overflow: TextOverflow.ellipsis,
//                                             style: TextStyle(
//                                               color: Colors.black,
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.w600,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 const Padding(
//                                   padding: EdgeInsets.only(
//                                       right: 8.0, top: 4, bottom: 8),
//                                   child: Text(
//                                     '\$ 1000',
//                                     style: TextStyle(
//                                       fontSize: 12,
//                                       color: kPrimaryColor,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               Container(
//                 height: getProportionateScreenWidth(65),
//                 margin: const EdgeInsets.only(
//                     top: 15, left: 15, right: 15, bottom: 25),
//                 decoration: BoxDecoration(
//                   color: Colors.black,
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       width: getProportionateScreenWidth(width * .4),
//                       height: getProportionateScreenWidth(65),
//                       decoration: const BoxDecoration(
//                         color: Colors.black,
//                         borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(15),
//                           bottomLeft: Radius.circular(15),
//                         ),
//                       ),
//                       padding: EdgeInsets.only(
//                         left: SizeConfig.screenWidth * 0.05,
//                         right: SizeConfig.screenWidth * 0.05,
//                         bottom: getProportionateScreenHeight(9),
//                         top: getProportionateScreenHeight(9),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: const [
//                           Text(
//                             "\$ 12.5",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.w600,
//                               fontSize: 16,
//                             ),
//                           ),
//                           Text(
//                             "Unit price",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 12,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       height: getProportionateScreenWidth(65),
//                       width: getProportionateScreenWidth(width * .3),
//                       padding: EdgeInsets.only(
//                         bottom: getProportionateScreenHeight(2),
//                         top: getProportionateScreenHeight(2),
//                       ),
//                       decoration: const BoxDecoration(
//                         color: Colors.deepOrange,
//                         borderRadius: BorderRadius.only(
//                           topRight: Radius.circular(15),
//                           bottomRight: Radius.circular(15),
//                         ),
//                       ),
//                       child: TextButton(
//                         child: const Text(
//                           "Buy Now",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         onPressed: () {},
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

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
                              // onTap: () {
                              //   Navigator.of(context).push(
                              //     MaterialPageRoute(
                              //       builder: (_) => DetailsScreen(
                              //         product: demoProducts[index],
                              //       ),
                              //     ),
                              //   );
                              // },
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
                                                    fontWeight:
                                                        FontWeight.w600),
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
                ],
              ),
            ),
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
                    "\$ $price ",
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
                  // * show bottom sheet
                  showModalBottomSheet(
                    // backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) => AfterBuyNowButtonSheet(
                      product: product,
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
    // required this.widget,
    required this.width,
  });

  // final DetailFirebaseBody widget;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return TopRoundedContainer(
          color: const Color(0xFFF6F7F9),
          child: Column(),
        );
      },
    );
  }
}
