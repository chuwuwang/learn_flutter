import 'package:flutter/material.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {

  String getTitleText() {
    return "";
  }

  Widget onBuildWidget(BuildContext context);

  @override
  Widget build(BuildContext context) {
    var style = const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold);
    var titleText = getTitleText();
    var text = Text(titleText, style: style);
    var iconThemeData = const IconThemeData(color: Colors.white);
    var appBar = AppBar(title: text, iconTheme: iconThemeData, backgroundColor: Colors.blue);
    var body = onBuildWidget(context);
    return Scaffold(appBar: appBar, body: body);
  }

}