import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// 右侧表单
class LoginForm extends StatelessWidget {

  const LoginForm(
     {
        super.key,
        required this.emailController,
        required this.passwordController,
        required this.emailFocus,
        required this.passwordFocus,
        required this.passwordObscured,
        required this.onTogglePassword,
     }
  );

  final TextEditingController emailController;
  final TextEditingController passwordController;

  final bool passwordObscured;
  final FocusNode emailFocus;
  final FocusNode passwordFocus;
  final VoidCallback onTogglePassword;

  @override
  Widget build(BuildContext context) {
    var guideStyle = GoogleFonts.inter(fontSize: 20, color: const Color(0xFF1A1A1A), fontWeight: FontWeight.w600);
    var guideText = Text('LOGIN', style: guideStyle);
    var guideAlign = Align(alignment: Alignment.centerLeft, child: guideText);

    final titleStyle = GoogleFonts.inter(fontSize: 28, color: const Color(0xFF111111), fontWeight: FontWeight.w700);
    var titleText = Text('WELCOME BACK !', style: titleStyle);

    final subtleStyle = GoogleFonts.inter(color: const Color(0xFF6B6B6B), fontSize: 16);
    var subtleText = Text('Please Enter Your Details', style: subtleStyle);

    final labelStyle = GoogleFonts.inter(fontSize: 14, color: const Color(0xFF222222), fontWeight: FontWeight.w500);
    var emailText = Text('Email', style: labelStyle);
    var inputEmail = _inputEmail();

    var passwordText = Text('Password', style: labelStyle);
    var inputPassword = _inputPassword();

    var forgotPassword = _forgotPassword();
    var loginButton = _loginButton();
    var loginWithGoogleButton = _loginWithGoogleButton();
    var registerButton = _registerButton();

    var child = [
      guideAlign,
      const SizedBox(height: 48), titleText,
      const SizedBox(height: 8), subtleText,
      const SizedBox(height: 32), emailText,
      const SizedBox(height: 8), inputEmail,
      const SizedBox(height: 16), passwordText,
      const SizedBox(height: 8), inputPassword,
      const SizedBox(height: 20), forgotPassword,
      const SizedBox(height: 20), loginButton,
      const SizedBox(height: 16), loginWithGoogleButton,
      const SizedBox(height: 32), registerButton,
    ];

    var column = Column(crossAxisAlignment: CrossAxisAlignment.stretch, mainAxisSize: MainAxisSize.min, children: child);
    var padding = Padding(padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 48), child: column);
    var constrainedBox = ConstrainedBox(constraints: const BoxConstraints(maxWidth: 400), child: padding);
    var align = Align(alignment: Alignment.center, child: constrainedBox);
    return Material(color: Colors.white, child: align);
  }

  Widget _inputEmail() {
    var color = Color(0xFFD9D9D9);
    var borderSide = BorderSide(color: color);
    var borderRadius = BorderRadius.circular(8);
    final fieldBorder = OutlineInputBorder(borderRadius: borderRadius, borderSide: borderSide);

    var borderColor = Color(0xFF3B3B3B);
    var side = BorderSide(color: borderColor);
    var focusedBorder = fieldBorder.copyWith(borderSide: side);

    var hintColor = const Color(0xFFB0B0B0);
    var hintStyle = GoogleFonts.inter(color: hintColor);
    var padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 16);

    var decoration = InputDecoration(hintText: 'Please enter your email',
        hintStyle: hintStyle, contentPadding: padding,
        border: fieldBorder, enabledBorder: fieldBorder, focusedBorder: focusedBorder);
    return TextField(controller: emailController, focusNode: emailFocus, keyboardType: TextInputType.emailAddress, decoration: decoration);
  }

  Widget _inputPassword() {
    var color = Color(0xFFD9D9D9);
    var borderSide = BorderSide(color: color);
    var borderRadius = BorderRadius.circular(8);
    final fieldBorder = OutlineInputBorder(borderRadius: borderRadius, borderSide: borderSide);

    var borderColor = Color(0xFF3B3B3B);
    var side = BorderSide(color: borderColor);
    var focusedBorder = fieldBorder.copyWith(borderSide: side);

    var padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 16);

    var iconColor = Color(0xFF5C5C5C);
    var icon = Icon(passwordObscured ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: iconColor);
    var iconButton = IconButton(tooltip: passwordObscured ? 'show password' : 'hide password', onPressed: onTogglePassword, icon: icon);
    var inputDecoration = InputDecoration(contentPadding: padding,
        border: fieldBorder, enabledBorder: fieldBorder,
        focusedBorder: focusedBorder, suffixIcon: iconButton);
    return TextField(controller: passwordController, focusNode: passwordFocus, obscureText: passwordObscured, decoration: inputDecoration);
  }

  Widget _forgotPassword() {
    var color = Color(0xFFC8C8C8);
    var borderSide = BorderSide(color: color);
    var checkbox = Checkbox(value: false, onChanged: (_) { }, side: borderSide);
    var sizedBox = SizedBox(height: 24, width: 24, child: checkbox);

    var hintStyle = GoogleFonts.inter(color: const Color(0xFF444444), fontSize: 12);
    var hintText = Text('Remember for 30 days', style: hintStyle);
    var expanded = Expanded(child: hintText);

    var forgotStyle = GoogleFonts.inter(fontSize: 12, color: const Color(0xFF2563EB), fontWeight: FontWeight.w500);
    var forgotText = Text('Forgot Password ?', style: forgotStyle);
    var button = TextButton(onPressed: () {}, child: forgotText);

    var child = [sizedBox, const SizedBox(width: 4), expanded, button];
    return Row(children: child);
  }

  Widget _loginButton() {
    var style = GoogleFonts.inter(fontSize: 16, color: const Color(0xFF111111), fontWeight: FontWeight.w600);
    var text = Text('Login', style: style);

    var padding = EdgeInsets.symmetric(vertical: 16);

    var color = Color(0xFF222222);
    var side = BorderSide(color: color);
    var borderRadius = BorderRadius.circular(8);
    var shape = RoundedRectangleBorder(borderRadius: borderRadius);
    var styleFrom = OutlinedButton.styleFrom(padding: padding, side: side, shape: shape);
    var outlinedButton = OutlinedButton(onPressed: () { }, style: styleFrom, child: text);
    return SizedBox(height: 48, child: outlinedButton);
  }

  Widget _loginWithGoogleButton() {
    var padding = const EdgeInsets.symmetric(vertical: 16);

    var color = Color(0xFF222222);
    var side = BorderSide(color: color);
    var borderRadius = BorderRadius.circular(8);
    var shape = RoundedRectangleBorder(borderRadius: borderRadius);
    var styleFrom = OutlinedButton.styleFrom(padding: padding, side: side, shape: shape);

    var gStyle = GoogleFonts.inter(fontSize: 12, color: const Color(0xFF4285F4), fontWeight: FontWeight.w700);
    var gText = Text('G', style: gStyle);
    var gColor = Color(0xFFE0E0E0);
    var border = Border.all(color: gColor);
    var decoration = BoxDecoration(borderRadius: BorderRadius.circular(4), border: border);
    var container = Container(width: 20, height: 20, alignment: Alignment.center, decoration: decoration, child: gText);

    var style = GoogleFonts.inter(fontSize: 16, color: const Color(0xFF111111), fontWeight: FontWeight.w600);
    var text = Text('Login with Google', style: style);

    var child = [container, const SizedBox(width: 8), text];
    var row = Row(mainAxisAlignment: MainAxisAlignment.center, children: child);
    var outlinedButton = OutlinedButton(onPressed: () { }, style: styleFrom, child: row);
    return SizedBox(height: 48, child: outlinedButton);
  }

  Widget _registerButton() {
    var textSpan = const TextSpan(text: "Don't have an account ?  ");

    var style = GoogleFonts.inter(fontSize: 14, color: const Color(0xFF111111), fontWeight: FontWeight.w700);
    var text = Text('Sign Up', style: style);
    var gestureDetector = GestureDetector(onTap: () { }, child: text);
    var widgetSpan = WidgetSpan(alignment: PlaceholderAlignment.baseline, baseline: TextBaseline.alphabetic, child: gestureDetector);

    var spanStyle = GoogleFonts.inter(color: const Color(0xFF666666), fontSize: 14);
    var child = [textSpan, widgetSpan];
    var allText = TextSpan(style: spanStyle, children: child);
    var richText = RichText(text: allText);
    return Center(child: richText);
  }

}