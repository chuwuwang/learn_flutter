import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class TutorialCoachMarkPage extends StatefulWidget {

  static final String routePath = '/open-source/tutorial-coach-mark';

  const TutorialCoachMarkPage( { super.key } );

  @override
  State<StatefulWidget> createState() {
    return _TutorialCoachMarkPageState();
  }

}

class _TutorialCoachMarkPageState extends State<TutorialCoachMarkPage> {

  late TutorialCoachMark tutorialCoachMark;

  GlobalKey keyButton = GlobalKey();
  GlobalKey keyBottomNavigation1 = GlobalKey();
  GlobalKey keyBottomNavigation2 = GlobalKey();
  GlobalKey keyBottomNavigation3 = GlobalKey();

  @override
  void initState() {
    createTutorial();
    Future.delayed(Duration.zero, showTutorial);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var content = _createContent();
    var children = [content];
    var stack = Stack(children: children);
    var bottomNavigationBar = _createNavigationBar();

    var style = const TextStyle(
        color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold);
    var text = Text("Tutorial Coach Mark", style: style);
    var iconThemeData = const IconThemeData(color: Colors.white);
    var appBar = AppBar(title: text, iconTheme: iconThemeData, backgroundColor: Colors.blue);
    return Scaffold(appBar: appBar, body: stack, bottomNavigationBar: bottomNavigationBar);
  }

  void showTutorial() {
    tutorialCoachMark.show(context: context);
  }

  void createTutorial() {
    onSkip() {
      print("onSkip");
      return true;
    }
    onFinish() {
      print("onFinish");
    }
    onClickTarget(target) {
      print('onClickTarget: $target');
    }
    onClickOverlay(target) {
      print('onClickOverlay: $target');
    }
    onClickTargetWithTapPosition(target, tapDetails) {
      print("onClickTargetWithTapPosition target: $target");
    }
    tutorialCoachMark = TutorialCoachMark(
      targets: _createTargets(),
      colorShadow: Colors.red,
      textSkip: "SKIP",
      paddingFocus: 10,
      opacityShadow: 0.5,
      imageFilter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
      onSkip: onSkip,
      onFinish: onFinish,
      onClickTarget: onClickTarget,
      onClickOverlay: onClickOverlay,
      onClickTargetWithTapPosition: onClickTargetWithTapPosition);
  }

  List<TargetFocus> _createTargets() {
    var bottomNavigation1 = TargetFocus(
      identify: "keyBottomNavigation1",
      keyTarget: keyBottomNavigation1,
      enableOverlayTab: true,
      alignSkip: Alignment.topRight,
      contents: _createTargetContent("Tutorial lorem ipsum"),
    );
    var bottomNavigation2 = TargetFocus(
      identify: "keyBottomNavigation2",
      keyTarget: keyBottomNavigation2,
      alignSkip: Alignment.topRight,
      contents: _createTargetContent("Tutorial lorem ipsum"),
    );
    var bottomNavigation3 = TargetFocus(
      identify: "keyBottomNavigation3",
      keyTarget: keyBottomNavigation3,
      alignSkip: Alignment.topRight,
      contents: _createTargetContent("Tutorial lorem ipsum"),
    );

    var textStyle = const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20.0,);
    var text = Text("Tutorial center again", style: textStyle);

    var paddingStyle = TextStyle(color: Colors.white);
    var paddingText = Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pulvinar tortor eget maximus iaculis.", style: paddingStyle);
    var padding = Padding(padding: EdgeInsets.only(top: 10.0), child: paddingText);

    builder(context, controller) {
      onPressed() {
        controller.previous();
      }
      var icon = const Icon(Icons.chevron_left);
      var button = ElevatedButton(onPressed: onPressed, child: icon);
      var children = [text, padding, button];
      return Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: children);
    }

    var targetContent = TargetContent(align: ContentAlign.bottom, builder: builder);
    var keyButtonTarget = TargetFocus(
      identify: "Target 1",
      keyTarget: keyButton,
      radius: 5,
      color: Colors.purple,
      contents: [targetContent],
      shape: ShapeLightFocus.RRect,
    );

    List<TargetFocus> targets = [bottomNavigation1, bottomNavigation2, bottomNavigation3, keyButtonTarget];
    return targets;
  }

  List<TargetContent> _createTargetContent(String data) {
    var textStyle = TextStyle(color: Colors.white);
    var text = Text(data, style: textStyle);
    var children = [text];
    var column = Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: children);
    builder(context, controller) {
      return column;
    }
    var targetContent = TargetContent(align: ContentAlign.top, builder: builder);
    return [targetContent];
  }


  //////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////

  Widget _createContent() {
    onPressed() {
      showTutorial();
    }
    var icon = const Icon(Icons.remove_red_eye);
    var button = ElevatedButton(onPressed: onPressed, child: icon);
    var align = Align(alignment: Alignment.center, child: button);
    var container = Container(key: keyButton, color: Colors.blue, height: 100, width: MediaQuery.of(context).size.width - 50, child: align);
    var child = Align(alignment: Alignment.topCenter, child: container);

    var padding = const EdgeInsets.only(top: 100.0);
    return Padding(padding: padding, child: child);
  }

  Widget _createNavigationBar() {
    var navigation1 = SizedBox(key: keyBottomNavigation1, height: 40, width: 40);
    var bottomNavigation1 = _center(navigation1);
    var navigation2 = SizedBox(key: keyBottomNavigation2, height: 40, width: 40);
    var bottomNavigation2 = _center(navigation2);
    var navigation3 = SizedBox(key: keyBottomNavigation3, height: 40, width: 40);
    var bottomNavigation3 = _center(navigation3);
    var rowChild = [bottomNavigation1, bottomNavigation2, bottomNavigation3];
    var row = Row(children: rowChild);
    var sizedBox = SizedBox(height: 50, child: row);
    var navigationBarItem = _createNavigationBarItem();
    var stackChild = [sizedBox, navigationBarItem];
    return Stack(children: stackChild);
  }

  Widget _createNavigationBarItem() {
    var home = const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home');
    var business = const BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Business');
    var school = const BottomNavigationBarItem(icon: Icon(Icons.school), label: 'School');
    var items = <BottomNavigationBarItem>[home, business, school];
    var selectedItemColor = Colors.amber[800];
    return BottomNavigationBar(onTap: (index) { }, items: items, selectedItemColor: selectedItemColor);
  }

  Widget _center(Widget child) {
    var center = Center(child: child);
    return Expanded(child: center);
  }

}