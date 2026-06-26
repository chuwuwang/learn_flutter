import 'package:flutter/services.dart';
import 'package:learn_flutter/foundation/service/native_bridge_exception.dart';

/// Platform Channel 统一调用层
class NativeBridge {

  static const _channel = MethodChannel('com.sea/native_bridge');

  /// 泛型调用, 自动类型转换 + 统一错误处理
  static Future<T> call<T>( { required String method, Map<String, dynamic> ? args } ) async {
    var message = '';
    try {
      final result = await _channel.invokeMethod(method, args);
      if (result == null) throw NativeBridgeException(method: method, message: 'Native client response is null');
      // 类型安全转换
      return _cast<T>(result);
    } on PlatformException catch (e) {
      message = e.message ?? 'Unknown Error';
    }
    throw NativeBridgeException(method: method, message: message);
  }

  static T _cast<T>(dynamic value) {
    switch (T) {
      case int _:
        return (value as num).toInt() as T;
      case double _:
        return (value as num).toDouble() as T;
      case String _:
        return value.toString() as T;
      case bool _:
        return value == true ? true as T : false as T;
      case Map<String, dynamic> _:
        return (value as Map).cast<String, dynamic>() as T;
      case List<dynamic> _:
        return (value as List).cast<dynamic>() as T;
    }
    return value as T;
  }

}