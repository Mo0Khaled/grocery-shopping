import 'package:flutter/foundation.dart';
import 'package:grocery_shopping/models/cart_item.dart';

class OrderItemModel {
  final String id;
  final double amount;
  final List<CartItemModel> products;
  final DateTime dateTime;

  OrderItemModel({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}
