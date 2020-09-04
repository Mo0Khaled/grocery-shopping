import 'package:flutter/material.dart';

class NotificationItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(15),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListTile(
          title: Text("Fresh Food Fiesta"),
          subtitle: Text("23rd - 30th November on selected Vegitables, Fruits, Fish & Meats."),
          trailing: Text("4 min ago",style: TextStyle(color: Color(0xff29C17E)),),
          leading: CircleAvatar(
            child: Icon(Icons.notifications,color: Color(0xFF29C17E),size: 25,),
            radius: 25,
            backgroundColor: Color(0xFFBEF1C9),
          ),
        ),
      ),
    );
  }
}
