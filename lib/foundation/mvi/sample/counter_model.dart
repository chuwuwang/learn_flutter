// 步骤3 定义 Model （这个步骤可省略，可放到ViewModel里）
import 'package:learn_flutter/foundation/mvi/sample/counter_state.dart';

class CounterModel {

  Future<CounterState> increment(CounterState currentState) async {
    await Future.delayed(Duration(milliseconds: 100)); // 模拟异步操作
    return CounterState(currentState.count + 1);
  }

  Future<CounterState> decrement(CounterState currentState) async {
    await Future.delayed(Duration(milliseconds: 100)); // 模拟异步操作
    return CounterState(currentState.count - 1);
  }

  // 这里可再实现一个根据历史状态来回溯的方法和状态, 这里就不展开了

}
