
import 'package:flutter/material.dart';
import 'package:grocery_shopping/models/product.dart';
import 'package:grocery_shopping/providers/product_provider.dart';
import 'package:grocery_shopping/screens/product_details.dart';
import 'package:provider/provider.dart';

class Searching extends SearchDelegate<ProductModel>{

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
   return [IconButton(icon: Icon(Icons.close), onPressed: (){
     query = '';
   }),];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
      close(context, null);
    });
  }

  @override
  // ignore: missing_return
  Widget buildResults(BuildContext context) {

  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final myList = Provider.of<ProductController>(context);
    var searchList = query.isEmpty ? myList.products : myList.searchProduct(query);
    return ListView.builder(itemCount: searchList.length , itemBuilder: (context,index) {
      return ListTile(
        title: Text(searchList[index].title),
        subtitle: Text(searchList[index].categoryId),
        leading: CircleAvatar(backgroundImage: NetworkImage(searchList[index].img),),
        onTap: (){
         Navigator.of(context).pushNamed(ProductDetails.routeId,arguments: searchList[index].id);
        },
      );
    });
  }

}