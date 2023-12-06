import 'package:calculator/app/core/common/button_view.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({Key? key}) : super(key: key);

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  var userQuestion = '';
  var result = '';
  var isExpressionComplete = false;

  final List<String> buttons = [
    'C',
    '*',
    '/',
    '<-',
    '1',
    '2',
    '3',
    '+',
    '4',
    '5',
    '6',
    '-',
    '7',
    '8',
    '9',
    '*',
    '%',
    '0',
    '.',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator App'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          buildDisplay(),
          buildButtons(),
        ],
      ),
    );
  }

  Widget buildDisplay() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.shade400,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.only(right: 20),
                child: Text(
                  isExpressionComplete ? result : userQuestion,
                  style: const TextStyle(
                    fontSize: 24, // Adjust the font size
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButtons() {
    return Expanded(
      flex: 5,
      child: GridView.count(
        crossAxisCount: 4,
        crossAxisSpacing: 6,
        mainAxisSpacing: 6,
        padding: const EdgeInsets.all(5),
        childAspectRatio:
            0.84, 
        children: List.generate(
          buttons.length,
          (index) => ButtonsView(
            buttonText: buttons[index],
            buttonTapped: () => buttonTapped(index),
          ),
        ),
      ),
    );
  }

  void buttonTapped(int index) {
    setState(() {
      if (index == 0) {
        clearCalculator();
      } else if (index == 3) {
        removeLastCharacter();
      } else if (index == buttons.length - 1) {
        calculateResult();
      } else if (index >= 4 && index <= 18) {
        handleNumericInput(index);
      } else {
        handleOperatorInput(index);
      }
    });
  }

  void clearCalculator() {
    userQuestion = '';
    result = '';
    isExpressionComplete = false;
  }

  void removeLastCharacter() {
    userQuestion = userQuestion.substring(0, userQuestion.length - 1);
  }

  void calculateResult() {
    result = evaluateExpression();
    isExpressionComplete = true;
  }

  void handleNumericInput(int index) {
    if (isExpressionComplete) {
      clearCalculator();
    }
    userQuestion += buttons[index];
  }

  void handleOperatorInput(int index) {
    userQuestion += buttons[index];
  }

  String evaluateExpression() {
    try {
      var exp = Parser().parse(userQuestion);
      var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      return (evaluation % 1 == 0)
          ? evaluation.toInt().toString()
          : evaluation.toString();
    } catch (e) {
      return "Error";
    }
  }
}
