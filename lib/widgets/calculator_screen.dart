import 'package:flutter/material.dart';
import '../models/calculator_model.dart';
import '../utils/calculator_operations.dart';
import 'display_widget.dart';
import 'calculator_button.dart';
import 'scientific_panel.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final CalculatorModel _model = CalculatorModel();

  void _handleButton(String text) {
    setState(() {
      if (text == 'C') {
        _model.clear();
      } else if (text == 'DEL') {
        _model.delete();
      } else if (text == '=') {
        String result = CalculatorOperations.evaluateExpression(_model.expression);
        _model.setDisplay(result);
        _model.setExpression(result);
      } else if (['sin', 'cos', 'tan', 'log', 'ln', '√', 'x²'].contains(text)) {
        if (_model.display != '0' && _model.display != 'Error') {
          double value = double.tryParse(_model.display) ?? 0;
          double result = CalculatorOperations.calculateScientific(
            text == '√' ? 'sqrt' : text == 'x²' ? 'square' : text,
            value,
          );
          _model.setDisplay(result.toString());
          _model.setExpression(result.toString());
        }
      } else if (text == 'π') {
        _model.setDisplay('π');
        _model.setExpression(_model.expression + 'π');
      } else if (text == 'e') {
        _model.setDisplay('e');
        _model.setExpression(_model.expression + 'e');
      } else {
        if (_model.display == '0' || _model.display == 'Error') {
          _model.setDisplay(text);
          _model.setExpression(text);
        } else {
          _model.setDisplay(_model.display + text);
          _model.setExpression(_model.expression + text);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advanced Calculator'),
        actions: [
          IconButton(
            icon: Icon(_model.isScientificMode ? Icons.calculate : Icons.science),
            onPressed: () => setState(() => _model.toggleScientificMode()),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DisplayWidget(display: _model.display, expression: _model.expression),
            const SizedBox(height: 16),
            if (_model.isScientificMode) ...[
              ScientificPanel(onScientificButtonPressed: _handleButton),
              const SizedBox(height: 16),
            ],
            Expanded(
              child: GridView.count(
                crossAxisCount: 4,
                children: [
                  '7', '8', '9', '÷',
                  '4', '5', '6', '×',
                  '1', '2', '3', '-',
                  '0', '.', '=', '+',
                  'C', 'DEL', '(', ')',
                ].map((text) => CalculatorButton(
                  text: text,
                  onPressed: () => _handleButton(text),
                  isWide: text == '0',
                  backgroundColor: _getButtonColor(context, text),
                  textColor: _getButtonTextColor(context, text),
                )).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color? _getButtonColor(BuildContext context, String text) {
    if (text == '=') return Theme.of(context).colorScheme.primary;
    if (['C', 'DEL'].contains(text)) return Theme.of(context).colorScheme.errorContainer;
    if (['+', '-', '×', '÷', '(', ')'].contains(text)) return Theme.of(context).colorScheme.secondaryContainer;
    return null;
  }

  Color? _getButtonTextColor(BuildContext context, String text) {
    if (text == '=') return Theme.of(context).colorScheme.onPrimary;
    if (['C', 'DEL'].contains(text)) return Theme.of(context).colorScheme.onErrorContainer;
    if (['+', '-', '×', '÷', '(', ')'].contains(text)) return Theme.of(context).colorScheme.onSecondaryContainer;
    return null;
  }
}