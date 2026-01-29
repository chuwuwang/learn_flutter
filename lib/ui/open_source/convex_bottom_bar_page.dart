import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ConvexBottomBarPage extends StatelessWidget {

  static final String routePath = '/open-source/convex-bottom-bar';

  final StatefulNavigationShell navigationShell;

  const ConvexBottomBarPage( { required this.navigationShell, super.key } );

  @override
  Widget build(BuildContext context) {
    var style = const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold);
    var text = Text("Convex BottomBar", style: style);

    var iconThemeData = const IconThemeData(color: Colors.white);
    var appBar = AppBar(title: text, iconTheme: iconThemeData, backgroundColor: Colors.blue);

    var items = const [
      TabItem(icon: Icons.home, title: 'Home'),
      TabItem(icon: Icons.map, title: 'Space'),
      TabItem(icon: Icons.wallet, title: 'Mine'),
    ];
    var bottomNavigationBar = ConvexAppBar(
      items: items,
      onTap: (int index) => navigationShell.goBranch(index),
    );

    return Scaffold(appBar: appBar, body: navigationShell, bottomNavigationBar: bottomNavigationBar);
  }

}