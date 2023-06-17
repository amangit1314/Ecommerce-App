import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../models/product.dart';
import '../../../utils/constants.dart';
import '../../../utils/size_config.dart';

class ProductImagesFirebase extends StatefulWidget {
  const ProductImagesFirebase({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  State<ProductImagesFirebase> createState() => _ProductImagesFirebaseState();
}

class _ProductImagesFirebaseState extends State<ProductImagesFirebase> {
  int selectedImage = 0;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Column(
        children: [
          Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    width: getProportionateScreenWidth(width),
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Hero(
                      tag: widget.product.id.toString(),
                      child: PageView.builder(
                        itemCount: widget.product.images.length,
                        onPageChanged: (index) {
                          setState(() {
                            selectedImage = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          return CachedNetworkImage(
                            imageUrl: widget.product.images[index],
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) => const Center(
                              child: Icon(
                                Icons.error,
                                color: Colors.red,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 80,
                right: 12,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...List.generate(
                      widget.product.images.length,
                      (index) => buildSmallProductPreview(index),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
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
        margin: const EdgeInsets.only(top: 10),
        height: getProportionateScreenWidth(48),
        width: getProportionateScreenWidth(48),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 4),
              blurRadius: 4,
              color: Colors.black.withOpacity(0.25),
            ),
          ],
          border: Border.all(
            width: selectedImage == index ? 2 : 0,
            color: Colors.white.withOpacity(selectedImage == index ? 1 : 0),
          ),
          image: DecorationImage(
            image: CachedNetworkImageProvider(widget.product.images[index]),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
