import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:grocery_shopping/models/cart_item.dart';
import 'package:grocery_shopping/models/order_item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderController with ChangeNotifier {
  List<OrderItemModel> _orders = [];

  List<OrderItemModel> get orders => _orders;

  OrderItemModel findById(String id) =>
      _orders.firstWhere((element) => element.id == id);

  double get totalAmount {
    var total = 0.0;
    _orders.forEach((orderItem) {
      total += orderItem.amount;
    });
    return total;
  }

  Future<void> fetchOrders() async {
    await Firebase.initializeApp();
    FirebaseAuth auth = FirebaseAuth.instance;
    var userId = auth.currentUser.uid;
    String authToken = await auth.currentUser.getIdToken();
    final url = 'https://grocery-51fdf.firebaseio.com/orders/$userId.json?auth=$authToken';
    final response = await http.get(url);
    final List<OrderItemModel> loadedOrder = [];
    final data = json.decode(response.body) as Map<String, dynamic>;
    if (data == null) {
      return;
    }
    data.forEach((orderId, orderData) {
      loadedOrder.add(
        OrderItemModel(
          id: orderId,
          amount: orderData['amount'],
          products: (orderData['products'] as List<dynamic>)
              .map(
                (item) => CartItemModel(
                  id: item['id'],
                  title: item['title'],
                  discount: item['discount'],
                  quantity: item['quantity'],
                  price: item['price'],
                ),
              )
              .toList(),
          dateTime: DateTime.parse(orderData['dateTime']),
        ),
      );
    });
    _orders =loadedOrder.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItemModel> cartProducts, double total) async {
    await Firebase.initializeApp();
    final time = DateTime.now();
    FirebaseAuth auth = FirebaseAuth.instance;
    var userId = auth.currentUser.uid;
    String authToken = await auth.currentUser.getIdToken();
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

    String deviceToken = await _firebaseMessaging.getToken();
    final url = 'https://grocery-51fdf.firebaseio.com/orders/$userId.json?auth=$authToken';
    final response = await http.post(
      url,
      body: json.encode(
        {
          'amount': total,
          'time': time.toIso8601String(),
          'token':deviceToken,
          'products': cartProducts
              .map(
                (cp) => {
                  'id': cp.id,
                  'title': cp.title,
                  'quantity': cp.quantity,
                  'price': cp.price,
                  'discount': cp.discount,
                },
              )
              .toList(),
        },
      ),
    );
    _orders.insert(
      0,
      OrderItemModel(
        id: json.decode(response.body)['name'],
        amount: total,
        products: cartProducts,
        dateTime: time,
      ),
    );

    notifyListeners();
  }
}
