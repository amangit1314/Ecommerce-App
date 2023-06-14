import 'package:flutter/material.dart';
import 'package:soni_store_app/utils/size_config.dart';

import '../../../../components/section_tile.dart';
import '../../../showMore/show_more_screen.dart';

class Grocery extends StatelessWidget {
  const Grocery({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          title: 'Grocery',
          press: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const ShowMore(
                  keyword: 'Grocery',
                ),
              ),
            );
          },
        ),
        SizedBox(height: getProportionateScreenHeight(5)),
        const Text('This is an upcoming feature ...'),
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
              image: NetworkImage(
                  'https://firebasestorage.googleapis.com/v0/b/tokoto-ecommerce-app.appspot.com/o/groceries%2Fbasket.jpg?alt=media&token=9a1980f7-785d-426f-86cb-f979423399a2'),
              fit: BoxFit.cover,
            ),
          ),
          height: 230,
        ),
        SizedBox(height: getProportionateScreenHeight(8)),
        Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(15),
          ),
          height: 320,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: getProportionateScreenHeight(150),
                    width: getProportionateScreenWidth(width * .43),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.deepPurpleAccent.withOpacity(.3),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      ),
                      image: const DecorationImage(
                        image: NetworkImage(
                            'https://firebasestorage.googleapis.com/v0/b/tokoto-ecommerce-app.appspot.com/o/groceries%2Fvegies.jpg?alt=media&token=121849e2-b96f-464a-ae9f-ffc5f10681d9'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    height: getProportionateScreenHeight(150),
                    width: getProportionateScreenWidth(width * .43),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.indigoAccent.withOpacity(.3),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      ),
                      image: const DecorationImage(
                        image: NetworkImage(
                            'https://firebasestorage.googleapis.com/v0/b/tokoto-ecommerce-app.appspot.com/o/groceries%2Fbill.jpg?alt=media&token=84cf10bc-68a6-454d-8bc6-8d853f378205'),
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
                    height: getProportionateScreenHeight(150),
                    width: getProportionateScreenWidth(width * .43),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade900.withOpacity(.3),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(5),
                      ),
                      image: const DecorationImage(
                        image: NetworkImage(
                            'https://firebasestorage.googleapis.com/v0/b/tokoto-ecommerce-app.appspot.com/o/groceries%2Fshop_girl.jpg?alt=media&token=b3f4ee5f-694a-4733-8729-ee460127f608'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    height: getProportionateScreenHeight(150),
                    width: getProportionateScreenWidth(width * .43),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.greenAccent.withOpacity(.3),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(15),
                      ),
                      image: const DecorationImage(
                        image: NetworkImage(
                            'https://firebasestorage.googleapis.com/v0/b/tokoto-ecommerce-app.appspot.com/o/groceries%2Fgrains2.jpg?alt=media&token=3acfa0d3-4b56-4a2d-adb5-d5c5d1aa68d3'),
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
