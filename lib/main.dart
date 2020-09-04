import 'package:flutter/material.dart';
import 'file:///F:/work/fluter/grocery_shopping/lib/providers/auth.dart';
import 'package:grocery_shopping/providers/cartController.dart';
import 'package:grocery_shopping/providers/category_provider.dart';
import 'package:grocery_shopping/providers/order_controller.dart';
import 'package:grocery_shopping/providers/product_provider.dart';
import 'package:grocery_shopping/screens/cart_screen.dart';
import 'package:grocery_shopping/screens/category_screen.dart';
import 'package:grocery_shopping/screens/fav_screen.dart';
import 'package:grocery_shopping/screens/mange_product_screen.dart';
import 'package:grocery_shopping/screens/notification_screen.dart';
import 'package:grocery_shopping/screens/product_details.dart';
import 'package:grocery_shopping/screens/user_product_screen.dart';
import 'package:grocery_shopping/widgets/tab_bar_homepage.dart';
import 'package:provider/provider.dart';
import 'screens/auth_screen.dart';

void main() => runApp(GroceryShopping());

class GroceryShopping extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => OrderController(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => CategoryController(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => CartController(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => ProductController(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: Color(0xFFF4F7FA),
            primaryColor: Color(0xFF29C17E),
            appBarTheme: AppBarTheme(
              elevation: 0,
              textTheme: TextTheme(
                // ignore: deprecated_member_use
                title: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
              iconTheme: IconThemeData(color: Colors.white),
            ),
          ),
//home: Messaging(),
          home: auth.isAuth != null
              ? TabBarHomePage()
              : FutureBuilder(
//            future: auth.tryLogin(),
                  builder: (context, snapshot) =>
                      snapshot.connectionState == ConnectionState.waiting
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : AuthScreen(),
                ),
          initialRoute: TabBarHomePage.routeId,
          routes: {
            TabBarHomePage.routeId: (context) => TabBarHomePage(),
            ProductDetails.routeId: (context) => ProductDetails(),
            CartScreen.routeId: (context) => CartScreen(),
            CategoryScreen.routeId: (context) => CategoryScreen(),
            MangeProductScreen.routeId: (context) => MangeProductScreen(),
            UserProductScreen.routeId: (context) => UserProductScreen(),
            AuthScreen.routeId: (context) => AuthScreen(),
            FavoriteScreen.routeId: (context) => FavoriteScreen(),
            NotificationsScreen.routeId: (context) => NotificationsScreen(),
          },
        ),
      ),
    );
  }
}
