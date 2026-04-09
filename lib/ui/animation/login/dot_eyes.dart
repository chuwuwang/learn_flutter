import 'package:flutter/material.dart';
import 'package:learn_flutter/ui/animation/login/eye_dot.dart';

class DotEyes extends StatelessWidget {

  final _kEyeMax = 5.0;

  const DotEyes( { super.key, required this.look, required this.spacing, required this.dotSize} );

  final Offset look;
  final double spacing;
  final double dotSize;

  @override
  Widget build(BuildContext context) {
    final dx = look.dx * _kEyeMax;
    final dy = look.dy * _kEyeMax;

    var child = [
      EyeDot(offset: Offset(dx, dy), size: dotSize),
      SizedBox(width: spacing),
      EyeDot(offset: Offset(dx, dy), size: dotSize),
    ];
    return Row(mainAxisSize: MainAxisSize.min, children: child);
  }

}