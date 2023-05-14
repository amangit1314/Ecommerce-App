import 'package:flutter/material.dart';
import 'package:soni_store_app/resources/data/static_data.dart';
import 'package:soni_store_app/utils/size_config.dart';

import '../../../../components/section_tile.dart';

class Fashion extends StatelessWidget {
  const Fashion({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(title: 'Fashion', press: () {}),
        SizedBox(height: getProportionateScreenHeight(20)),
        Container(
          decoration: const BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
              bottomLeft: Radius.circular(5),
              bottomRight: Radius.circular(5),
            ),
            image: DecorationImage(
              image: AssetImage('assets/images/Image Banner 3.png'),
              fit: BoxFit.cover,
            ),
          ),
          height: 230,
        ),
        SizedBox(height: getProportionateScreenHeight(10)),
        Container(
          decoration: const BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          height: 180,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                tshirts.length,
                (index) => Container(
                  height: 180,
                  width: 153,
                  padding: const EdgeInsets.only(top: 8, bottom: 8, left: 8),
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: Colors.deepPurpleAccent.withOpacity(.3),
                    borderRadius: index != tshirts.length - 1
                        ? (index == 0
                            ? const BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5),
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(5),
                              )
                            : BorderRadius.circular(5))
                        : const BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5),
                            bottomLeft: Radius.circular(5),
                            bottomRight: Radius.circular(15),
                          ),
                    image: DecorationImage(
                      image: AssetImage(tshirts[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
