import 'package:flutter/material.dart';
import 'package:grocery_shopping/providers/product_provider.dart';
import 'package:grocery_shopping/widgets/product_item.dart';
import 'package:provider/provider.dart';

class ProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productController = Provider.of<ProductController>(context,listen: false);
    return FutureBuilder(
        future: productController.fetchData(),
    builder:(context,snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else {
        if (snapshot.error != null) {
          return Center(
            child: Text("error"),
          );
        }
        else {
          return Consumer<ProductController>(
            builder: (context,productController,_)=> GridView.builder(
              itemBuilder: (context, index) =>
                  ChangeNotifierProvider.value(
                    value: productController.products[index],
                    child: ProductItem(),
                  ),
              scrollDirection: Axis.horizontal,
              itemCount: productController.products.length,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 190,
                childAspectRatio: 4 / 3.5,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
            ),
          );
        }
      }
    }
    );
    }
  }
