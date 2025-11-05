import 'package:flutter/material.dart';

import 'customize_tab_indicator.dart';

/// tab bar 位置的枚举
enum TabBarPosition { top, bottom, left, right }

/// 抽取一些默认的属性
BorderRadius ctDefaultIndicatorBorderRadius = BorderRadius.circular(10);

class CustomizeTab extends StatefulWidget {
  const CustomizeTab(
    {
      super.key,
      this.tabBarHeight = kToolbarHeight,
      this.tabBarBackgroundColor,
      this.tabBarPadding = EdgeInsets.zero,
      this.tabBarBorderRadius,
      required this.tabs,
      this.unselectedColor,
      this.selectedColor,
      this.tabBarOptionMargin = const EdgeInsets.only(right: 10),
      this.tabBarOptionPadding = EdgeInsets.zero,
      this.indicatorColor = Colors.blue,
      this.indicatorBorderRadius,
      required this.tabViews,
      this.initialIndex,
      this.onChangeTabIndex,
      this.position = TabBarPosition.top,
    }
  );

  /// tab bar 容器的高度, 默认为 AppBar 工具栏组件的高度
  final double tabBarHeight;
  /// tab bar 容器的背景颜色
  final Color ? tabBarBackgroundColor;
  /// tab bar 容器的内边距
  final EdgeInsetsGeometry tabBarPadding;
  /// tab bar 容器的圆角属性
  final BorderRadiusGeometry ? tabBarBorderRadius;
  /// tab 选项
  final List<Widget> tabs;
  /// tab 选项未选中时的颜色
  final Color ? unselectedColor;
  /// tab 选项选中时的颜色
  final Color ? selectedColor;
  /// tab bar 选项每项的 margin
  final EdgeInsetsGeometry tabBarOptionMargin;
  /// tab bar 选项每项的 padding (因为大概率每项的 padding 是一致的, 所以进行抽取)
  final EdgeInsetsGeometry tabBarOptionPadding;
  /// 指示器的颜色
  final Color indicatorColor;
  /// 指示器的圆角属性
  final BorderRadius ? indicatorBorderRadius;
  /// tab 页面
  final List<Widget> tabViews;
  /// 初始化显示 tab 的索引
  final int ? initialIndex;
  /// 当 tab 索引发生改变时的回调函数
  final Function(int) ? onChangeTabIndex;
  /// tab bar 所在位置, 默认为 top
  final TabBarPosition position;

  @override
  State<CustomizeTab> createState() => _CustomizeTabState();

}

class _CustomizeTabState extends State<CustomizeTab> with SingleTickerProviderStateMixin {

  late TabController _controller;

  @override
  void initState() {
    super.initState();
    void fn() {
      // indexIsChanging 主要作用就是标识 TabController 是否正处于索引切换过程中。
      // 点击切换, 在执行动画期间为 true, 用户手势操作结束后且动画完成为 false
      // 滑动切换为 false
      // 使用 indexIsChanging 来判断当前 tab 变化是否完成, 完成了就执行回调
      if ( ! _controller.indexIsChanging) {
        widget.onChangeTabIndex?.call(_controller.index);
      }
    }
    _controller = TabController(length: widget.tabs.length, vsync: this, initialIndex: widget.initialIndex ?? 0,)
      ..addListener(fn);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// 对每个 tab 加内边距
  Widget _buildTabOption(Widget tab) {
    final Widget tabOption = Padding(padding: widget.tabBarOptionPadding, child: tab);
    // 如果是 left 和 right, 因为外层的 TabBar 容器旋转了 90 度
    // 那 Tab 选项就旋转 -90 度还原, 达到视觉的统一
    if (widget.position == TabBarPosition.left || widget.position == TabBarPosition.right) {
      return RotatedBox(quarterTurns: -1, child: tabOption);
    }
    return tabOption;
  }

  /// 构建TabBar
  Widget _buildTabBar() {
    var tabIndicator = CustomizeTabIndicator(color: widget.indicatorColor, radius: widget.indicatorBorderRadius ?? ctDefaultIndicatorBorderRadius,);
    Widget tabOption(tab) => _buildTabOption(tab);
    var tab = TabBar(
      controller: _controller,
      indicator: tabIndicator,
      isScrollable: true,
      dividerHeight: 0,
      labelColor: widget.selectedColor,
      tabAlignment: TabAlignment.start,
      labelPadding: widget.tabBarOptionMargin,
      unselectedLabelColor: widget.unselectedColor,
      tabs: widget.tabs.map(tabOption).toList(),
    );
    var decoration = BoxDecoration(color: widget.tabBarBackgroundColor, borderRadius: widget.tabBarBorderRadius);
    final Widget tabBar = Container(width: double.infinity, height: widget.tabBarHeight, padding: widget.tabBarPadding, decoration: decoration, child: tab);
    if (widget.position == TabBarPosition.left || widget.position == TabBarPosition.right) {
      // 如果是 left 和right, 则旋转90度
      return RotatedBox(quarterTurns: 1, child: tabBar);
    }
    return tabBar;
  }

  Widget _buildTabView(BoxConstraints boxConstraints) {
    final EdgeInsets tabBarPadding = widget.tabBarPadding.resolve(TextDirection.ltr);
    var verticalSizedBox = SizedBox(
      width: double.infinity,
      height: boxConstraints.maxHeight - widget.tabBarHeight - tabBarPadding.top - tabBarPadding.bottom,
      child: TabBarView(controller: _controller, children: widget.tabViews),
    );
    // 如果是 left 或者 right, 则宽高设置交换，并且将 TabBarView 旋转90度
    Widget map(tabView) => RotatedBox(quarterTurns: -1, child: tabView);
    var horizontalSizedBox = SizedBox(
      width: boxConstraints.maxWidth - widget.tabBarHeight - tabBarPadding.top - tabBarPadding.bottom,
      height: double.infinity,
      child: RotatedBox(
        quarterTurns: 1,
        child: TabBarView(
          controller: _controller,
          // 因为 TabBarView 旋转了90 度, 对应的 Tab 项要旋转 -90 度还原
          children: widget.tabViews.map(map).toList(),
        ),
      ),
    );
    return widget.position == TabBarPosition.top || widget.position == TabBarPosition.bottom ? verticalSizedBox : horizontalSizedBox;
  }

  /// 构建 tab
  Widget _buildTab(BoxConstraints boxConstraints) {
    var tabBar = _buildTabBar();
    var tabView = _buildTabView(boxConstraints);
    List<Widget> children = [tabBar, tabView];
    // 如果是 bottom 和 right, 则渲染的结构会倒置
    if (widget.position == TabBarPosition.bottom || widget.position == TabBarPosition.right) {
      children = children.reversed.toList();
    }
    // 如果是 top 或者 bottom, 则是上下结构
    // 如果是 left 或者 right, 则是左右结构
    return widget.position == TabBarPosition.top || widget.position == TabBarPosition.bottom ? Column(children: children) : Row(children: children);
  }

  @override
  Widget build(BuildContext context) {
    // 通过父容器的约束动态构建子部件
    Widget builder(_, BoxConstraints boxConstraints) => _buildTab(boxConstraints);
    return LayoutBuilder(builder: builder);
  }

}