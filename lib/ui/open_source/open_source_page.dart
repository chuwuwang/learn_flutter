import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:learn_flutter/ui/base_state.dart';
import 'package:learn_flutter/ui/open_source/skeletonizer_page.dart';
import 'package:learn_flutter/utils/ktx_widget_utils.dart';

import 'convex_bottom_bar_home_page.dart';

class OpenSourcePage extends StatefulWidget {

  static final String routePath = '/open-source';

  const OpenSourcePage( { super.key } );

  @override
  State<StatefulWidget> createState() => _OpenSourcePageState();

}

class _OpenSourcePageState extends BaseState<OpenSourcePage> {

  @override
  String getTitleText() => "Open Source";

  @override
  Widget onBuildWidget(BuildContext context) {
    emptyAction() => {};

    skeletonizerAction() => { context.push(SkeletonizerPage.routePath) };
    convexBottomBarAction() => { context.push(ConvexBottomBarHomePage.routePath) };

    List<Widget> children = [
      KTXWidgetUtils.sampleItemView("Convex BottomBar", true, convexBottomBarAction),
      KTXWidgetUtils.sampleItemView("Skeletonizer 骨架屏", true, skeletonizerAction),
    ];

    var column = Column(children: children);
    var container = Container(child: column);
    return SingleChildScrollView(child: container);
  }

}