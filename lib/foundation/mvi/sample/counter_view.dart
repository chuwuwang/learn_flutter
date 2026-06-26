// 步骤4 定义 View, 这个就是对应的页面了
import 'package:flutter/material.dart';
import 'package:learn_flutter/foundation/mvi/sample/counter_state.dart';
import 'package:learn_flutter/foundation/mvi/sample/counter_view_model.dart';
import 'package:learn_flutter/foundation/mvi/sample/decrement_intent.dart';
import 'package:learn_flutter/foundation/mvi/sample/increment_intent.dart';

class CounterView extends StatefulWidget {

  const CounterView( { super.key } );

  @override
  _CounterViewState createState() => _CounterViewState();

}

class _CounterViewState extends State<CounterView> {

  late CounterViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = CounterViewModel();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var title = Text('MVI Counter (Vanilla)');
    return Scaffold(
      appBar: AppBar(title: title),
      body: Center(
        // 这里通过 StreamBuilder 来监听 stream 的变化
        child: StreamBuilder<CounterState>(
          stream: _viewModel.stateStream,
          initialData: CounterState.initial(),
          builder: (context, snapshot) {
            var style = TextStyle(fontSize: 24);
            return Text('Count: ${ snapshot.data?.count }', style: style);
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // 按钮点击时, 生成一个新的 intent, 并交给 model 处理
          FloatingActionButton(onPressed: () => _viewModel.processIntent( IncrementIntent() ), child: Icon(Icons.add) ),
          SizedBox(height: 10),
          // 按钮点击时, 生成一个新的 intent, 并交给 model 处理
          FloatingActionButton(onPressed: () => _viewModel.processIntent( DecrementIntent() ), child: Icon(Icons.remove) ),
        ],
      ),
    );
  }

}
