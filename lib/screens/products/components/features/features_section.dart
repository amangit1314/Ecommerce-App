import 'package:flutter/material.dart';

import '../../../../components/section_tile.dart';
import '../../../../utils/size_config.dart';

class FeaturesSection extends StatelessWidget {
  const FeaturesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SectionTitle(title: 'Feature\'s', press: () {}),
        SizedBox(height: getProportionateScreenHeight(15)),
        Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(15),
          ),
          height: 325,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 160,
                    width: getProportionateScreenWidth(width * .45),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.deepPurpleAccent.withOpacity(.3),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                      ),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/tshirt_w.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    height: 160,
                    width: getProportionateScreenWidth(width * .45),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.indigoAccent.withOpacity(.3),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(15),
                      ),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/images.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 160,
                    width: getProportionateScreenWidth(width * .45),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade900.withOpacity(.3),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                      ),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/sneak_pink.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    height: 160,
                    width: getProportionateScreenWidth(width * .45),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.greenAccent.withOpacity(.3),
                      // border radius on only left top
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(15),
                      ),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/sneakers.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
