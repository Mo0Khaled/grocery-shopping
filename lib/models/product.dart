import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class ProductModel with ChangeNotifier {
  final String id;
  final String categoryId;
  final String title;
  final String img;
  final double price;
  final double discount;
  bool stars;
  bool isFav ;

  ProductModel({
    @required this.id,
    @required this.categoryId,
    @required this.title,
    @required  this.img,
    @required this.price,
    @required this.discount,
    this.stars = false,
    this.isFav = false,
  });

  void _setFavValue(bool newFav){
    isFav = newFav;
    notifyListeners();
  }
  Future<void> toggleFav()async{
    await Firebase.initializeApp();
    FirebaseAuth auth = FirebaseAuth.instance;
    var userId = auth.currentUser.uid;
    String authToken = await auth.currentUser.getIdToken();
    final oldStatus = isFav;
    isFav = !isFav;
    notifyListeners();
    final url = 'https://grocery-51fdf.firebaseio.com/userfav/$userId/$id.json?auth=$authToken';
    try{
      final response = await http.put(url,body: json.encode(isFav),);
      if(response.statusCode >= 400){
        _setFavValue(oldStatus);
      }
    }catch(error){
      _setFavValue(oldStatus);
    }
  }
}
