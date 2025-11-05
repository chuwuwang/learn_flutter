import 'package:flutter/material.dart';
import 'package:learn_flutter/customize/widget/customize_tab.dart';
import 'package:learn_flutter/ui/base_state.dart';
import 'package:learn_flutter/utils/color_utils.dart';

class CustomizeTabPage extends StatefulWidget {

  static final String routePath = '/basic-widget/customize-tab';

  const CustomizeTabPage({super.key});

  @override
  State<CustomizeTabPage> createState() => _CustomizeTabPageState();

}

class _CustomizeTabPageState extends BaseState<CustomizeTabPage> {

  // 用于动态切换 tab 的位置
  TabBarPosition _tabIndex = TabBarPosition.top;

  @override
  getTitleText() => "Customize Tab";

  @override
  Widget onBuildWidget(BuildContext context) {
    var footerTab = _buildFooterTab();
    var customizeTab = _buildCustomizeTab();
    var expanded = Expanded(child: customizeTab);
    var children = [expanded, footerTab];
    return Column(children: children);
  }

  void _onChangePosition(TabBarPosition tabBarPosition) {
    void fn() { _tabIndex = tabBarPosition; }
    setState(fn);
  }

  Widget _buildCustomizeTab() {
    var radius = Radius.circular(4);
    var customizeTab = CustomizeTab(
      tabBarHeight: 56,
      tabBarBackgroundColor: Colors.white,
      selectedColor: Colors.white,
      unselectedColor: Colors.black,
      tabBarBorderRadius: BorderRadiusGeometry.all(radius),
      tabBarPadding: const EdgeInsets.symmetric(horizontal: 8),
      tabBarOptionPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      position: _tabIndex,
      onChangeTabIndex: (index) {
        print('当前的索引为：$index');
      },
      tabs: ['Tab 1', 'Tab 2', 'Tab 3', 'Tab 4', 'Tab 5'].map(
            (item) => _buildTabItem(item),
      ).toList(),
      tabViews: ['View 1', 'View 2', 'View 3', 'View 4', 'View 5'].map(
            (item) => _buildContent(item),
      ).toList(),
    );
    return customizeTab;
  }

  Widget _buildContent(String text) {
    var child = Text(text);
    return Container(padding: const EdgeInsets.all(16), color: ColorUtils.backgroundFill, child: child);
  }

  Widget _buildTabItem(String text) {
    var style = const TextStyle(fontSize: 16);
    return Text(text, style: style);
  }

  Widget _buildFooterTab() {
    var leftButton = ElevatedButton(
      onPressed: () => _onChangePosition(TabBarPosition.left),
      child: const Text('Left'),
    );
    var topButton = ElevatedButton(
      onPressed: () => _onChangePosition(TabBarPosition.top),
      child: const Text('Top'),
    );
    var rightButton = ElevatedButton(
      onPressed: () => _onChangePosition(TabBarPosition.right),
      child: const Text('Right'),
    );
    var bottomButton = ElevatedButton(
      onPressed: () => _onChangePosition(TabBarPosition.bottom),
      child: const Text('Bottom'),
    );
    var children = [topButton, leftButton, rightButton, bottomButton];
    var row = Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: children);
    return Container(height: 64, color: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 16), child: row);
  }

}