import 'dart:async';
import 'dart:math' as math;
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:learn_flutter/ui/animation/login/login_form.dart';
import 'package:learn_flutter/ui/animation/login/mascot_panel.dart';

class LoginPage extends StatefulWidget {

  static final String routePath = '/basic-animation/login';

  const LoginPage( { super.key } );

  @override
  State<LoginPage> createState() => _LoginPageState();

}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();

  late AnimationController _lookAnim;

  Offset _lookTo = Offset.zero;
  Offset _lookFrom = Offset.zero;
  Offset _lookDisplay = Offset.zero;

  /// 左侧区域内的归一化指针 (-1~1), 用于空闲「注视」跟随。
  Offset _idlePointer = Offset.zero;

  bool _stopDemo = true;
  bool _passwordObscured = true;

  static const _watchRight = Offset(0.92, 0.08);
  static const _lookAwayLeft = Offset(-0.92, 0.0);

  @override
  void initState() {
    super.initState();

    var duration = const Duration(milliseconds: 220);
    _lookAnim = AnimationController(vsync: this, duration: duration)
      ..addListener(_syncLookDisplay);

    _emailFocus.addListener(_onFocusChanged);
    _passwordFocus.addListener(_onFocusChanged);

    if (kDebugMode) {
      callback(_) {
        _runAutoDemo();
      }
      WidgetsBinding.instance.addPostFrameCallback(callback);
    }

  }

  void _syncLookDisplay() {
    fn() {
      _lookDisplay = Offset.lerp(_lookFrom, _lookTo, _lookAnim.value)!;
    }
    setState(fn);
  }

  void _onFocusChanged() {
    var offset = _computeLookTarget();
    _pushLookTarget(offset);
  }

  void _pushLookTarget(Offset next) {
    if ((_lookDisplay - next).distance < 0.02 && !_lookAnim.isAnimating) {
      return;
    }
    _lookFrom = _lookDisplay;
    _lookTo = next;
    _lookAnim.forward(from: 0);
  }

  /// 密码框：隐藏时「注视」表单；显示明文时「背过去」。
  /// 邮箱：注视右侧表单。
  /// 空闲：跟随左侧区域内指针。
  Offset _computeLookTarget() {
    if (_passwordFocus.hasFocus) {
      return _passwordObscured ? _watchRight : _lookAwayLeft;
    }
    if (_emailFocus.hasFocus) {
      return _watchRight;
    }
    return _idlePointer;
  }

  void _onMascotPointer(PointerEvent event, Size size) {
    if (size.width <= 0 || size.height <= 0) return;
    final local = event.localPosition;
    final nx = ((local.dx / size.width) - 0.5) * 2;
    final ny = ((local.dy / size.height) - 0.5) * 2;
    final dx = nx.clamp(-1.0, 1.0);
    final dy = ny.clamp(-1.0, 1.0);
    _idlePointer = Offset(dx, dy);
    // 空闲时直接跟随指针 , 保证视线跟手/鼠标同步 , 切焦点时用动画过渡 。
    if ( ! _emailFocus.hasFocus && ! _passwordFocus.hasFocus) {
      fn() {
        _lookDisplay = _idlePointer;
        _lookFrom = _idlePointer;
        _lookTo = _idlePointer;
      }
      setState(fn);
      _lookAnim.stop();
      _lookAnim.value = 1.0;
    }
  }

  void _setIdlePointerAndDisplay(Offset p) {
    // 空闲时：让眼睛「立刻跟随」, 不经过动画插值 , 避免录屏拖影 。
    _idlePointer = p;
    if ( ! _emailFocus.hasFocus && ! _passwordFocus.hasFocus) {
      _lookDisplay = p;
      _lookFrom = p;
      _lookTo = p;
      _lookAnim.stop();
      _lookAnim.value = 1.0;
      fn() { }
      setState(fn);
    }
  }

  void _setPasswordObscured(bool value) {
    if (_passwordObscured == value) return;
    fn() => _passwordObscured = value;
    setState(fn);
    // 若正在聚焦密码框, 需要同步更新眼睛目标 。
    var offset = _computeLookTarget();
    _pushLookTarget(offset);
  }

  Future<void> _runAutoDemo() async {
    // 循环：空闲跟随 → email 注视 → password 注视(隐藏) → password 回避(显示)
    while (mounted && ! _stopDemo) {

      // 1) 空闲：移动指针让眼睛跟随
      _emailFocus.unfocus();
      _passwordFocus.unfocus();
      _setPasswordObscured(true);
      _lookAnim.stop();
      const idleMs = 1600;
      const frame = Duration(milliseconds: 16);
      final start = DateTime.now();
      while (mounted && ! _stopDemo && DateTime.now().difference(start).inMilliseconds < idleMs) {
        final t = DateTime.now().difference(start).inMilliseconds / idleMs;
        final angle = t * math.pi * 2;
        final p = Offset(math.sin(angle) * 0.85, math.cos(angle) * 0.55);
        final dx = p.dx.clamp(-1.0, 1.0);
        final dy = p.dy.clamp(-1.0, 1.0);
        var offset = Offset(dx, dy);
        _setIdlePointerAndDisplay(offset);
        await Future.delayed(frame);
      }

      // 2) email 聚焦（眼睛注视右侧表单）
      _emailController.text = '123123@gmail.com';
      _passwordController.text = '123456';
      _passwordFocus.unfocus();

      var duration = const Duration(milliseconds: 120);
      await Future.delayed(duration);

      if ( ! mounted || _stopDemo) break;

      FocusScope.of(context).requestFocus(_emailFocus);
      duration = const Duration(seconds: 2);
      await Future.delayed(duration);

      // 3) password 聚焦 + 隐藏密码（眼睛注视右侧表单）
      _setPasswordObscured(true);
      _emailFocus.unfocus();

      duration = const Duration(milliseconds: 120);
      await Future.delayed(duration);

      if ( ! mounted || _stopDemo) break;

      FocusScope.of(context).requestFocus(_passwordFocus);
      duration = const Duration(seconds: 2);
      await Future.delayed(duration);

      // 4) 显示密码（眼睛回避左侧）
      _setPasswordObscured(false);
      duration = const Duration(seconds: 2);
      await Future.delayed(duration);
    }

  }

  @override
  void dispose() {
    _stopDemo = true;
    _lookAnim.removeListener(_syncLookDisplay);
    _lookAnim.dispose();
    _emailFocus.removeListener(_onFocusChanged);
    _passwordFocus.removeListener(_onFocusChanged);
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    onTogglePassword() {
      fn() {
        _passwordObscured = ! _passwordObscured;
      }
      setState(fn);
      var offset = _computeLookTarget();
      _pushLookTarget(offset);
    }
    final form = LoginForm(
      emailController: _emailController, passwordController: _passwordController, emailFocus: _emailFocus,
      passwordFocus: _passwordFocus, passwordObscured: _passwordObscured, onTogglePassword: onTogglePassword);
    final mascot = MascotPanel(look: _lookDisplay, onPointer: _onMascotPointer);
    final child = [ Expanded(child: mascot), Expanded(child: form) ];
    var row = Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: child);

    builder(context, constraints) {
      // final wide = constraints.maxWidth >= 880;
      // if (wide) return row;
      if (Platform.isWindows && Platform.isMacOS) return row;

      var boxConstraints = BoxConstraints(minHeight: constraints.maxHeight);
      var sizedBox = SizedBox(height: math.min(360, constraints.maxHeight * 0.42), child: mascot);
      var child = [sizedBox, form];
      var column = Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: child);
      var constrainedBox = ConstrainedBox(constraints: boxConstraints, child: column);
      return SingleChildScrollView(child: constrainedBox);
    }
    var layoutBuilder = LayoutBuilder(builder: builder);
    return Scaffold(body: layoutBuilder);
  }

}