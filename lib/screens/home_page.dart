import 'package:flutter/material.dart';
import 'package:grocery_shopping/widgets/categories_container.dart';
import 'package:grocery_shopping/widgets/product_list.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CategoriesContainer(),
            buildSeeAllButton(title: 'Grocery App Member Deals',onTap: (){}),
            Container(
              padding: EdgeInsets.all(10),
              height: 220,
              child: ProductList(),
            ),
            buildSeeAllButton(title: 'Grocery App Deals',onTap: (){}),
            Container(
              padding: EdgeInsets.all(10),
              height: 220,
              child: ProductList(),
            ),
          ],
        ),
      ),
    );
  }

  Padding buildSeeAllButton({String title,Function onTap}) {
    return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    'VIEW ALL > ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Color(0xFF6E7989)),
                  ),
                ),
              ],
            ),
          );
  }
}
