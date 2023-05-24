import 'package:flutter/material.dart';
import 'package:soni_store_app/utils/size_config.dart';

import '../../../../components/section_tile.dart';

class Grocery extends StatelessWidget {
  const Grocery({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: 'Grocery', press: () {}),
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
              image: AssetImage('assets/images/basket.jpg'),
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
                        image: AssetImage('assets/images/vegies.jpg'),
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
                        image: AssetImage('assets/images/bill.jpg'),
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
                        image: AssetImage('assets/images/shop_girl.jpg'),
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
                        image: AssetImage('assets/images/grains2.jpg'),
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
