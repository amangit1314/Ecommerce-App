import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../utils/size_config.dart';

class RatingTile extends StatefulWidget {
  final String rating;
  const RatingTile({Key? key, required this.rating}) : super(key: key);

  @override
  State<RatingTile> createState() => _RatingTileState();
}

class _RatingTileState extends State<RatingTile> {
  late double averageRating;

  @override
  void initState() {
    super.initState();
    averageRating = double.parse(widget.rating);
  }

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
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                height: 30,
                alignment: Alignment.centerLeft,
                child: Text.rich(
                  TextSpan(
                    text: averageRating.toStringAsFixed(1),
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
                children: [
                  for (int i = 1; i <= 5; i++)
                    FaIcon(
                      FontAwesomeIcons.solidStar,
                      color: i <= averageRating ? Colors.amber : Colors.grey,
                      size: 18,
                    ),
                  if (averageRating.floor() < averageRating)
                    const FaIcon(
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
              for (int i = 5; i >= 1; i--)
                Row(
                  children: [
                    Row(
                      children: [
                        Text(
                          i.toString(),
                          style: const TextStyle(
                            letterSpacing: 5,
                            fontSize: 8,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey,
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
                    ),
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
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                            height: 5,
                            width: getProportionateScreenWidth(
                              i <= averageRating ? 100 : 0,
                            ),
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
              const SizedBox(height: 5),
            ],
          ),
        ],
      ),
    );
  }
}
