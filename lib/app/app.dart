
import 'package:calculatorapp/app/core/theme/theme.dart';
import 'package:calculatorapp/app/routes/app_routes.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Course',
      initialRoute: AppRoute.calculatorRoute,
      theme: getapplicationTheme(),
      routes: AppRoute.getapplicationRoute(),
    );
  }
}
