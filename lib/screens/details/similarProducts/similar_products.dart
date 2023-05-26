import 'package:flutter/material.dart';

import '../../../components/section_tile.dart';
import '../../../utils/constatns.dart';
import '../../../utils/size_config.dart';
import '../../showMore/show_more_screen.dart';
import '../components/body.dart';

class SimilarProducts extends StatelessWidget {
  const SimilarProducts({
    super.key,
    required this.widget,
  });
  final DetailFirebaseBody widget;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SectionTitle(
            title: 'Similar Products',
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ShowMore(),
                ),
              );
            },
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(15)),
        Container(
          height: 250,
          padding: const EdgeInsets.only(left: 20.0),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) {
              return GestureDetector(
                child: Container(
                  width: 170,
                  margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.only(
                    top: 8,
                    left: 8,
                    right: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: kPrimaryColor.withOpacity(.2),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
