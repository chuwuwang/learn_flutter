import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learn_flutter/ui/base_state.dart';
import 'package:learn_flutter/ui/basic_widget/customize_tab_page.dart';
import 'package:learn_flutter/utils/ktx_widget_utils.dart';

class BasicWidgetPage extends StatefulWidget {

  static final String routePath = '/basic-widget';

  const BasicWidgetPage( { super.key } );

  @override
  State<BasicWidgetPage> createState() => _BasicWidgetPageState();

}

class _BasicWidgetPageState extends BaseState<BasicWidgetPage> {

  @override
  getTitleText() => "Basic Widget";

  @override
  Widget onBuildWidget(BuildContext context) {
    emptyAction() => {};
    customizeTabAction() => { context.push(CustomizeTabPage.routePath) };
    List<Widget> children = [
      KTXWidgetUtils.sampleItemView("Customize Tab", true, customizeTabAction),
    ];
    var column = Column(children: children);
    var container = Container(child: column);
    return SingleChildScrollView(child: container);
  }

}