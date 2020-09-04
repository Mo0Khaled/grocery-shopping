import 'package:flutter/material.dart';
import 'package:grocery_shopping/providers/cartController.dart';
import 'package:grocery_shopping/providers/order_controller.dart';
import 'package:grocery_shopping/widgets/cart_item_widget.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routeId = '/cart-screen';


  @override
  Widget build(BuildContext context) {
    final orderPro = Provider.of<OrderController>(context, listen: false);
    final cart = Provider.of<CartController>(context, listen: false);

    return Scaffold(
      body: Consumer<CartController>(
        builder:(context,cartPro,_) =>cartPro.products.length ==0 ? Center(child: Text("No Items")): ListView.builder(
          itemBuilder: (context, index) => CartItemWidget(
            id: cartPro.products.values.toList()[index].id,
            title: cartPro.products.values.toList()[index].title,
            img: cartPro.products.values.toList()[index].img,
            price: cartPro.products.values.toList()[index].price,
            quantity: cartPro.products.values.toList()[index].quantity,
            productId: cartPro.products.keys.toList()[index],
          ),
          itemCount: cartPro.products.length,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF29C17E),
        child: Text("Order"),
        onPressed: () async{
          await orderPro.addOrder(cart.products.values.toList(), cart.totalAmount);
          cart.clear();
          Scaffold.of(context).showSnackBar(SnackBar(content: Text("Order Done"),));
        },
      ),
    );
  }
}
