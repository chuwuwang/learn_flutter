import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learn_flutter/ui/basic_widget/basic_widget_page.dart';
import 'package:learn_flutter/ui/basic_widget/customize_tab_page.dart';
import 'package:learn_flutter/ui/home_page.dart';

class AppRouterConfig {

  static var routes = <GoRoute>[
    GoRoute(builder: (BuildContext context, GoRouterState state) => HomePage(), path: HomePage.routePath),

    GoRoute(builder: (BuildContext context, GoRouterState state) => BasicWidgetPage(), path: BasicWidgetPage.routePath),
    GoRoute(builder: (BuildContext context, GoRouterState state) => CustomizeTabPage(), path: CustomizeTabPage.routePath),

  ];

  static GoRouter router = GoRouter(initialLocation: HomePage.routePath, routes: routes);

}