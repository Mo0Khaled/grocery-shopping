import 'package:flutter/material.dart';
import 'file:///F:/work/fluter/grocery_shopping/lib/models/product.dart';
import 'package:grocery_shopping/screens/product_details.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: Consumer<ProductModel>(
        builder: (context, productPro, ch) => Container(
//          width: 120,
//          height: 200,
          color: Colors.white,
          child: Card(
            elevation: 10,
            child: Stack(
              children: [
                Positioned(
                  top: MediaQuery.of(context).size.height * 000.04,
                  left: MediaQuery.of(context).size.width * 000.010,
//                alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: ()=>Navigator.of(context).pushNamed(ProductDetails.routeId,arguments: productPro.id),
                    child: Image.network(
                      productPro.img,
                      height: 120,
                      width: 150,
                      alignment: Alignment.center,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 9),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.11,
                        height: MediaQuery.of(context).size.height * 0.025,
                        color: Colors.grey.withOpacity(.3),
                        child: Text("${productPro.price}G",style: TextStyle(fontSize: 14,color: Color(0xFF6E7989),fontWeight: FontWeight.bold),),
                      ),
                      IconButton(
                        splashColor: Color(0xFF29C17E),
                        icon: Icon(
                          productPro.isFav
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Color(0xFF29C17E),
                        ),
                        onPressed: () => productPro.toggleFav(),
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 00.19,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(productPro.title,style: TextStyle(color:  Color(0xFF6E7989),fontWeight: FontWeight.bold,fontSize: 17),),
                        Text('Le ${productPro.price}',style: TextStyle(fontWeight: FontWeight.bold),),
                      ],
                    ),
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
