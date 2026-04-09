import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learn_flutter/ui/animation/login/login_page.dart';
import 'package:learn_flutter/ui/base_state.dart';
import 'package:learn_flutter/utils/ktx_widget_utils.dart';

class BasicAnimationPage extends StatefulWidget {

  static final String routePath = '/basic-animation';

  const BasicAnimationPage( { super.key } );

  @override
  State<BasicAnimationPage> createState() => _BaseAnimationPageState();

}

class _BaseAnimationPageState extends BaseState<BasicAnimationPage> {

  @override
  getTitleText() => "Basic Animation";

  @override
  Widget onBuildWidget(BuildContext context) {
    emptyAction() => { };
    loginAction() => { context.push(LoginPage.routePath) };

    List<Widget> children = [
      KTXWidgetUtils.sampleItemView("Login Animation", true, loginAction),
    ];

    var column = Column(children: children);
    var container = Container(child: column);
    return SingleChildScrollView(child: container);
  }

}