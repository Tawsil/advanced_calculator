import 'package:flutter/material.dart';

class ScientificPanel extends StatelessWidget {
  final Function(String) onScientificButtonPressed;

  const ScientificPanel({
    super.key,
    required this.onScientificButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 4,
      children: [
        'sin', 'cos', 'tan', 'π',
        'log', 'ln', '√', 'e',
        'x²', '(', ')', 'C',
      ].map((text) {
        return Container(
          margin: const EdgeInsets.all(2),
          child: ElevatedButton(
            onPressed: () => onScientificButtonPressed(text),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
              foregroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        );
      }).toList(),
    );
  }
}