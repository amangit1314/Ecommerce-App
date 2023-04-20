import 'package:flutter/material.dart';

import '../../../models/product_name.dart';
import '../../../utils/constants.dart';
import '../../../utils/size_config.dart';
import '../../splash/comonents/dot_indicator.dart';

class ProductImages extends StatefulWidget {
  const ProductImages({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  int selectedImage = 0;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 40.0),
        child: Stack(
          children: [
            SizedBox(
              width: width,
              child: Center(
                child: Hero(
                  tag: widget.product.id.toString(),
                  child: Center(
                      child: Image.asset(widget.product.images[selectedImage])),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...List.generate(widget.product.images.length,
                          (index) => buildSmallProductPreview(index)),
                    ],
                  ),
                ),
              ],
            )
            // SizedBox(height: getProportionateScreenWidth(20)),
            ,
            DotIndicator(
              index: selectedImage,
              currentPage: widget.product.images.length,
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector buildSmallProductPreview(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
      },
      child: AnimatedContainer(
        duration: defaultDuration,
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.all(8),
        height: getProportionateScreenWidth(48),
        width: getProportionateScreenWidth(48),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: kPrimaryColor.withOpacity(selectedImage == index ? 1 : 0)),
        ),
        child: Image.asset(widget.product.images[index]),
      ),
    );
  }
}
