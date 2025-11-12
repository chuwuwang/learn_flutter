import 'package:flutter/material.dart';
import 'package:learn_flutter/customize/widget/seamless_scrolling.dart';
import 'package:learn_flutter/ui/base_state.dart';

class SeamlessScrollingPage extends StatefulWidget {

  static final String routePath = '/basic-widget/seamless-scrolling';

  const SeamlessScrollingPage( { super.key } );

  @override
  State<SeamlessScrollingPage> createState() => _SeamlessScrollingPageState();

}

class _SeamlessScrollingPageState extends BaseState<SeamlessScrollingPage> {

  @override
  getTitleText() => "Seamless Scrolling";

  @override
  Widget onBuildWidget(BuildContext context) {
    var child1 = _testChild(width: 300, height: 200, color: const Color(0xFF111111), text: '1');
    var child2 = _testChild(width: 300, height: 200, color: const Color(0xFF666666), text: '2');
    var child3 = _testChild(width: 300, height: 200, color: const Color(0xFF999999), text: '3');
    var children = [child1, child2, child3];
    var seamlessScrolling1 = CustomizeSeamlessScrolling(containerWidth: 300, containerHeight: 200, copyItemNumber: 1, children: children);
    var seamlessScrolling2 = CustomizeSeamlessScrolling(containerWidth: 400, containerHeight: 200, copyItemNumber: 2, milliseconds: 5000, children: children);
    var seamlessScrolling3 = CustomizeSeamlessScrolling(containerWidth: 200, containerHeight: 200, children: children);
    var cls = [seamlessScrolling1, const SizedBox(height: 20), seamlessScrolling2, const SizedBox(height: 20), seamlessScrolling3];
    var column = Column(children: cls);
    var container = Container(child: column);
    return SingleChildScrollView(child: container);
  }

  Widget _testChild( { required double width, required double height, required Color color, required String text } ) {
    var style = const TextStyle(color: Colors.white);
    var textView = Text(text, style: style);
    return Container(width: width, height: height, color: color, alignment: Alignment.center, child: textView);
  }

}