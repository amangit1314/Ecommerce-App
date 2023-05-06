import 'package:flutter/material.dart';

import '../../../utils/size_config.dart';
import '../../splash/comonents/dot_indicator.dart';

class DiscountBanner extends StatefulWidget {
  const DiscountBanner({
    Key? key,
  }) : super(key: key);

  @override
  State<DiscountBanner> createState() => _DiscountBannerState();
}

class _DiscountBannerState extends State<DiscountBanner> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 190,
          width: double.infinity,
          child: PageView.builder(
            onPageChanged: (value) {
              setState(() {
                currentPage = value;
              });
            },
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.all(15),
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.deepPurpleAccent,
                  borderRadius: BorderRadius.circular(25),
                  image: const DecorationImage(
                      image: AssetImage(
                        "assets/images/shoes2.png",
                      ),
                      fit: BoxFit.cover,
                      opacity: .5),
                ),
                child: Flexible(
                  child: Row(
                    children: [
                      Flexible(
                        child: Container(
                          width: getProportionateScreenWidth(240),
                          margin:
                              EdgeInsets.all(getProportionateScreenWidth(10)),
                          padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(20),
                            vertical: getProportionateScreenWidth(15),
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF4A3298),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text.rich(
                            TextSpan(
                              style: const TextStyle(color: Colors.white),
                              children: [
                                const TextSpan(text: "Summer Surpise\n"),
                                TextSpan(
                                  text: "20% \n",
                                  style: TextStyle(
                                    fontSize: getProportionateScreenWidth(24),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: "Cashback",
                                  style: TextStyle(
                                    fontSize: getProportionateScreenWidth(14),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          margin:
                              EdgeInsets.all(getProportionateScreenWidth(10)),
                          child: Image.asset(
                            "assets/images/shoes2.png",
                            fit: BoxFit.cover,
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
        SizedBox(height: getProportionateScreenHeight(10)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            4,
            (index) => HorizontalDotIndicator(
              currentPage: currentPage,
              index: index,
            ),
          ),
        ),
      ],
    );
  }
}
