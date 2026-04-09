import 'package:flutter/material.dart';
import 'package:learn_flutter/ui/animation/login/googly_eyes.dart';

class BlackSlab extends StatelessWidget {

  const BlackSlab( { super.key, required this.look } );

  final Offset look;

  @override
  Widget build(BuildContext context) {
    var boxShadow = BoxShadow(color: Color(0x44000000), offset: Offset(0, 4), blurRadius: 8,);
    var boxDecoration = BoxDecoration(color: const Color(0xFF1B1B24), borderRadius: BorderRadius.circular(29), boxShadow: [boxShadow] );;

    var googlyEyes = GooglyEyes(look: look, eyeSize: 21, pupilSize: 8, gap: 9);
    var positioned = Positioned(top: 28, child: googlyEyes);
    var stack = Stack(alignment: Alignment.center, clipBehavior: Clip.none, children: [positioned] );

    return Container(width: 58, height: 168, decoration: boxDecoration, child: stack);
  }

}