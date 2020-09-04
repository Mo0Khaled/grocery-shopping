import 'package:flutter/material.dart';
import 'package:grocery_shopping/widgets/notification_item.dart';

class NotificationsScreen extends StatelessWidget {
  static const routeId= '/notification';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
        leading: IconButton(icon: Icon(Icons.close), onPressed: ()=>Navigator.of(context).pop()),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(Icons.notifications,size:25,),
          ),
        ],
      ),
      body: NotificationItem(),
    );
  }
}
