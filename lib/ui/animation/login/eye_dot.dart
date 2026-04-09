import 'package:flutter/material.dart';

class EyeDot extends StatelessWidget {

  const EyeDot( { super.key, required this.offset, required this.size } );

  final double size;
  final Offset offset;

  @override
  Widget build(BuildContext context) {
    var boxDecoration = BoxDecoration(color: Colors.black, shape: BoxShape.circle);
    var container = Container(width: size, height: size, decoration: boxDecoration);
    var transform = Transform.translate(offset: offset, child: container);

    var stack = Stack(alignment: Alignment.center, children: [transform] );
    return SizedBox(width: size + 4, height: size + 4, child: stack);
  }

}