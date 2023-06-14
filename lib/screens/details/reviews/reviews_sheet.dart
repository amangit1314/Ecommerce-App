import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:soni_store_app/screens/details/components/rating_tile.dart';
import 'package:soni_store_app/screens/details/reviews/review_item_tile.dart';

import '../../../models/models.dart';
import '../../../utils/constants.dart';
import '../../../utils/size_config.dart';

class ReviewsSheet extends StatelessWidget {
  const ReviewsSheet({
    Key? key,
    required this.product,
    required this.image,
  }) : super(key: key);

  final Product product;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
        vertical: 10,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ReviewsScreen(
                product: product,
              ),
            ),
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
                      color: kPrimaryColor,
                    ),
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
    );
  }
}

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reviews'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // * rating tile
            RatingTile(
              rating: product.rating.toString(),
            ),

            // * reviews list section header
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                "Reviews",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: kPrimaryColor,
                ),
              ),
            ),

            // * reviews list
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(15),
              itemCount: 5,
              itemBuilder: (context, index) {
                return const ReviewItemTile();
              },
            ),
          ],
        ),
      ),
    );
  }
}
