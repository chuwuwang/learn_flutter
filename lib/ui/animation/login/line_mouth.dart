import 'package:flutter/material.dart';

class LineMouth extends StatelessWidget {

  const LineMouth( { super.key, required this.look, required this.width } );

  final Offset look;
  final double width;

  @override
  Widget build(BuildContext context) {
    final shift = look.dx * 2;

    var decoration = BoxDecoration(borderRadius: BorderRadius.circular(2), color: Colors.black54);
    var container = Container(width: width, height: 3, decoration: decoration);
    return Transform.translate(offset: Offset(shift, 0), child: container);
  }

}