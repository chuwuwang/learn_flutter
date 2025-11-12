import 'package:flutter/material.dart';
import 'package:learn_flutter/ui/base_state.dart';

class CompareSliderPage extends StatefulWidget {

  static final String routePath = '/basic-widget/compare-slider';

  const CompareSliderPage( { super.key } );

  @override
  State<CompareSliderPage> createState() => _CompareSliderPageState();

}

class _CompareSliderPageState extends BaseState<CompareSliderPage> {

  @override
  getTitleText() => "Compare Slider";

  @override
  Widget onBuildWidget(BuildContext context) {

  }

}