import 'package:flutter/material.dart';
import 'package:soni_store_app/screens/products/default_search_screen_view.dart';
import 'package:soni_store_app/screens/products/searched_item_screen_view.dart';

import '../../components/custom_bottom_nav_bar.dart';
import '../../utils/enums.dart';
import '../../utils/size_config.dart';
import '../home/components/home_header.dart';
import 'components/search_box.dart';

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
              SearchBox(
                searchController: _searchController,
                onSearch: _onSearch,
                onClear: _onClear,
              ),
              SizedBox(height: getProportionateScreenHeight(5)),
              _isSearching
                  ? SearchedItemsScreenView(
                      item: _searchController.text,
                    )
                  : const DefaultSearchScreenView(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(
        selectedMenu: MenuState.shipment,
      ),
    );
  }
}
