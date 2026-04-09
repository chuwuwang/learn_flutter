import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:learn_flutter/ui/animation/login/black_slab.dart';
import 'package:learn_flutter/ui/animation/login/blue_slab.dart';
import 'package:learn_flutter/ui/animation/login/orange_blob.dart';
import 'package:learn_flutter/ui/animation/login/yellow_pill.dart';

class MascotPanel extends StatelessWidget {

  const MascotPanel( { super.key, required this.look, required this.onPointer } );

  final Offset look;

  final void Function(PointerEvent event, Size size) onPointer;

  @override
  Widget build(BuildContext context) {
    // 从后往前：蓝(身体加高，眼眶整体高于黑顶边，避免被黑盖住) → 黑(加宽以容纳双眼) → 橙 → 黄
    var blueSlab = BlueSlab(look: look);
    var blackSlab = BlackSlab(look: look);
    var orangeBlob = OrangeBlob(look: look);
    var yellowPill = YellowPill(look: look);
    var childSlab = [
      Positioned(left: 44, bottom: 12, child: blueSlab),
      Positioned(left: 100, bottom: 0, child: blackSlab),
      Positioned(left: 0, bottom: 0, child: orangeBlob),
      Positioned(left: 130, bottom: 0, child: yellowPill),
    ];
    var stackSlab = Stack(clipBehavior: Clip.none, alignment: Alignment.bottomCenter, children: childSlab);

    var colors = [
      Color(0xFF2B2D42),
      Color(0xFF1E1F33),
      Color(0xFF252746),
    ];
    var linearGradient = LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: colors);
    var decoration = BoxDecoration(gradient: linearGradient);

    Stack buildStackSlab(constraints) {
      var sizedBox = SizedBox(width: math.min(constraints.maxWidth, 420), height: 268, child: stackSlab);
      var transform = Transform.translate(offset: const Offset(60, -200), child: sizedBox);
      var positioned = Positioned(bottom: 24, child: transform);
      return Stack(clipBehavior: Clip.none, alignment: Alignment.bottomCenter, children: [positioned] );
    }
    var layoutBuilder = LayoutBuilder(

        builder: (context, constraints) {
        var stack = buildStackSlab(constraints);
        return Container(width: double.infinity, height: double.infinity, decoration: decoration, child: stack);
      }

    );

    var mouseRegion = MouseRegion(onHover: (e) => _dispatch(context, e), child: layoutBuilder);
    return Listener(onPointerHover: (e) => _dispatch(context, e), onPointerMove: (e) => _dispatch(context, e), onPointerDown: (e) => _dispatch(context, e), child: mouseRegion);
  }

  void _dispatch(BuildContext context, PointerEvent e) {
    final box = context.findRenderObject() as RenderBox ? ;
    if (box == null) return;
    onPointer(e, box.size);
  }

}