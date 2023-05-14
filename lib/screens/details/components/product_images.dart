import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../models/product.dart';
import '../../../utils/constants.dart';
import '../../../utils/size_config.dart';
import '../../splash/comonents/dot_indicator.dart';

class ProductImages extends StatefulWidget {
  const ProductImages({
    Key? key,
    required this.product,
    this.isFromFirebase = false,
  }) : super(key: key);

  final Product product;
  final bool? isFromFirebase;

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
                    child: Image.asset(
                      widget.product.images[selectedImage],
                    ),
                  ),
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
                      ...List.generate(
                        widget.product.images.length,
                        (index) => buildSmallProductPreview(index),
                      ),
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
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.all(8),
          height: getProportionateScreenWidth(48),
          width: getProportionateScreenWidth(48),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color:
                    kPrimaryColor.withOpacity(selectedImage == index ? 1 : 0)),
          ),
          child: Image.asset(widget.product.images[selectedImage])),
    );
  }
}

class ProductImagesFirebase extends StatefulWidget {
  const ProductImagesFirebase({
    Key? key,
    required this.product,
    this.isFromFirebase = false,
  }) : super(key: key);

  final Product product;
  final bool? isFromFirebase;

  @override
  _ProductImagesFirebaseState createState() => _ProductImagesFirebaseState();
}

class _ProductImagesFirebaseState extends State<ProductImagesFirebase> {
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
                    child: FutureBuilder<Uint8List>(
                      future: _loadImage(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Image.memory(snapshot.data!);
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    ),
                  ),
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
                      ...List.generate(
                        widget.product.images.length,
                        (index) => buildSmallProductPreview(index),
                      ),
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

  Future<Uint8List> _loadImage() async {
    final ref = FirebaseStorage.instance
        .refFromURL(widget.product.images[selectedImage]);
    final data = await ref.getData();
    return data!;
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
        padding: const EdgeInsets.all(8),
        height: getProportionateScreenWidth(48),
        width: getProportionateScreenWidth(48),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: kPrimaryColor.withOpacity(selectedImage == index ? 1 : 0)),
        ),
        child: CachedNetworkImage(
          imageUrl: widget.product.images[index],
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
