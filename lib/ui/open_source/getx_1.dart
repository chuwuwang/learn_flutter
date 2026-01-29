import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class CounterController extends GetxController {

  var count = 0.obs;

  void increment() {
    count++;
  }

}

class GetX1 extends StatelessWidget {

  final controller = Get.put( CounterController() );

  GetX1( { super.key } );

  @override
  Widget build(BuildContext context) {
    var textStyle = const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold,);
    var titleText = Text("GetX Example1", style: textStyle);

    var iconThemeData = const IconThemeData(color: Colors.white);
    var appBar = AppBar(title: titleText, iconTheme: iconThemeData, backgroundColor: Colors.blue,);

    var icon = Icon(Icons.add);
    var floatingActionButton = FloatingActionButton(onPressed: controller.increment, child: icon);

    var style = TextStyle(fontSize: 24);
    var child = Obx( () =>
        Text('点击了 ${controller.count} 次', style: style)
    );
    var center = Center(child: child);

    return Scaffold(appBar: appBar, body: center, floatingActionButton: floatingActionButton);
  }

}