import 'package:flutter/material.dart';
import 'package:grocery_shopping/providers/cartController.dart';
import 'package:provider/provider.dart';

class CartItemWidget extends StatelessWidget {
  final String id;
  final String productId;
  final String title;
  final String img;
  final double price;
  final double quantity;

  CartItemWidget({
    this.id,
    this.productId,
    this.title,
    this.img,
    this.price,
    this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    final dismissProdCart = Provider.of<CartController>(context,listen: false);
    var total = (price ) * quantity;
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          size: 40,
          color: Colors.white,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) => dismissProdCart.removeItems(productId),
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Remove"),
            content: Text("Do You Want Remove It? "),
            actions: [
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text("No"),
              ),
              FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text("Yes"),
              ),
            ],
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          title: Text(title),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(img),
            backgroundColor: Colors.green.shade100,
            radius: 30,
          ),
          subtitle: Text(total.toStringAsFixed(2)),
          trailing: Container(
            height: 50,
            width: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: ()=> dismissProdCart.removeOne(productId),
                  child: Icon(
                    Icons.remove,
                    size: 25,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  "${quantity.toStringAsFixed(1)}Kg",
                  style: TextStyle(fontSize: 18),
                ),
                GestureDetector(
                  onTap: ()=> dismissProdCart.addOne(productId,price,title,img),
                  child: Icon(
                    Icons.add,
                    size: 25,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
