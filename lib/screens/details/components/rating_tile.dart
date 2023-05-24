import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../utils/size_config.dart';

class RatingTile extends StatelessWidget {
  const RatingTile({super.key});

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
              const SizedBox(height: 5),
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
              const SizedBox(height: 5),
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
              const SizedBox(height: 5),
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
              const SizedBox(height: 5),
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
