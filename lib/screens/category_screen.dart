import 'package:flutter/material.dart';
import 'package:grocery_shopping/providers/category_provider.dart';
import 'package:grocery_shopping/providers/product_provider.dart';
import 'package:grocery_shopping/widgets/product_item.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatelessWidget {
  static const routeId = '/category-screens';

  @override
  Widget build(BuildContext context) {
    final categoryId = ModalRoute.of(context).settings.arguments as String;
    final cat = Provider.of<CategoryController>(context, listen: false)
        .findById(categoryId);
    final productsProvider =
        Provider.of<ProductController>(context, listen: false)
            .filter(cat.title);
    return Scaffold(
      appBar: AppBar(
        title: Text(cat.title),
      ),
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
//          shrinkWrap: true,

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
