import 'package:flutter/material.dart';
import 'package:grocery_shopping/providers/product_provider.dart';
import 'package:grocery_shopping/screens/mange_product_screen.dart';
import 'package:provider/provider.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String img;

  UserProductItem({this.id, this.title, this.img});

  @override
  Widget build(BuildContext context) {
    final deleteProducts  = Provider.of<ProductController>(context,listen: false);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(img),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(icon: Icon(Icons.edit), onPressed: () {
              Navigator.of(context).pushNamed(MangeProductScreen.routeId,arguments: id);
            }),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                deleteProducts.deleteProduct(id);
              },
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
