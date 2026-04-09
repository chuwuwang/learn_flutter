import 'package:flutter/material.dart';

class WhiteEye extends StatelessWidget {

  const WhiteEye( { super.key, required this.lookOffset, required this.eyeSize, required this.pupilSize } );

  final double eyeSize;
  final double pupilSize;
  final Offset lookOffset;

  @override
  Widget build(BuildContext context) {
    var whiteDecoration = BoxDecoration(color: Colors.white, shape: BoxShape.circle);
    var whiteContainer = Container(width: eyeSize, height: eyeSize, decoration: whiteDecoration);

    var blackDecoration = BoxDecoration(color: Colors.black, shape: BoxShape.circle);
    var blackContainer = Container(width: pupilSize, height: pupilSize, decoration: blackDecoration);
    var transform = Transform.translate(offset: lookOffset, child: blackContainer);

    var child = [whiteContainer, transform];
    var stack = Stack(alignment: Alignment.center, children: child);
    return SizedBox(width: eyeSize, height: eyeSize, child: stack);
  }

}