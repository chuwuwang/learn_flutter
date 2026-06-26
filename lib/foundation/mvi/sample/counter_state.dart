// 步骤2: 定义 State
class CounterState {

  // 注意, 这里是一个final的, 说明这个状态是不可变的
  final int count;

  CounterState(this.count);

  CounterState.initial() : count = 0;

}
