import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../components/section_tile.dart';
import '../../../../models/product.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/size_config.dart';
import '../../../details/detail_screen.dart';
import '../../../loading/shimmer_box.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int curr = 0;

  List iconData = [
    // Icons.flash_on,
    FontAwesomeIcons.basketShopping,
    // Icons.sports_basketball,
    FontAwesomeIcons.baseball,
    // Icons.card_giftcard,
    FontAwesomeIcons.shoePrints,
    FontAwesomeIcons.shirt,
  ];

  List categoryText = [
    // "All",
    "Fashion",
    "Sports",
    "Footwear",
    "tshirts",
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: iconData.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final CollectionReference _refProducts =
      FirebaseFirestore.instance.collection('products');

  Future<List<Product>> fetchProductsFromFirestore(String category) async {
    final List<Product> products = [];
    final QuerySnapshot snapshot = await _refProducts
        .where(
          'categories',
          arrayContains: category,
        )
        .get();
    for (var element in snapshot.docs) {
      products.add(Product.fromMap(element.data() as Map<String, dynamic>));
    }
    return products;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: getProportionateScreenWidth(15),
        left: getProportionateScreenWidth(20),
        bottom: getProportionateScreenWidth(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: CategorySectionTitle(title: 'Categories'),
          ),
          SizedBox(height: getProportionateScreenWidth(15)),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                iconData.length,
                (index) => CategoryCard(
                  iconData: iconData[index],
                  text: categoryText[index],
                  press: () {
                    setState(() {
                      curr = index;
                    });
                  },
                  bgColor: curr == index ? kPrimaryColor : Colors.transparent,
                ),
              ),
            ),
          ),
          SizedBox(height: getProportionateScreenWidth(15)),
          SizedBox(
            height: getProportionateScreenHeight(450),
            child: FutureBuilder<List<Product>>(
              future: fetchProductsFromFirestore(
                // curr == 0 ? '' :
                categoryText[curr],
              ),
              builder: (context, snapshot) {
                final List<Product> products = snapshot.data ?? [];

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: products.length < 4 ? products.length : 4,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        height: 200,
                        width: getProportionateScreenWidth(150),
                        child: ShimmerBox(
                          child: SizedBox(
                            height: getProportionateScreenHeight(200),
                            width: getProportionateScreenWidth(150),
                          ),
                        ),
                      );
                    },
                  );
                }

                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Something went wrong'),
                  );
                }

                if (products.isEmpty) {
                  return const Center(
                    child: Text('No products found for the selected category'),
                  );
                }

                return GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                  ),
                  itemCount: products.length < 4 ? products.length : 4,
                  itemBuilder: (context, index) {
                    return CategoryGridItem(
                      product: products[index],
                      image: products[index].images.first,
                      category: products[index].categories.first,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    this.icon,
    required this.text,
    required this.press,
    this.iconData,
    required this.bgColor,
  }) : super(key: key);

  final String? icon, text;
  final IconData? iconData;
  final Color bgColor;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.only(right: getProportionateScreenWidth(15)),
        width: getProportionateScreenWidth(120),
        child: Container(
          padding: EdgeInsets.all(getProportionateScreenWidth(15)),
          height: getProportionateScreenWidth(55),
          width: getProportionateScreenWidth(55),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: kPrimaryColor, width: 1),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  iconData,
                  size: 14,
                  color:
                      bgColor != kPrimaryColor ? kPrimaryColor : Colors.white,
                ),
                const SizedBox(width: 10),
                Text(
                  text!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11,
                    color:
                        bgColor != kPrimaryColor ? kPrimaryColor : Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryGridItem extends StatelessWidget {
  final Product product;
  final String? image;
  final String? category;
  const CategoryGridItem({
    Key? key,
    required this.product,
    this.image,
    this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => DetailsScreenFirebase(
              product: product,
            ),
          ),
        );
      },
      child: Container(
        width: getProportionateScreenWidth(150),
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.only(
          top: 8,
          left: 8,
          right: 8,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: kPrimaryColor.withOpacity(.2),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 140,
              width: 170,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    image! == '' ? 'https://picsum.photos/250?image=9' : image!,
                  ),
                  fit: BoxFit.cover,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          product.title,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0, top: 2, bottom: 8),
              child: Text(
                '₹ ${product.price}',
                style: const TextStyle(
                  fontSize: 12,
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
