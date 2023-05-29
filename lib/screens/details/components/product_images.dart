import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  State<ProductImages> createState() => _ProductImagesState();
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
            ),
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
              color: kPrimaryColor.withOpacity(selectedImage == index ? 1 : 0)),
        ),
        child: Image.asset(widget.product.images[selectedImage]),
      ),
    );
  }
}

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
  int selectedProductIndex = 0;

  final CollectionReference _productsRef =
      FirebaseFirestore.instance.collection('products');
  late Stream<QuerySnapshot> _productsStream;

  @override
  void initState() {
    super.initState();
    _productsStream = _productsRef.snapshots();
    selectedProductIndex = 0;
  }

  Future<List<Product>> fetchProductsFromFirestore() async {
    final List<Product> products = [];
    final QuerySnapshot snapshot = await _productsRef.get();
    for (var element in snapshot.docs) {
      products.add(Product.fromMap(element.data() as Map<String, dynamic>));
    }
    return products;
  }

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
                    width: getProportionateScreenWidth(
                        MediaQuery.of(context).size.width),
                    height: MediaQuery.of(context).size.height * .4,
                    // child: AspectRatio(
                    //   aspectRatio: 1,
                    child: Hero(
                      tag: widget.product.id.toString(),
                      child: Center(
                        child: StreamBuilder<QuerySnapshot>(
                          stream: _productsStream,
                          builder: (
                            context,
                            AsyncSnapshot<QuerySnapshot> snapshot,
                          ) {
                            if (snapshot.hasData) {
                              return Container(
                                height: 300,
                                width: width,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      widget.product.images[selectedImage],
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            } else {
                              return const CircularProgressIndicator();
                            }
                          },
                        ),
                      ),
                    ),
                    //   ),
                    // ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 80.0,
                      right: 12,
                    ),
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
            image: CachedNetworkImageProvider(
                widget.product.images[selectedImage]),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
