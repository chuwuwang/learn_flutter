import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learn_flutter/ui/basic_widget/basic_widget_page.dart';
import 'package:learn_flutter/ui/basic_widget/compare_slider_page.dart';
import 'package:learn_flutter/ui/basic_widget/customize_tab_page.dart';
import 'package:learn_flutter/ui/basic_widget/seamless_scrolling_page.dart';
import 'package:learn_flutter/ui/home_page.dart';
import 'package:learn_flutter/ui/open_source/convex_bottom_bar_home_page.dart';
import 'package:learn_flutter/ui/open_source/convex_bottom_bar_mine_page.dart';
import 'package:learn_flutter/ui/open_source/convex_bottom_bar_page.dart';
import 'package:learn_flutter/ui/open_source/convex_bottom_bar_space_page.dart';
import 'package:learn_flutter/ui/open_source/open_source_page.dart';

class AppRouterConfig {

  static var routes = [
    GoRoute(builder: (BuildContext context, GoRouterState state) => HomePage(), path: HomePage.routePath),

    GoRoute(builder: (BuildContext context, GoRouterState state) => BasicWidgetPage(), path: BasicWidgetPage.routePath),
    GoRoute(builder: (BuildContext context, GoRouterState state) => CustomizeTabPage(), path: CustomizeTabPage.routePath),
    GoRoute(builder: (BuildContext context, GoRouterState state) => SeamlessScrollingPage(), path: SeamlessScrollingPage.routePath),
    GoRoute(builder: (BuildContext context, GoRouterState state) => CompareSliderPage(), path: CompareSliderPage.routePath),

    GoRoute(builder: (BuildContext context, GoRouterState state) => OpenSourcePage(), path: OpenSourcePage.routePath),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ConvexBottomBarPage(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch( routes: [ GoRoute(builder: (context, state) => const ConvexBottomBarHomePage(), path: ConvexBottomBarHomePage.routePath) ] ),
        StatefulShellBranch( routes: [ GoRoute(builder: (context, state) => const ConvexBottomBarSpacePage(), path: ConvexBottomBarSpacePage.routePath) ] ),
        StatefulShellBranch( routes: [ GoRoute(builder: (context, state) => const ConvexBottomBarMinePage(), path: ConvexBottomBarMinePage.routePath) ] ),
      ],
    ),

  ];

  static GoRouter router = GoRouter(initialLocation: HomePage.routePath, routes: routes);

}