import 'package:flutter/foundation.dart';

class CartItemModel {
  final String id;
  final String title;
  final String img;
  final double discount;
  final double quantity;
  final double price;

  CartItemModel({
    @required this.id,
    @required this.title,
    @required this.img,
    @required this.discount,
    @required this.quantity,
    @required this.price,
  });
}
