// 步骤4 定义 ViewModel （对应架构中的 Model，接收intent，并把intent转换为对应的状态）
import 'dart:async';

import 'package:learn_flutter/foundation/mvi/sample/counter_intent.dart';
import 'package:learn_flutter/foundation/mvi/sample/counter_model.dart';
import 'package:learn_flutter/foundation/mvi/sample/counter_state.dart';
import 'package:learn_flutter/foundation/mvi/sample/decrement_intent.dart';
import 'package:learn_flutter/foundation/mvi/sample/increment_intent.dart';

// 步骤4: 定义 ViewModel （对应架构中的 Model, 接收 intent, 并把 intent 转换为对应的状态）
class CounterViewModel {

  final CounterModel _model = CounterModel();

  // 这里实现一个历史状态的存储, 可状态的回溯（实际业务可能更复杂）
  final _stateHistory = <CounterState>[];

  CounterState _currentState = CounterState.initial();

  final _stateController = StreamController<CounterState>();

  // 通过这个 stream 来监听状态的变化逻辑
  Stream<CounterState> get stateStream => _stateController.stream;

  // 对外的方法, 接收 intent, 并转换成对应的状态
  void processIntent(CounterIntent intent) async {
    if (intent is IncrementIntent) {
      _stateHistory.add(_currentState);
      _currentState = await _model.increment(_currentState);
    } else if (intent is DecrementIntent) {
      _stateHistory.add(_currentState);
      _currentState = await _model.decrement(_currentState);
    }
    // 把状态的变化通过 StreamController 进行发送
    _stateController.add(_currentState);
  }

  void dispose() {
    _stateController.close();
  }

}
