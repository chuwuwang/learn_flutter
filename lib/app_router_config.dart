import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learn_flutter/ui/home_page.dart';

class AppRouterConfig {

  static var routes = <GoRoute>[
    GoRoute(builder: (BuildContext context, GoRouterState state) => HomePage(), path: HomePage.routePath),
  ];

  static GoRouter router = GoRouter(initialLocation: HomePage.routePath, routes: routes);

}