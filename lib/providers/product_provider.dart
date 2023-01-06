import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:tokoto_ecommerce_app/models/product_name.dart';

class ProductProvider with ChangeNotifier {
  ProductProvider.initialize() {
    loadProducts();
  }

  loadProducts() async {
    _products = await Product.getProducts();
    notifyListeners();
  }

  loadProductsSearched(String productName) async {
    _productsSearched = await Product.getProductsSearched(productName);
    notifyListeners();
  }

  loadProductsByCategory(String categoryName) async {
    _productsByCategory = await Product.getProductsByCategory(categoryName);
    notifyListeners();
  }

  loadProductsByBrand(String brandName) async {
    _productsByBrand = await Product.getProductsByBrand(brandName);
    notifyListeners();
  }

  loadProductsByUser(String userId) async {
    _productsByUser = await Product.getProductsByUser(userId);
    notifyListeners();
  }

  // get products method
  Future<List<Product>> getProducts() async {
    var productsData =
        await FirebaseFirestore.instance.collection('products').get();
    List<Product> products = [];
    for (var productData in productsData.docs) {
      products.add(Product.fromSnapshot(productData));
    }
    return products;
  }

  List<Product> _products = [];
  List<Product> get products => _products;

  List<Product> _productsSearched = [];
  List<Product> get productsSearched => _productsSearched;

  List<Product> _productsByCategory = [];
  List<Product> get productsByCategory => _productsByCategory;

  List<Product> _productsByBrand = [];
  List<Product> get productsByBrand => _productsByBrand;

  List<Product> _productsByUser = [];
  List<Product> get productsByUser => _productsByUser;

  final List<Product> _productsByUserFavourite = [];
  List<Product> get productsByUserFavourite => _productsByUserFavourite;

  final List<Product> _productsByUserCart = [];
  List<Product> get productsByUserCart => _productsByUserCart;

  final List<Product> _productsByUserWishList = [];
  List<Product> get productsByUserWishList => _productsByUserWishList;

  final List<Product> _productsByUserOrder = [];
  List<Product> get productsByUserOrder => _productsByUserOrder;

  final List<Product> _productsByUserOrderHistory = [];
  List<Product> get productsByUserOrderHistory => _productsByUserOrderHistory;

  final List<Product> _productsByUserOrderHistoryDetails = [];
  List<Product> get productsByUserOrderHistoryDetails =>
      _productsByUserOrderHistoryDetails;

  final List<Product> _productsByUserOrderHistoryDetailsByProduct = [];
  List<Product> get productsByUserOrderHistoryDetailsByProduct =>
      _productsByUserOrderHistoryDetailsByProduct;

  final List<Product> _productsByUserOrderHistoryDetailsByProductByUser = [];
  List<Product> get productsByUserOrderHistoryDetailsByProductByUser =>
      _productsByUserOrderHistoryDetailsByProductByUser;

  final List<Product> _productsByUserOrderHistoryDetailsByProductByUserByOrder =
      [];
  List<Product> get productsByUserOrderHistoryDetailsByProductByUserByOrder =>
      _productsByUserOrderHistoryDetailsByProductByUserByOrder;

  final List<Product>
      _productsByUserOrderHistoryDetailsByProductByUserByOrderDetails = [];
  List<Product>
      get productsByUserOrderHistoryDetailsByProductByUserByOrderDetails =>
          _productsByUserOrderHistoryDetailsByProductByUserByOrderDetails;

  final List<Product>
      _productsByUserOrderHistoryDetailsByProductByUserByOrderDetailsByProduct =
      [];

  List<Product>
      get productsByUserOrderHistoryDetailsByProductByUserByOrderDetailsByProduct =>
          _productsByUserOrderHistoryDetailsByProductByUserByOrderDetailsByProduct;

  final List<Product>
      _productsByUserOrderHistoryDetailsByProductByUserByOrderDetailsByProductByUser =
      [];

  List<Product>
      get productsByUserOrderHistoryDetailsByProductByUserByOrderDetailsByProductByUser =>
          _productsByUserOrderHistoryDetailsByProductByUserByOrderDetailsByProductByUser;

  final List<Product>
      _productsByUserOrderHistoryDetailsByProductByUserByOrderDetailsByProductByUserByOrder =
      [];

  List<Product>
      get productsByUserOrderHistoryDetailsByProductByUserByOrderDetailsByProductByUserByOrder =>
          _productsByUserOrderHistoryDetailsByProductByUserByOrderDetailsByProductByUserByOrder;
}
