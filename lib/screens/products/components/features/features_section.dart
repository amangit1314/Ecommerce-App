import 'package:cached_network_image/cached_network_image.dart';
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
        const CategorySectionTitle(title: 'Feature\'s'),
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
                        image: CachedNetworkImageProvider(
                            'https://firebasestorage.googleapis.com/v0/b/tokoto-ecommerce-app.appspot.com/o/features%2F4.jpg?alt=media&token=5c5a4bbe-4620-4c16-ae8a-7716093e8d12'),
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
                        image: CachedNetworkImageProvider(
                            'https://firebasestorage.googleapis.com/v0/b/tokoto-ecommerce-app.appspot.com/o/features%2F1.jpg?alt=media&token=d5a36a22-b213-49ca-9a86-9295f51ff610'),
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
                        image: CachedNetworkImageProvider(
                            'https://firebasestorage.googleapis.com/v0/b/tokoto-ecommerce-app.appspot.com/o/features%2Fsneak_pink.jpg?alt=media&token=761b4fdb-2427-4fce-96af-bda7b64db36c'),
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
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(15),
                      ),
                      image: const DecorationImage(
                        image: CachedNetworkImageProvider(
                            'https://firebasestorage.googleapis.com/v0/b/tokoto-ecommerce-app.appspot.com/o/features%2Fsneakers.jpg?alt=media&token=5a3fc818-f941-49c0-83e3-34dce3714b17'),
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
