import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:learn_flutter/customize/widget/compare_slider.dart';
import 'package:learn_flutter/ui/base_state.dart';

class CompareSliderPage extends StatefulWidget {

  static final String routePath = '/basic-widget/compare-slider';

  const CompareSliderPage( { super.key } );

  @override
  State<CompareSliderPage> createState() => _CompareSliderPageState();

}

class _CompareSliderPageState extends BaseState<CompareSliderPage> {

  double value = 0.5;

  late double valueDragBefore = value;

  late double valueDragAfter = value;

  double thickness = 1;

  double thumbSize = 50;

  double multipleSpeed = 8;

  bool dragOnlyOnSlider = true;

  bool showDebugHitTestAreaColor = false;

  String onSliderTouchStatus = '';

  @override
  getTitleText() => "Compare Slider";

  @override
  Widget onBuildWidget(BuildContext context) {
    sliderOnChanged(newValue) {
      dragOnlyOnSlider = newValue;
      setState( () {} );
    }
    var sliderSwitch = Switch(value: dragOnlyOnSlider, onChanged: sliderOnChanged);
    var sliderItem = ListTile(title: Text('dragOnlyOnSlider'), trailing: sliderSwitch);

    areaColorOnChanged(newValue) {
      showDebugHitTestAreaColor = newValue;
      setState( () { } );
    }
    var areaColorSwitch = Switch(value: showDebugHitTestAreaColor, onChanged: areaColorOnChanged);
    var areaColorItem = ListTile(title: Text('showDebugHitTestAreaColor'), trailing: areaColorSwitch);

    var compareSlider = _buildCompareSlider();
    var sliderTouchText = Text('onSliderTouch: $onSliderTouchStatus');
    var sliderTouchItem = ListTile(title: sliderTouchText);
    var valueText = _buildValueText();
    var valueTextItem = ListTile(title: valueText);
    var cls = [sliderItem, areaColorItem, Divider(), compareSlider, sliderTouchItem, valueTextItem];
    var column = Column(children: cls);
    var container = Container(child: column);
    return SingleChildScrollView(child: container);
  }

  Widget _buildCompareSlider() {
    Widget resultWidget = CompareSlider(
      value: value,
      dragOnlyOnSlider: dragOnlyOnSlider,
      before: _buildImageView(isBefore: true),
      after: _buildImageView(isBefore: false),
      thickness: thickness,
      thumb: _buildThumb(),
      extraHitTestArea: EdgeInsets.symmetric(horizontal: thumbSize / 2),
      debugHitTestAreaColor: Colors.red.withValues(alpha: showDebugHitTestAreaColor ? 0.2 : 0),
      onValueChanged: (double value) {
        this.value = value;
        setState( () { } );
      },
      onSliderThumbTouchBegin: () {
        onSliderTouchStatus = 'begin';
        setState( () { } );
      },
      onSliderThumbTouchEnd: () {
        onSliderTouchStatus = 'end';
        setState( () {} );
      },
      onSliderDragEnd: (result) {
        valueDragBefore = result.valueDragBefore;
        valueDragAfter = result.valueDragAfter;
        setState( () {} );
      },
    );
    resultWidget = ClipRRect(clipBehavior: Clip.hardEdge, child: resultWidget);
    return resultWidget;
  }

  Widget _buildThumb() {
    var sliderLine = _buildSliderLine();
    var sliderThumb = _buildSliderThumb();
    var positioned = Positioned(left: -(thumbSize - thickness) / 2, child: sliderThumb);
    return Stack(clipBehavior: Clip.none, alignment: Alignment.center, children: [sliderLine, positioned] );
  }

  Widget _buildSliderLine() {
    var color = Colors.white.withValues(alpha: 0.5);
    return Container(width: thickness, color: color);
  }

  Widget _buildSliderThumb() {
    Widget resultWidget = Image.asset('assets/thumb.png', width: thumbSize, height: thumbSize);
    var color = Colors.white.withValues(alpha: 0.5);
    var decoration = BoxDecoration(shape: BoxShape.circle, color: color);
    var container = Container(decoration: decoration, child: resultWidget);
    resultWidget = Transform.rotate(angle: value * 2 * math.pi * multipleSpeed, child: container);
    return resultWidget;
  }

  Widget _buildImageView({required bool isBefore}) {
    final screenWidth = MediaQuery.widthOf(context);
    double imageSize = math.min(screenWidth, 445);
    var name = '''assets/${isBefore ? 'before.jpeg' : 'after.jpg'}''';
    Widget resultWidget = Image.asset(name, width: imageSize, height: imageSize);
    var color = Colors.white.withValues(alpha: 0.6);
    var icon = Icon(isBefore ? Icons.keyboard_double_arrow_left_rounded : Icons.keyboard_double_arrow_right_rounded, size: 20);
    onPressed() {
      value = isBefore ? 0 : 1;
      setState( () { } );
    }
    var iconButton = IconButton(onPressed: onPressed, icon: icon, color: color);
    var children = [ resultWidget, Positioned(child: iconButton) ];
    resultWidget = Stack(alignment: isBefore ? Alignment.centerLeft : Alignment.centerRight, children: children);
    return resultWidget;
  }

  Widget _buildValueText() {
    final int fractionDigits = 2;
    final before = valueDragBefore.toStringAsFixed(fractionDigits);
    final current = value.toStringAsFixed(fractionDigits);
    final after = valueDragAfter.toStringAsFixed(fractionDigits);
    return Text('before: $before, current: $current, after: $after');
  }

}