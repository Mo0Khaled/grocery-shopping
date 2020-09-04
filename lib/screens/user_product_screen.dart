import 'package:flutter/material.dart';
import 'package:grocery_shopping/providers/product_provider.dart';
import 'package:grocery_shopping/screens/mange_product_screen.dart';
import 'package:grocery_shopping/widgets/user_product_item.dart';
import 'package:provider/provider.dart';

class UserProductScreen extends StatelessWidget {
  static const routeId = '/user-product';
  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<ProductController>(context, listen: false)
        .fetchData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Products"),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(MangeProductScreen.routeId);
              },
            ),
          ],
        ),
          body:FutureBuilder(
            future: _refreshProducts(context),
            builder: (context,snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (snapshot.error != null) {
                  return Center(
                    child: Text("error"),
                  );
                } else {
                  return RefreshIndicator(
                    onRefresh: ()=>_refreshProducts(context),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Consumer<ProductController>(
                        builder:  (context,productData,_) =>
                            ListView.builder(
                              itemBuilder: (context, index) => Column(
                                children: <Widget>[
                                  UserProductItem(
                                    id: productData.products[index].id,
                                    title: productData.products[index].title,
                                    img: productData.products[index].img,
                                  ),
                                  Divider(),
                                ],
                              ),
                              itemCount: productData.products.length,
                            ),
                      ),
                    ),
                  );
                }
              }
            }

        ),
       );

  }
}
