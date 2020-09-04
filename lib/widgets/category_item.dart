import 'package:flutter/material.dart';
import 'package:grocery_shopping/screens/category_screen.dart';

class CategoryWidget extends StatelessWidget {
  final String id;
  final String title;
  final IconData icon;

  CategoryWidget({this.id, this.title, this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12,right: 12,top: 10),
      child: Row(
        children: [
          Column(
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context)
                    .pushNamed(CategoryScreen.routeId, arguments: id),
                child: CircleAvatar(
                  child: Icon(icon,color: Color(0xFF29C17E),size: 30,),
                  radius: 35,
                  backgroundColor: Color(0xFFBEF1C9),
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Text(title,overflow: TextOverflow.ellipsis,),
            ],
          ),
        ],
      ),
    );
  }
}
