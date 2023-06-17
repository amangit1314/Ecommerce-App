import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../utils/size_config.dart';

class RatingTile extends StatelessWidget {
  final String rating;

  const RatingTile({Key? key, required this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  text: rating,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  children: const [
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
              const SizedBox(height: 12),
              const Text(
                'Based on 250 reviews',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 12),
              buildStarRatings(),
            ],
          ),
          buildRatingBars(),
        ],
      ),
    );
  }

  Widget buildStarRatings() {
    return Row(
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
    );
  }

  Widget buildRatingBars() {
    return Column(
      children: [
        buildRatingBar('5', 50),
        const SizedBox(height: 5),
        buildRatingBar('4', 35),
        const SizedBox(height: 5),
        buildRatingBar('3', 0),
        const SizedBox(height: 5),
        buildRatingBar('2', 5),
        const SizedBox(height: 5),
        buildRatingBar('1', 5),
      ],
    );
  }

  Widget buildRatingBar(String stars, double filledPercentage) {
    return Row(
      children: [
        buildRatingText(stars),
        SizedBox(width: getProportionateScreenWidth(10)),
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
                width: getProportionateScreenWidth(filledPercentage),
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
    );
  }

  Widget buildRatingText(String text) {
    return Row(
      children: [
        Text(
          text,
          style: const TextStyle(
            fontSize: 8,
            fontWeight: FontWeight.normal,
            color: Colors.grey,
            letterSpacing: 5,
          ),
        ),
        const Text(
          'Star',
          style: TextStyle(
            fontSize: 8,
            letterSpacing: 1.2,
            fontWeight: FontWeight.normal,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
