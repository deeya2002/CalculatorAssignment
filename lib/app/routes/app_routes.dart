


import 'package:calculator/view/calculator_screen_view.dart';

class AppRoute {
  AppRoute._();
  static const String calculatorRoute = '/';
  

  static getapplicationRoute() {
    return {
      calculatorRoute: (context) => const CalculatorView(),
    };
  }
}
