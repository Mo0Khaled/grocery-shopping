import 'package:flutter/material.dart';
import 'package:grocery_shopping/providers/cartController.dart';
import 'package:grocery_shopping/providers/product_provider.dart';
import 'package:provider/provider.dart';

class ProductDetailsWidgets extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final products = Provider.of<ProductController>(context, listen: false)
        .findById(productId);
    final cartPro = Provider.of<CartController>(context,listen: true);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 280,
          width: double.infinity,
          margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Image.network(
            products.img,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
        ),
        Container(
          width: 50,
          height: 20,
          color: Colors.grey.withOpacity(.3),
          child: Text(
            "${products.price}G",
            style: TextStyle(
                fontSize: 14,
                color: Color(0xFF6E7989),
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          products.title,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 20,
        ),
        // make stars rating
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                icon: Icon(
                  Icons.star,
                  size: 30,
                ),
                onPressed: () {}),
            IconButton(
                icon: Icon(
                  Icons.star,
                  size: 30,
                ),
                onPressed: () {}),
            IconButton(
                icon: Icon(
                  Icons.star,
                  size: 30,
                ),
                onPressed: () {}),
            IconButton(
                icon: Icon(
                  Icons.star,
                  size: 30,
                ),
                onPressed: () {}),
            IconButton(
                icon: Icon(
                  Icons.star,
                  size: 30,
                ),
                onPressed: () {}),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "Quantity",
          style: TextStyle(
              color: Color(0xFF99A0B0),
              fontSize: 25,
              fontWeight: FontWeight.w500),
        ),
        // make buttons to add and remove quantity
        Container(
          width: MediaQuery.of(context).size.width * 0.60,
          height: MediaQuery.of(context).size.height * 0.1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Material(
                color: Colors.transparent,
                child: Center(
                  child: Ink(
                    decoration: const ShapeDecoration(
                      color: Color(0xff99A0B0),
                      shape: CircleBorder(),
                    ),
                    child: IconButton(
                        icon: Icon(
                          Icons.remove,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          cartPro.removeOne(productId);
                        },),
                  ),
                ),
              ),
              Text(
               cartPro.products.containsKey(products.id) ? cartPro.getQuantity.toStringAsFixed(1) : 0.0.toString(),
                style: TextStyle(fontSize: 30),
              ),
              Material(
                color: Colors.transparent,
                child: Center(
                  child: Ink(
                    decoration: const ShapeDecoration(
                      color: Color(0xff99A0B0),
                      shape: CircleBorder(),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        cartPro.addOne(products.id,products.price,products.title,products.img);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Column(
          children: [
            Container(
              width: 144,
              height: 40,
              child: RaisedButton(
                color: Color(0xFF29C17E),
                textColor: Colors.white,
                onPressed: () {},
                child: Text(
                  'BUY NOW',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            FlatButton(
              child: Text(
                'ADD TO CART',
                style: TextStyle(color: Color(0xFF29C17E), fontSize: 18),
              ),
              onPressed: () {
                cartPro.addItem(products.id,products.price, products.title,products.img,products.discount);
              },
            ),
          ],
        ),
      ],
    );
  }
}
