import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learn_flutter/generated/l10n.dart';
import 'package:learn_flutter/services/location_service.dart';
import 'package:learn_flutter/ui/basic_widget/basic_widget_page.dart';
import 'package:learn_flutter/ui/open_source/open_source_page.dart';
import 'package:learn_flutter/utils/color_utils.dart';

class HomePage extends StatefulWidget {

  static const String routePath = '/home';

  const HomePage( { super.key } );

  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage>{

  @override
  Widget build(BuildContext context) {
    onValue(position) { }
    LocationService.getLocation().then(onValue);

    var style = const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold);
    var text = Text("Flutter Learn", style: style);
    var appBar = AppBar(title: text, backgroundColor: Colors.blue);
    var body = _mainView(context);
    var scaffold = Scaffold(appBar: appBar, body: body);
    return MaterialApp(home: scaffold);
  }

  _mainView(BuildContext context) {
    emptyAction() => {};
    openSourceAction() => { context.push(OpenSourcePage.routePath) };
    basicWidgetAction() => { context.push(BasicWidgetPage.routePath) };

    var animationString = S.of(context).home_tab_animation;
    var openSourceString = S.of(context).home_tab_open_source;
    var basicWidgetString = S.of(context).home_tab_basic_widget;
    var deviceFeatureString = S.of(context).home_tab_device_feature;

    List<Widget> child1st = [
      _tabItem(basicWidgetString, ColorUtils.basicWidgetColor, basicWidgetAction),
      _tabItem(deviceFeatureString, ColorUtils.devicesFeaturesColor, emptyAction),
    ];
    var row1st = Row(children: child1st);

    List<Widget> child2st = [
      _tabItem(animationString, ColorUtils.animationColor, emptyAction),
      _tabItem(openSourceString, ColorUtils.openSourceColor, openSourceAction),
    ];
    var row2st = Row(children: child2st);

    List<Widget> children = [row1st, row2st];
    var column = Column(children: children);
    var container = Container(padding: const EdgeInsets.all(8), child: column);
    return SingleChildScrollView(child: container);
  }

  _tabItem(String text, Color color, VoidCallback onPressed) {
    var borderRadius = BorderRadius.circular(8);
    var roundedRectangleBorder = RoundedRectangleBorder(borderRadius: borderRadius);
    var textStyle = const TextStyle(color: Colors.white, fontSize: 18);
    var textView = Text(text, style: textStyle);
    MaterialButton button;
    if (text.isEmpty) {
      button = MaterialButton(color: color, onPressed: onPressed, shape: roundedRectangleBorder, elevation: 0, child: textView);
    } else {
      button = MaterialButton(color: color, onPressed: onPressed, shape: roundedRectangleBorder, child: textView);
    }
    var container = Container(height: 112, margin: const EdgeInsets.fromLTRB(4, 4, 4, 4), child: button);
    return Expanded(flex: 1, child: container);
  }

}