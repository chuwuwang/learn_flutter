import 'package:flutter/material.dart';

abstract class BaseStatelessWidget extends StatelessWidget {

  const BaseStatelessWidget( { super.key });

  String getTitleText() {
    return "";
  }

  Widget onBuildWidget(BuildContext context);

  @override
  Widget build(BuildContext context) {
    var titleText = getTitleText();
    var textStyle = const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold,);
    var title = Text(titleText, style: textStyle);

    var iconThemeData = const IconThemeData(color: Colors.white);
    var appBar = AppBar(title: title, iconTheme: iconThemeData, backgroundColor: Colors.blue,);

    var body = onBuildWidget(context);
    return Scaffold(appBar: appBar, body: body);
  }

}