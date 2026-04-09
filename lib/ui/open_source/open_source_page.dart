import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:learn_flutter/ui/base_state.dart';
import 'package:learn_flutter/ui/open_source/get_x_example1_page.dart';
import 'package:learn_flutter/ui/open_source/skeletonizer_page.dart';
import 'package:learn_flutter/ui/open_source/tutorial_coach_mark_page.dart';
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
    emptyAction() => { };
    getXExample1Action() => { context.push(GetXExample1.routePath) };
    skeletonizerAction() => { context.push(SkeletonizerPage.routePath) };
    convexBottomBarAction() => { context.push(ConvexBottomBarHomePage.routePath) };
    tutorialCoachMarkAction() => { context.push(TutorialCoachMarkPage.routePath) };

    List<Widget> children = [
      KTXWidgetUtils.sampleItemView("Convex BottomBar", true, convexBottomBarAction),
      KTXWidgetUtils.sampleItemView("Skeletonizer 骨架屏", true, skeletonizerAction),
      KTXWidgetUtils.sampleItemView("Tutorial Coach Mark", true, tutorialCoachMarkAction),
      KTXWidgetUtils.sampleItemView("GetX Example1", true, getXExample1Action),
    ];

    var column = Column(children: children);
    var container = Container(child: column);
    return SingleChildScrollView(child: container);
  }

}