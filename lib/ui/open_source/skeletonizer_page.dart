import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:learn_flutter/ui/base_state.dart';
import 'package:skeletonizer/skeletonizer.dart';

@Preview(name: "skeletonizer")
class SkeletonizerPage extends StatefulWidget {

  static final String routePath = '/open-source/skeletonizer';

  const SkeletonizerPage( { super.key } );

  @override
  State<StatefulWidget> createState() => _SkeletonizerPageState();

}

class _SkeletonizerPageState extends BaseState<SkeletonizerPage> {

  bool _isLoading = true;

  @override
  String getTitleText() => "Skeletonizer 骨架屏";

  @override
  void initState() {
    super.initState();
    fn() {
      if (mounted) setState(() => _isLoading = false);
    }
    Future.delayed(const Duration(seconds: 3), fn);
  }

  @override
  Widget onBuildWidget(BuildContext context) {
    var child = _buildContentWidget();
    return Skeletonizer(enabled: _isLoading, child: child);
  }

  Widget _buildContentWidget() {
    var image = NetworkImage('https://picsum.photos/200/200');
    var avatar = CircleAvatar(radius: 40, backgroundImage: image);

    var authorStyle = const TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
    var author = Text('Flutter 开发者', style: authorStyle);

    var descStyle = const TextStyle(fontSize: 14, color: Colors.grey);
    var description = Text('专注于 Flutter 跨平台开发、性能优化与生态探索', style: descStyle);

    itemBuilder(context, index) {
      var leading = const Icon(Icons.article);
      var subtitle = const Text('发布于 2025-12-29');
      var title = Text('文章 ${ index + 1 }：Skeletonizer 高级用法');
      return ListTile(leading: leading, title: title, subtitle: subtitle);
    }
    var listView = ListView.builder(itemCount: 5, itemBuilder: itemBuilder);
    var expanded = Expanded(child: listView);
    var children = [
      avatar, const SizedBox(height: 16),
      author, const SizedBox(height: 8),
      description, const SizedBox(height: 24),
      expanded
    ];

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: children);
  }

}