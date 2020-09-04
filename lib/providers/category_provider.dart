import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class CategoryItem {
  final String id;
  final String title;
  final IconData icon;

  CategoryItem({
    @required this.id,
    @required this.title,
    @required this.icon,
  });
}

class CategoryController with ChangeNotifier {
  List<CategoryItem> _categories = [
    CategoryItem(id: "1", title: "Household", icon: Icons.house),
    CategoryItem(id: "2", title: "Grocery", icon: Icons.shopping_cart),
    CategoryItem(id: "3", title: "Liquor", icon: Icons.wine_bar),
    CategoryItem(id: "4", title: "Chilled", icon: FontAwesomeIcons.hamburger),
    CategoryItem(id: "5", title: "Beverages", icon:FontAwesomeIcons.wineBottle ),
    CategoryItem(id: "6", title: "Pharmacy", icon: FontAwesomeIcons.thermometer),
    CategoryItem(id: "7", title: "Frozen Food", icon: FontAwesomeIcons.iceCream),
    CategoryItem(id: "8", title: "Vegetables", icon: FontAwesomeIcons.carrot),
    CategoryItem(id: "9", title: "Meat", icon:FontAwesomeIcons.bacon),
    CategoryItem(id: "10", title: "Fish", icon: FontAwesomeIcons.fish),
    CategoryItem(id: "11", title: "HomeWare", icon: FontAwesomeIcons.chair),
    CategoryItem(id: "12", title: "Fruits", icon: FontAwesomeIcons.apple),

  ];

  List<CategoryItem> get categories => _categories;
  CategoryItem findById(String id) =>
      _categories.firstWhere((prod) => prod.id == id);
}
