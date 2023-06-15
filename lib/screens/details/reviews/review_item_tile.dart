import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../models/review.dart';
import '../../../utils/constants.dart';
import '../../../utils/size_config.dart';

class ReviewItemTile extends StatelessWidget {
  final Review review;

  const ReviewItemTile({Key? key, required this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final yellowStarIcon = FaIcon(
      FontAwesomeIcons.solidStar,
      size: getProportionateScreenHeight(15),
      color: Colors.yellow.shade500,
    );

    final grayStarIcon = FaIcon(
      FontAwesomeIcons.star,
      size: getProportionateScreenHeight(15),
      color: Colors.grey,
    );

    final starRatingIcons = List<Widget>.generate(
      5,
      (index) => index < review.stars ? yellowStarIcon : grayStarIcon,
    );

    return Container(
      margin: const EdgeInsets.all(5.0),
      height: getProportionateScreenHeight(167),
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(15),
        // border
        border: Border.all(
          color: kPrimaryColor.withOpacity(0.7),
          width: getProportionateScreenWidth(1),
        ),
        // shadow
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.7),
            spreadRadius: getProportionateScreenWidth(1),
            blurRadius: getProportionateScreenWidth(1),
          ),
        ],
      ),
      child: Column(
        children: [
          // row with circle avatar, name, time, stars
          Padding(
            padding: EdgeInsets.all(
              getProportionateScreenWidth(15),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: getProportionateScreenWidth(20),
                  backgroundColor: Colors.white54,
                  child: CircleAvatar(
                    radius: getProportionateScreenWidth(20),
                    backgroundImage: NetworkImage(
                      review.reviewerPic.isNotEmpty
                          ? review.reviewerPic
                          : 'https://firebasestorage.googleapis.com/v0/b/tokoto-ecommerce-app.appspot.com/o/features%2F4.jpg?alt=media&token=5c5a4bbe-4620-4c16-ae8a-7716093e8d12',
                    ),
                  ),
                ),
                SizedBox(width: getProportionateScreenWidth(10)),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      review.reviewerName,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    SizedBox(width: getProportionateScreenWidth(5)),
                    Text(
                      review.when.substring(0, 4),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                const Spacer(),
                Row(children: starRatingIcons),
              ],
            ),
          ),

          // quoted text 4 line
          Padding(
            padding: EdgeInsets.only(
              left: getProportionateScreenWidth(15),
              right: getProportionateScreenWidth(15),
              bottom: getProportionateScreenHeight(15),
            ),
            child: Text(
              review.comment,
              maxLines: 4,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}
