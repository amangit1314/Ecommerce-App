import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:soni_store_app/models/product.dart';

import '../../components/custom_bottom_nav_bar.dart';
import '../../components/section_tile.dart';
import '../../utils/constants.dart';
import '../../utils/enums.dart';
import '../../utils/size_config.dart';
import '../details/detail_screen.dart';
import '../home/components/home_header.dart';

class ProductSearchPage extends StatefulWidget {
  const ProductSearchPage({Key? key}) : super(key: key);

  @override
  State<ProductSearchPage> createState() => _ProductSearchPageState();
}

class _ProductSearchPageState extends State<ProductSearchPage> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  void _onSearch(String query) {
    setState(() {
      _isSearching = true;
    });
  }

  void _onClear() {
    _searchController.clear();
    setState(() {
      _isSearching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top -
              kToolbarHeight,
          child: ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: [
              SizedBox(height: getProportionateScreenHeight(20)),
              const HomeHeader(),
              SizedBox(height: getProportionateScreenHeight(20)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SearchBox(
                  searchController: _searchController,
                  onSearch: _onSearch,
                  onClear: _onClear,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(5)),
              _isSearching
                  ? const Padding(
                      padding: EdgeInsets.all(15),
                      child: SearchedItemsScreenView(),
                    )
                  : const Padding(
                      padding: EdgeInsets.all(15),
                      child: DefaultSearchScreenView(),
                    ),
            ],
          ),
        ),
      ),
      bottomNavigationBar:
          const CustomBottomNavBar(selectedMenu: MenuState.shipment),
    );
  }
}

class SearchedItemsScreenView extends StatelessWidget {
  const SearchedItemsScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [Text('Something...')],
    );
  }
}

class DefaultSearchScreenView extends StatelessWidget {
  const DefaultSearchScreenView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            SectionTitle(title: 'Feature\'s', press: () {}),
            SizedBox(height: getProportionateScreenHeight(15)),
            Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(15),
              ),
              height: 330,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 160,
                        width: 160,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.deepPurpleAccent.withOpacity(.3),
                          borderRadius: BorderRadius.circular(15),
                          image: const DecorationImage(
                            image: AssetImage('assets/images/tshirt_w.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        height: 160,
                        width: 160,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.indigoAccent.withOpacity(.3),
                          borderRadius: BorderRadius.circular(15),
                          image: const DecorationImage(
                            image: AssetImage('assets/images/images.jpg'),
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
                        width: 160,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.amber.shade900.withOpacity(.3),
                          borderRadius: BorderRadius.circular(15),
                          image: const DecorationImage(
                            image: AssetImage('assets/images/sneak_pink.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        height: 160,
                        width: 160,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.greenAccent.withOpacity(.3),
                          borderRadius: BorderRadius.circular(15),
                          image: const DecorationImage(
                            image: AssetImage('assets/images/sneakers.jpg'),
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
        ),
        SizedBox(height: getProportionateScreenHeight(20)),
        const TshirtsSection(),
        // SizedBox(height: getProportionateScreenHeight(5)),
        const PantsSections(),
        // SizedBox(height: getProportionateScreenHeight(5)),
        const ShoesSection(),
      ],
    );
  }
}

class ShoesSection extends StatefulWidget {
  const ShoesSection({
    super.key,
  });

  @override
  State<ShoesSection> createState() => _ShoesSectionState();
}

class _ShoesSectionState extends State<ShoesSection> {
  final CollectionReference _refProducts =
      FirebaseFirestore.instance.collection('products');
  late Stream<QuerySnapshot> _streamProducts;

  @override
  void initState() {
    super.initState();
    _streamProducts = _refProducts.snapshots();
  }

  Future<List<Product>> fetchProductsFromFirestore() async {
    final List<Product> products = [];
    final QuerySnapshot snapshot = await _refProducts.get();
    for (var element in snapshot.docs) {
      products.add(Product.fromMap(element.data() as Map<String, dynamic>));
    }
    return products;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(title: 'Shoe\'s', press: () {}),
        SizedBox(height: getProportionateScreenHeight(10)),
        SizedBox(
          height: 190,
          child: StreamBuilder<QuerySnapshot>(
            stream: _streamProducts,
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('Something went wrong'),
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              final List<Product> products = snapshot.data!.docs
                  .map((e) => Product.fromMap(e.data() as Map<String, dynamic>))
                  .toList();

              return ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: 1,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => DetailsScreen(
                            product: products[index],
                          ),
                        ),
                      );
                    },
                    child: ProductSearchScreenItemCard(
                      width: 170,
                      productName: products[index].title,
                      productImage: products[index].images.isNotEmpty
                          ? products[index].images[index]
                          : '',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => DetailsScreen(
                              product: products[index],
                            ),
                          ),
                        );
                      },
                      // productDesc: '\$${products[index].price}',
                      price: '\$${products[index].price}',
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class PantsSections extends StatefulWidget {
  const PantsSections({
    super.key,
  });

  @override
  State<PantsSections> createState() => _PantsSectionsState();
}

class _PantsSectionsState extends State<PantsSections> {
  final CollectionReference _refProducts =
      FirebaseFirestore.instance.collection('products');
  late Stream<QuerySnapshot> _streamProducts;

  @override
  void initState() {
    super.initState();
    _streamProducts = _refProducts.snapshots();
  }

  Future<List<Product>> fetchProductsFromFirestore() async {
    final List<Product> products = [];
    final QuerySnapshot snapshot = await _refProducts.get();
    for (var element in snapshot.docs) {
      products.add(Product.fromMap(element.data() as Map<String, dynamic>));
    }
    return products;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(title: 'Pant\'s', press: () {}),
        SizedBox(height: getProportionateScreenHeight(10)),
        SizedBox(
          height: 190,
          child: StreamBuilder<QuerySnapshot>(
            stream: _streamProducts,
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('Something went wrong'),
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              final List<Product> products = snapshot.data!.docs
                  .map((e) => Product.fromMap(e.data() as Map<String, dynamic>))
                  .toList();

              return ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: 1,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => DetailsScreen(
                            product: products[index],
                          ),
                        ),
                      );
                    },
                    child: ProductSearchScreenItemCard(
                      width: 170,
                      productName: products[index].title,
                      productImage: products[index].images.isNotEmpty
                          ? products[index].images[index]
                          : '',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => DetailsScreen(
                              product: products[index],
                            ),
                          ),
                        );
                      },
                      // productDesc: '\$${products[index].price}',
                      price: '\$${products[index].price}',
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class TshirtsSection extends StatefulWidget {
  const TshirtsSection({
    super.key,
  });

  @override
  State<TshirtsSection> createState() => _TshirtsSectionState();
}

class _TshirtsSectionState extends State<TshirtsSection> {
  final CollectionReference _refProducts =
      FirebaseFirestore.instance.collection('products');
  late Stream<QuerySnapshot> _streamProducts;

  @override
  void initState() {
    super.initState();
    _streamProducts = _refProducts.snapshots();
  }

  Future<List<Product>> fetchProductsFromFirestore() async {
    final List<Product> products = [];
    final QuerySnapshot snapshot = await _refProducts.get();
    for (var element in snapshot.docs) {
      products.add(Product.fromMap(element.data() as Map<String, dynamic>));
    }
    return products;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(title: 'Tshirt\'s', press: () {}),
        SizedBox(height: getProportionateScreenHeight(10)),
        SizedBox(
          height: 190,
          child: StreamBuilder<QuerySnapshot>(
            stream: _streamProducts,
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('Something went wrong'),
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              final List<Product> products = snapshot.data!.docs
                  .map((e) => Product.fromMap(e.data() as Map<String, dynamic>))
                  .toList();

              return ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: 1,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => DetailsScreenFirebase(
                            product: products[index],
                          ),
                        ),
                      );
                    },
                    child: ProductSearchScreenItemCard(
                      width: 170,
                      productName: products[index].title,
                      productImage: products[index].images.isNotEmpty
                          ? products[index].images[index]
                          : '',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => DetailsScreenFirebase(
                              product: products[index],
                            ),
                          ),
                        );
                      },
                      // productDesc: '\$${products[index].price}',
                      price: '\$${products[index].price}',
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class SearchBox extends StatelessWidget {
  const SearchBox({
    Key? key,
    required this.searchController,
    required this.onSearch,
    required this.onClear,
  }) : super(key: key);

  final TextEditingController searchController;
  final Function(String query) onSearch;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        padding: const EdgeInsets.all(4),
        margin: const EdgeInsets.only(right: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            bottomLeft: Radius.circular(15),
          ),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 10),
              blurRadius: 50,
              color: Colors.grey.withOpacity(0.3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: IconButton(
                  icon: const Icon(Icons.search, color: Colors.white),
                  onPressed: () => onSearch(searchController.text),
                ),
              ),
            ),
            Expanded(
              child: TextField(
                controller: searchController,
                decoration: const InputDecoration(
                  hintText: 'Search for products ...',
                  hintStyle: TextStyle(fontSize: 12),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(10),
                ),
                onSubmitted: onSearch,
              ),
            ),
            Container(
              // height: 50,
              // width: 50,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                  color: kPrimaryColor, borderRadius: BorderRadius.circular(15)
                  // borderRadius: BorderRadius.only(
                  //   topRight: Radius.circular(15),
                  //   bottomRight: Radius.circular(15),
                  // ),
                  ),
              child: Center(
                child: IconButton(
                  onPressed: () {},
                  icon: const FaIcon(
                    FontAwesomeIcons.arrowDownShortWide,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductSearchScreenItemCard extends StatelessWidget {
  ProductSearchScreenItemCard({
    Key? key,
    this.width = 150,
    this.aspectRetio = 1.02,
    required this.productImage,
    this.productName = 'Gaming',
    // this.productDesc = 'These are from gaming category',
    this.color = Colors.white,
    // this.addedToCart = false,
    required this.price,
    this.onTap,
  }) : super(key: key);

  final double width, aspectRetio;
  final String productImage;
  final String productName;
  // final String productDesc;
  final Color color;
  final String price;
  // bool? addedToCart = false;
  final VoidCallback? onTap;
  bool? isTransparent = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
        margin: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: width,
              height: 110,
              decoration: BoxDecoration(
                color: color.withOpacity(.3),
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: NetworkImage(
                    productImage,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  productName,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0, top: 4, bottom: 8),
              child: Text(
                price,
                style: const TextStyle(
                  fontSize: 12,
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductSearchScreenItemCard2 extends StatelessWidget {
  ProductSearchScreenItemCard2({
    Key? key,
    this.width = 150,
    this.aspectRetio = 1.02,
    required this.productImage,
    this.productName = 'Gaming',
    // this.productDesc = 'These are from gaming category',
    this.color = Colors.white,
    // this.addedToCart = false,
    required this.price,
    this.onTap,
  }) : super(key: key);

  final double width, aspectRetio;
  final String productImage;
  final String productName;
  // final String productDesc;
  final Color color;
  final String price;
  // bool? addedToCart = false;
  final VoidCallback? onTap;
  bool? isTransparent = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
        margin: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: width,
              height: 110,
              decoration: BoxDecoration(
                color: color.withOpacity(.3),
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: AssetImage(
                    productImage,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  productName,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0, top: 4, bottom: 8),
              child: Text(
                price,
                style: const TextStyle(
                  fontSize: 12,
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
