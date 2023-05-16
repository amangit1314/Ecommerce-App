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
  }) : super(key: key);

  final Product product;

  @override
  State<ProductImagesFirebase> createState() => _ProductImagesFirebaseState();
}

class _ProductImagesFirebaseState extends State<ProductImagesFirebase> {
  int selectedImage = 0;

  final CollectionReference _productsRef =
      FirebaseFirestore.instance.collection('products');
  late Stream<QuerySnapshot> _productsStream;

  @override
  void initState() {
    super.initState();
    _productsStream = _productsRef.snapshots();
  }

  Future<List<Product>> fetchProductsFromFirestore() async {
    final List<Product> products = [];
    final QuerySnapshot snapshot = await _productsRef.get();
    for (var element in snapshot.docs) {
      products.add(Product.fromMap(element.data() as Map<String, dynamic>));
    }
    return products;
  }

  // void fetchProductImages() {
  //   _productsRef.doc('productID').get().then((docSnapshot) {
  //     if (docSnapshot.exists) {
  //       final data = docSnapshot.data();
  //       if (data != null && data['images'] is List<String>) {
  //         final List<String> imageList = List<String>.from(data['images']);
  //         // Process the image list here
  //         for (String imageUrl in imageList) {
  //           _fetchImageFromFirebase(imageUrl);
  //         }
  //       }
  //     }
  //   }).catchError((error) {
  //     // Handle any errors that occur during retrieval
  //     print('Error fetching product images: $error');
  //   });
  // }

  // void _fetchImageFromFirebase(String imageUrl) {
  //   FirebaseStorage.instance
  //       .ref()
  //       .child(imageUrl)
  //       .getDownloadURL()
  //       .then((downloadUrl) {
  //     // Use the download URL to fetch the image data
  //     http.get(Uri.parse(downloadUrl)).then((response) {
  //       final Uint8List imageData = response.bodyBytes;
  //       // Process the image data here
  //       // e.g., display the image in a widget
  //     }).catchError((error) {
  //       // Handle any errors that occur during image retrieval
  //       print('Error fetching image data: $error');
  //     });
  //   }).catchError((error) {
  //     // Handle any errors that occur during download URL retrieval
  //     print('Error fetching download URL: $error');
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 40.0),
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  width: width,
                  child: Center(
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
                              return Image.network(
                                // ! i think i need to wrap stack with the listview
                                snapshot.data!.docs[0]['images'][selectedImage],
                              );
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
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 12,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ...List.generate(
                            widget.product.images.length,
                            (index) => buildSmallProductPreview(index),
                          ),
                          DotIndicator(
                            index: selectedImage,
                            currentPage: widget.product.images.length,
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
        child: CachedNetworkImage(
          imageUrl: widget.product.images[selectedImage],
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
