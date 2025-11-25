import 'package:flutter/material.dart';

class ConvexBottomBarHomePage extends StatelessWidget {

  static final String routePath = '/open-source/convex-bottom-bar/home';

  const ConvexBottomBarHomePage( { super.key } );

  @override
  Widget build(BuildContext context) {
    var text = const Text('Home Page');
    return Center(child: text);
  }

}