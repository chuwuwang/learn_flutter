import 'package:flutter/material.dart';
import 'package:learn_flutter/app_router_config.dart';

void main() {
  var app = const MyApp();
  runApp(app);
}

class MyApp extends StatelessWidget {

  const MyApp( { super.key } );

  @override
  Widget build(BuildContext context) {
    var colorScheme = ColorScheme.fromSeed(seedColor: Colors.deepPurple);
    var materialApp = MaterialApp.router(
      title: 'Flutter Learn',
      theme: ThemeData(colorScheme: colorScheme),
      routerConfig: AppRouterConfig.router);
    return materialApp;
  }

}