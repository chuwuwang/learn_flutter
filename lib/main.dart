import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:learn_flutter/app_router_config.dart';
import 'package:learn_flutter/generated/l10n.dart';

void main() {
  var app = const MyApp();
  runApp(app);
}

class MyApp extends StatelessWidget {

  const MyApp( { super.key } );

  @override
  Widget build(BuildContext context) {
    var colorScheme = ColorScheme.fromSeed(seedColor: Colors.deepPurple);
    var materialApp = MaterialApp.router(
      title: 'Flutter Learn',
      theme: ThemeData(colorScheme: colorScheme),
      localizationsDelegates: const [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        S.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,
      routerConfig: AppRouterConfig.router,
    );
    return materialApp;
  }

}