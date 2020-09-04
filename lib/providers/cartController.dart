import 'package:flutter/foundation.dart';
import 'package:grocery_shopping/models/cart_item.dart';

class CartController with ChangeNotifier {
  Map<String, CartItemModel> _products = {};

  Map<String, CartItemModel> get products => _products;
  int get itemCount => products.length;
  double get getQuantity {
    var total = 0.0;
    _products.forEach(
      (key, cartItem) {
        total += cartItem.quantity;
      },
    );
    return total;
  }
  double get totalAmount {
    var total = 0.0;
    _products.forEach(
          (key, cartItem) {
        total += cartItem.price * cartItem.quantity;
      },
    );
    return total;
  }

  void addItem(
      String id, double price, String title, String img, double discount) {
    if (_products.containsKey(id)) {
      _products.update(
        id,
        (value) => CartItemModel(
          id: value.id,
          title: value.title,
          img: value.img,
          discount: value.discount,
          quantity: value.quantity + 0.5,
          price: value.price,
        ),
      );
    } else {
      _products.putIfAbsent(
        id,
        () => CartItemModel(
          id: DateTime.now().toString(),
          title: title,
          img: img,
          discount: discount,
          quantity: 1,
          price: price,
        ),
      );
    }
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_products.containsKey(productId)) {
      return;
    }
    if (products[productId].quantity > 1) {
      _products.update(
        productId,
        (value) => CartItemModel(
          id: value.id,
          title: value.title,
          img: value.img,
          discount: value.discount,
          quantity: value.quantity - 0.5,
          price: value.price,
        ),
      );
    } else {
      _products.remove(productId);
    }
    notifyListeners();
  }

  void addOne(String productId, double price, String title, String img) {
    if (_products.containsKey(productId)) {
      _products.update(
        productId,
        (value) => CartItemModel(
          id: value.id,
          title: value.title,
          img: value.img,
          discount: value.discount,
          quantity: value.quantity + 0.5,
          price: value.price,
        ),
      );
    } else {
      _products.putIfAbsent(
        productId,
        () => CartItemModel(
          id: DateTime.now().toString(),
          title: title,
          img: img,
//          discount: discount,
          quantity: 1,
          price: price,
        ),
      );
    }
    notifyListeners();
  }

  void removeOne(String productId) {
    if (_products.containsKey(productId)) {
      _products.update(
        productId,
        (value) => CartItemModel(
          id: value.id,
          title: value.title,
          img: value.img,
          discount: value.discount,
          quantity: value.quantity > 0.5 ? value.quantity - 0.5 : value.quantity,
          price: value.price,
        ),
      );
    }
    notifyListeners();
  }

  void removeItems(String productId) {
    _products.remove(productId);
    notifyListeners();
  }

  void clear() {
    _products = {};
    notifyListeners();
  }
}
