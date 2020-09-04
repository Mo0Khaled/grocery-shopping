import 'package:flutter/material.dart';
import 'package:grocery_shopping/providers/product_provider.dart';
import 'package:grocery_shopping/widgets/product_details_widgets.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatelessWidget {
  static const routeId = '/product-details';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final products = Provider.of<ProductController>(context, listen: false)
        .findById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(products.title),
        actions: [
          IconButton(
            splashColor: Colors.red,
            color: Colors.white,
            icon: Icon(
              products.isFav ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
            ),
            onPressed: () => products.toggleFav(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: ProductDetailsWidgets(),
      ),
    );
  }
}
