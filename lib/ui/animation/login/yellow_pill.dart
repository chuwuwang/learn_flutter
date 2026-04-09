import 'package:flutter/material.dart';
import 'package:learn_flutter/ui/animation/login/dot_eyes.dart';
import 'package:learn_flutter/ui/animation/login/line_mouth.dart';

/// 黄色较矮, 与黑小人脚底对齐, 高度控制在黑眼睛下沿之下, 避免层叠遮挡黑眼球.
class YellowPill extends StatelessWidget {

  const YellowPill( { super.key, required this.look } );

  final Offset look;

  @override
  Widget build(BuildContext context) {
    var boxShadow = BoxShadow(color: Color(0x33000000), offset: Offset(0, 5), blurRadius: 10);
    var boxDecoration = BoxDecoration(color: const Color(0xFFFFD54F), borderRadius: BorderRadius.circular(38), boxShadow: [boxShadow] );

    var dotEyes = DotEyes(look: look, spacing: 18, dotSize: 6);
    var pos1 = Positioned(top: 20, child: dotEyes);

    var lineMouth = LineMouth(look: look, width: 28);
    var pos2 = Positioned(top: 44, child: lineMouth);

    var child = [pos1, pos2];
    var stack = Stack(alignment: Alignment.center, clipBehavior: Clip.none, children: child);
    return Container(width: 76, height: 100, decoration: boxDecoration, child: stack);
  }

}