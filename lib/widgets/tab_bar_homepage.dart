import 'package:flutter/material.dart';
import 'package:grocery_shopping/providers/cartController.dart';
import 'package:grocery_shopping/screens/cart_screen.dart';
import 'package:grocery_shopping/screens/fav_screen.dart';
import 'package:grocery_shopping/screens/home_page.dart';
import 'package:grocery_shopping/screens/notification_screen.dart';
import 'package:grocery_shopping/widgets/app_drawer.dart';
import 'package:grocery_shopping/widgets/badge.dart';
import 'package:grocery_shopping/widgets/search.dart';
import 'package:provider/provider.dart';

class TabBarHomePage extends StatefulWidget {
  static const routeId = '/home-tab';

  @override
  _TabBarHomePageState createState() => _TabBarHomePageState();
}

class _TabBarHomePageState extends State<TabBarHomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text(
          'Store',
          style: TextStyle(color: Colors.white),
        ),
//        leading: IconButton(icon: Icon(Icons.drag_handle), onPressed: () {}),
        iconTheme: IconThemeData(color: Colors.white, size: 30),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {
            showSearch(context: context, delegate: Searching(),);
          }),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () =>
                Navigator.of(context).pushNamed(NotificationsScreen.routeId),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Color(0xFF29C17E),
              child: TabBar(
                unselectedLabelColor: Colors.black.withOpacity(0.3),
                indicatorColor: Colors.white,
                controller: _tabController,
                labelColor: Colors.white,
                labelPadding: const EdgeInsets.all(15.0),
                tabs: [
                  Icon(Icons.store_mall_directory),
                  Consumer<CartController>(
                    builder: (context, cartPro, child) => Badge(
                      value: cartPro.itemCount.toString(),
                      child: Icon(Icons.shopping_basket),
                    ),
                  ),
                  Icon(Icons.favorite_border),
                  Icon(Icons.person),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 136.0,
              padding: EdgeInsets.only(bottom: 0),
              child: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  HomePage(),
                  CartScreen(),
                  FavoriteScreen(),
                  CartScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
