import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../components/section_tile.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/size_config.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  int curr = 0;
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {"icon": "assets/icons/Flash Icon.svg", "text": "Deal's"},
      {"icon": "assets/icons/Bill Icon.svg", "text": "Fashion"},
      {"icon": "assets/icons/Game Icon.svg", "text": "Sport's"},
      {"icon": "assets/icons/Gift Icon.svg", "text": "Grocery"},
      {"icon": "assets/icons/Discover.svg", "text": "More"},
    ];

    List iconData = [
      Icons.flash_on,
      Icons.shopping_bag,
      Icons.sports_basketball,
      Icons.card_giftcard,
      Icons.more_horiz,
    ];
    return Padding(
      padding: EdgeInsets.only(
        top: getProportionateScreenWidth(15),
        left: getProportionateScreenWidth(20),
        bottom: getProportionateScreenWidth(20),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: SectionTitle(title: 'Categories', press: () {}),
          ),
          SizedBox(height: getProportionateScreenWidth(15)),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                categories.length,
                (index) => CategoryCard2(
                    iconData: iconData[index],
                    text: categories[index]["text"],
                    press: () {
                      setState(() {
                        curr = index;
                      });
                    },
                    bgColor:
                        curr == index ? kPrimaryColor : Colors.transparent),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: getProportionateScreenWidth(55),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(15)),
              height: getProportionateScreenWidth(55),
              width: getProportionateScreenWidth(55),
              decoration: BoxDecoration(
                // color: const Color(0xFFFFECDF),
                color: kPrimaryColor.withOpacity(.3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SvgPicture.asset(icon),
            ),
            const SizedBox(height: 5),
            Text(text, textAlign: TextAlign.center)
          ],
        ),
      ),
    );
  }
}

class CategoryCard2 extends StatelessWidget {
  const CategoryCard2({
    Key? key,
    this.icon,
    required this.text,
    required this.press,
    this.iconData,
    required this.bgColor,
  }) : super(key: key);

  final String? icon, text;
  final IconData? iconData;
  final Color bgColor;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.only(right: getProportionateScreenWidth(15)),
        width: getProportionateScreenWidth(109),
        child:
            // Column(
            //   children: [
            Container(
          padding: EdgeInsets.all(getProportionateScreenWidth(15)),
          // margin: EdgeInsets.all(getProportionateScreenWidth(15)),
          height: getProportionateScreenWidth(55),
          width: getProportionateScreenWidth(55),
          decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: kPrimaryColor,
                width: 1,
              )),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  iconData,
                  size: 16,
                  color:
                      bgColor != kPrimaryColor ? kPrimaryColor : Colors.white,
                ),
                const SizedBox(width: 8),
                Text(
                  text!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color:
                        bgColor != kPrimaryColor ? kPrimaryColor : Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        // const SizedBox(height: 5),
        // Text(text, textAlign: TextAlign.center)
        // ],
        // ),
      ),
    );
  }
}
