import 'package:flutter/material.dart';
import 'package:grocery_shopping/providers/category_provider.dart';
import 'package:grocery_shopping/widgets/category_item.dart';
import 'package:provider/provider.dart';

class CategoriesContainer extends StatefulWidget {
  @override
  _CategoriesContainerState createState() => _CategoriesContainerState();
}

class _CategoriesContainerState extends State<CategoriesContainer> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedContainer(
//          width: selected ? 200.0 : 100.0,
          height: selected ?MediaQuery.of(context).size.height * 0.50 : MediaQuery.of(context).size.height * 0.20,
          curve: Curves.fastOutSlowIn,
          duration: Duration(seconds: 2),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.20,
            width: double.infinity,
//                    color: Colors.black,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("All Categories",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                ),
                Flexible(
                  child: Consumer<CategoryController>(
                    builder: (context, catPro, _) => GridView.builder(
                      itemCount: catPro.categories.length,
                      itemBuilder: (context, index) => CategoryWidget(
                        id: catPro.categories[index].id,
                        title: catPro.categories[index].title,
                        icon: catPro.categories[index].icon,
                      ),
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 137,
                        mainAxisSpacing: 10,
                      ),
//                      scrollDirection: Axis.,
//                      itemExtent: 120,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
//          height:120,
          top: selected ? MediaQuery.of(context).size.height * 0.40: MediaQuery.of(context).size.width * 00.25,
          left: MediaQuery.of(context).size.width * 00.40,
          child: IconButton(
            icon: Icon(
              selected ? Icons.keyboard_arrow_up:Icons.keyboard_arrow_down,
              size: 60,
              color: Colors.grey,
            ),
            onPressed: () {
              setState(() {
                selected = !selected;
              });
            },
          ),
        ),
      ],
    );
  }
}
