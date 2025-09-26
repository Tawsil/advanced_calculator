import 'dart:math';
import 'package:math_expressions/math_expressions.dart';

class CalculatorOperations {
  static String evaluateExpression(String expression) {
    try {
      expression = expression
          .replaceAll('×', '*')
          .replaceAll('÷', '/')
          .replaceAll('π', 'pi')
          .replaceAll('√', 'sqrt')
          .replaceAll('x²', '^2');

      Parser p = Parser();
      Expression exp = p.parse(expression);
      ContextModel cm = ContextModel();
      
      double result = exp.evaluate(EvaluationType.REAL, cm);
      
      if (result.isNaN || result.isInfinite) return 'Error';
      
      if (result % 1 == 0) {
        return result.toInt().toString();
      } else {
        String formatted = result.toStringAsFixed(8).replaceAll(RegExp(r'0*$'), '');
        return formatted.endsWith('.') ? formatted.substring(0, formatted.length - 1) : formatted;
      }
    } catch (e) {
      return 'Error';
    }
  }

  static double calculateScientific(String function, double value) {
    switch (function) {
      case 'sin': return sin(value * pi / 180);
      case 'cos': return cos(value * pi / 180);
      case 'tan': return tan(value * pi / 180);
      case 'log': return log(value) / ln10;
      case 'ln': return log(value);
      case 'sqrt': return sqrt(value);
      case 'square': return value * value;
      default: return value;
    }
  }
}