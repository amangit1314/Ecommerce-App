import 'package:flutter/material.dart';
import 'package:soni_store_app/screens/details/components/product_description.dart';
import 'package:soni_store_app/screens/details/components/rating_tile.dart';
import 'package:soni_store_app/screens/details/components/top_rounded_container.dart';

import '../../../models/models.dart';
import '../../../utils/size_config.dart';
import '../reviews/reviews_sheet.dart';
import '../similarProducts/similar_products.dart';
import 'buy_now_button.dart';
import 'custom_app_bar.dart';
import 'product_images.dart';

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
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Stack(
            children: [
              ProductImagesFirebase(product: widget.product),
              CustomAppBar(
                rating: widget.product.rating,
                color: Colors.transparent,
              ),
            ],
          ),
        ),
        Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 200), // Adjust the height as needed
                    TopRoundedContainer(
                      color: Colors.white,
                      child: Column(
                        children: [
                          ProductDescription(
                            product: widget.product,
                            pressOnSeeMore: () {},
                          ),
                          RatingTile(
                            rating: widget.product.rating.toString(),
                          ),
                          ReviewsSheet(
                            bottomSheetAnimationController:
                                bottomSheetAnimationController,
                            product: widget.product,
                            image: widget.product.images.first,
                          ),
                          SimilarProducts(widget: widget),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(120)),
          ],
        ),
        BuyNowButton(
          product: widget.product,
          width: width,
          widget: widget,
        ),
      ],
    );
  }
}
