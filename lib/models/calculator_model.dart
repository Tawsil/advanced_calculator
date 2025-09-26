class CalculatorModel {
  String _display = '0';
  String _expression = '';
  bool _isScientificMode = false;

  String get display => _display;
  String get expression => _expression;
  bool get isScientificMode => _isScientificMode;

  void setDisplay(String value) {
    _display = value;
  }

  void setExpression(String value) {
    _expression = value;
  }

  void toggleScientificMode() {
    _isScientificMode = !_isScientificMode;
  }

  void clear() {
    _display = '0';
    _expression = '';
  }

  void delete() {
    if (_display != '0' && _display != 'Error') {
      _display = _display.length > 1 ? _display.substring(0, _display.length - 1) : '0';
    }
  }
}