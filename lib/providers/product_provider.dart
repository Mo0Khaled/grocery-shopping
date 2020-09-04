import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'file:///F:/work/fluter/grocery_shopping/lib/models/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductController with ChangeNotifier {
  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;
  ProductModel findById(String id) =>
      _products.firstWhere((prod) => prod.id == id);
  List<ProductModel> get favItems =>
      _products.where((prod) => prod.isFav).toList();
  List<ProductModel> filter(String name) {
    return _products
        .where(
          (element) => element.categoryId.contains(name),
        )
        .toList();
  }
  List<ProductModel> searchProduct(String name) {
    return _products
        .where(
          (element) => element.title.toLowerCase().startsWith(name),
    )
        .toList();
  }

  Future<void> fetchData() async {
    await Firebase.initializeApp();
    FirebaseAuth auth = FirebaseAuth.instance;
    var userId = auth.currentUser.uid;
    String authToken = await auth.currentUser.getIdToken();
    var url = 'https://grocery-51fdf.firebaseio.com/products.json?auth=$authToken';
    try {
      final response = await http.get(url);
      final data = json.decode(response.body) as Map<String, dynamic>;
      if (data == null) {
        return;
      }
      url = 'https://grocery-51fdf.firebaseio.com/userfav/$userId.json?auth=$authToken';
      final favResponse = await http.get(url);
      final favData = json.decode(favResponse.body);
      final List<ProductModel> loadedProduct = [];
      data.forEach((id, data) {
        loadedProduct.add(
          ProductModel(
            id: id,
            categoryId: data['category'],
            title: data['title'],
            img: data['img'],
            price: data['price'],
            discount: data['discount'],
            isFav: favData == null ? false : favData[id] ?? false,
          ),
        );
      });
      _products = loadedProduct.reversed.toList();
//      print(authToken);

      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> addProduct(ProductModel productModel) async {
    await Firebase.initializeApp();
    FirebaseAuth auth = FirebaseAuth.instance;
    String authToken = await auth.currentUser.getIdToken();
    final url = 'https://grocery-51fdf.firebaseio.com/products.json?auth=$authToken';
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'title': productModel.title,
            'category': productModel.categoryId,
            'img': productModel.img,
            'price': productModel.price,
            'discount': productModel.discount,
            'isFav': productModel.isFav,
          },
        ),
      );
      final newProduct = ProductModel(
        id: json.decode(response.body)['name'],
        categoryId: productModel.categoryId,
        title: productModel.title,
        img: productModel.img,
        price: productModel.price,
        discount: productModel.discount,
      );
      _products.add(newProduct);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> updateProducts(String id, ProductModel newProduct) async {
    await Firebase.initializeApp();
    FirebaseAuth auth = FirebaseAuth.instance;
    String authToken = await auth.currentUser.getIdToken();
    final productIndex =
        _products.indexWhere((newProduct) => newProduct.id == id);
    if (productIndex >= 0) {
      final url = 'https://grocery-51fdf.firebaseio.com/products/$id.json?auth=$authToken';
      await http.patch(
        url,
        body: json.encode(
          {
            'title': newProduct.title,
            'price': newProduct.price,
            'category': newProduct.categoryId,
            'discount': newProduct.discount,
            'img': newProduct.img,
          },
        ),
      );
      _products[productIndex] = newProduct;
      notifyListeners();
    } else {
      print('....');
    }
  }

  Future<void> deleteProduct(String id) async {
    await Firebase.initializeApp();
    FirebaseAuth auth = FirebaseAuth.instance;
    String authToken = await auth.currentUser.getIdToken();
    final url = 'https://grocery-51fdf.firebaseio.com/products/$id.json?auth=$authToken';
    final existingProductIndex =
        _products.indexWhere((productIndex) => productIndex.id == id);
    var existingProduct = _products[existingProductIndex];
    _products.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _products.insert(existingProductIndex, existingProduct);
      notifyListeners();
    }
    existingProduct = null;
  }
}
