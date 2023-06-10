import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soni_store_app/utils/utils.dart';

import '../../../models/product.dart';
import '../../../providers/product_provider.dart';
import '../../../utils/constants.dart';
import '../../../utils/size_config.dart';

class ColorDots extends StatefulWidget {
  const ColorDots({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  State<ColorDots> createState() => _ColorDotsState();
}

class _ColorDotsState extends State<ColorDots> {
  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
      ),
      child: Row(
        children: [
          StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('products')
                .doc(widget.product.id.toString())
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
                List<String> colors = List<String>.from(data['colors']);

                return Row(
                  children: [
                    ...(colors.map(
                      (color) {
                        int index = colors.indexOf(color);
                        return GestureDetector(
                          onTap: () {
                            productProvider.updateSelectedColor(
                              convertStringToColor(color),
                            );
                          },
                          child: ColorDot(
                            color: convertStringToColor(color),
                            isSelected: productProvider.selectedColor ==
                                convertStringToColor(color),
                          ),
                        );
                      },
                    )).toList(),
                  ],
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
    );
  }
}

class ColorDot extends StatelessWidget {
  const ColorDot({
    Key? key,
    required this.color,
    this.isSelected = false,
  }) : super(key: key);

  final Color color;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: EdgeInsets.all(getProportionateScreenWidth(3)),
      height: getProportionateScreenWidth(30),
      width: getProportionateScreenWidth(30),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          color: isSelected ? kPrimaryColor : color,
          width: 4,
        ),
        shape: BoxShape.circle,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
