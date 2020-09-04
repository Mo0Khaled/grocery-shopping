import 'package:flutter/material.dart';
import 'package:grocery_shopping/providers/product_provider.dart';
import 'package:grocery_shopping/widgets/product_item.dart';
import 'package:provider/provider.dart';
class FavoriteScreen extends StatelessWidget {
  static const routeId = '/fav-screen';
  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductController>(context, listen: true).favItems;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: productsProvider.length == 0
            ? Center(
          child: Text("No Items"),
        )
            : GridView.builder(
          itemCount: productsProvider.length,
          itemBuilder: (context, index) => ChangeNotifierProvider.value(
            value: productsProvider[index],
            child: ProductItem(),
          ),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 190,
            childAspectRatio: 2.8 / 3.0,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
        ),
      ),
    );
  }
}
