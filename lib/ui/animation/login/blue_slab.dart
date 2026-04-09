import 'package:flutter/material.dart';
import 'package:learn_flutter/ui/animation/login/googly_eyes.dart';

/// 蓝色小人：最高、略倾斜, 叠在橙/黑之后, 位置偏黑色一侧以便眼睛露在上方空隙。
class BlueSlab extends StatelessWidget {

  const BlueSlab( { super.key, required this.look } );

  final Offset look;

  @override
  Widget build(BuildContext context) {
    var boxShadow = BoxShadow(color: Color(0x33000000), offset: Offset(2, 6), blurRadius: 10);
    var boxDecoration = BoxDecoration(color: const Color(0xFF3958D0), borderRadius: BorderRadius.circular(43), boxShadow: [boxShadow] );

    var googlyEyes = GooglyEyes(look: look, eyeSize: 26, pupilSize: 10, gap: 18);
    var positioned = Positioned(top: 22, child: googlyEyes);
    var stack = Stack(alignment: Alignment.center, clipBehavior: Clip.none, children: [positioned] );

    // 加高后眼睛区域落在黑色顶边之上, 叠层时不再被黑小人盖住
    var container = Container(width: 86, height: 212, decoration: boxDecoration, child: stack);
    return Transform.rotate(angle: -0.1, child: container);
  }

}