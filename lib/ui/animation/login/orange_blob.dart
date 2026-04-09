import 'package:flutter/material.dart';
import 'package:learn_flutter/ui/animation/login/dot_eyes.dart';

class OrangeBlob extends StatelessWidget {

  const OrangeBlob( { super.key, required this.look } );

  final Offset look;

  @override
  Widget build(BuildContext context) {
    var boxShadow = BoxShadow(color: Color(0x33000000), offset: Offset(0, 6), blurRadius: 12);
    var boxDecoration = BoxDecoration(color: const Color(0xFFFF8A4C), borderRadius: BorderRadius.circular(56), boxShadow: [boxShadow] );

    var dotEyes = DotEyes(look: look, spacing: 26, dotSize: 7);
    var positioned = Positioned(top: 20, child: dotEyes,);
    var stack = Stack(alignment: Alignment.center, children: [positioned] );
    return Container(width: 112, height: 76, decoration: boxDecoration, child: stack);
  }

}