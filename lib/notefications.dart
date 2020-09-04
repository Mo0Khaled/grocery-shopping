import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class Messaging extends StatefulWidget {
  @override
  _MessagingState createState() => _MessagingState();
}

class _MessagingState extends State<Messaging> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  @override
  void initState() {
    subscripeToAdmin();
    getDeviceToken();
    configureCallback();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }

  void configureCallback() {
    _firebaseMessaging.configure(
      onMessage: (message)async{
        print("on message : $message");
      },
      onResume: (message)async{
        print("on Resume : $message");
      },
      onLaunch: (message)async{
//        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>TestScreen()),);
      },
    );

  }

  void getDeviceToken()async {
   String deviceToken = await _firebaseMessaging.getToken();
   print("dev :$deviceToken");
  }

  void subscripeToAdmin() {
    _firebaseMessaging.subscribeToTopic('Admin');
  }
}
