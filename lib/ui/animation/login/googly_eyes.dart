import 'package:flutter/material.dart';
import 'package:learn_flutter/ui/animation/login/white_eye.dart';

class GooglyEyes extends StatelessWidget {

  const GooglyEyes( { super.key, required this.look, required this.eyeSize, required this.pupilSize, required this.gap} );

  final Offset look;
  final double gap;
  final double eyeSize;
  final double pupilSize;

  @override
  Widget build(BuildContext context) {
    final maxShift = (eyeSize - pupilSize) / 2;
    final dx = look.dx * maxShift;
    final dy = look.dy * maxShift;

    var child = [
      WhiteEye(lookOffset: Offset(dx, dy), eyeSize: eyeSize, pupilSize: pupilSize),
      SizedBox(width: gap),
      WhiteEye(lookOffset: Offset(dx, dy), eyeSize: eyeSize, pupilSize: pupilSize),
    ];
    return Row(mainAxisSize: MainAxisSize.min, children: child);
  }

}