import 'package:flutter/material.dart';
import 'file:///F:/work/fluter/grocery_shopping/lib/providers/auth.dart';
import 'package:grocery_shopping/screens/auth_screen.dart';
import 'package:grocery_shopping/screens/user_product_screen.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key key,
    this.elevation = 16.0,
    this.child,
    this.semanticLabel,
  })  : assert(elevation != null && elevation >= 0.0),
        super(key: key);
  final double elevation;
  final Widget child;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    String label = semanticLabel;
    switch (Theme.of(context).platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        label = semanticLabel;
        break;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        label = semanticLabel ?? MaterialLocalizations.of(context)?.drawerLabel;
    }
    return Semantics(
      scopesRoute: true,
      namesRoute: true,
      explicitChildNodes: true,
      container: true,
      label: label,
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.75,
          constraints: const BoxConstraints(minWidth: double.infinity),
          child: SafeArea(
            child: Material(
              elevation: elevation,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () => Navigator.of(context).pop()),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Grocery shopping',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    buildListDrawer(
                      title: "Order History",
                      iconData: Icons.wallpaper,
                      onPressed: () {},
                    ),
                    buildListDrawer(
                      title: "Track Orders",
                      iconData: Icons.add_location,
                      onPressed: () {},
                    ),
                    buildListDrawer(
                      title: "Currency",
                      iconData: Icons.monetization_on,
                      onPressed: () {},
                    ),
                    buildListDrawer(
                      title: "Store Locator",
                      iconData: Icons.store_mall_directory,
                      onPressed: () {},
                    ),
                    buildListDrawer(
                      title: "Terms & Conditions",
                      iconData: Icons.warning,
                      onPressed: () =>Navigator.of(context)
                          .pushNamed(AuthScreen.routeId),
                    ),
//                    buildListDrawer(
//                      title: "Help",
//                      iconData: Icons.help,
//                      onPressed: () => Navigator.of(context)
//                          .pushNamed(AddCategoryScreen.routeId),
//                    ),
                    buildListDrawer(
                      title: "Mange",
                      iconData: Icons.cloud_download,
                      onPressed: () => Navigator.of(context)
                          .pushNamed(UserProductScreen.routeId),
                    ),
                    buildListDrawer(
                      title: "Logout",
                      iconData: Icons.exit_to_app,
                      onPressed: () async{
                        await Provider.of<Auth>(context,listen: false).signOut();
                        Navigator.of(context).pushReplacementNamed(AuthScreen.routeId);
                      },
                    ),
                  ],
                ),
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row buildListDrawer({String title, IconData iconData, Function onPressed}) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Material(
            color: Colors.transparent,
            child: Center(
              child: Ink(
                decoration: const ShapeDecoration(
                  color: Color(0xFF29C17E),
                  shape: CircleBorder(),
                ),
                child: IconButton(
                  icon: Icon(
                    iconData,
                    color: Colors.white,
                  ),
                  onPressed: onPressed,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
