/// Basic calculator for arithmetic operations
class BasicCalculator {
  /// Calculate an arithmetic expression
  /// 
  /// Supports: +, -, ×, ÷, %
  /// 
  /// Example:
  /// ```dart
  /// final result = BasicCalculator.calculate('2+3×4');
  /// print(result); // '14'
  /// ```
  static String calculate(String expression) {
    try {
      // Replace display symbols with calculation symbols
      expression = expression.replaceAll('×', '*');
      expression = expression.replaceAll('÷', '/');
      
      // Remove spaces
      expression = expression.replaceAll(' ', '');
      
      // If expression is empty or only 0, return 0
      if (expression.isEmpty || expression == '0') {
        return '0';
      }
      
      // Parse and calculate expression
      double result = _evaluateExpression(expression);
      
      // Format result
      return _formatResult(result);
    } catch (e) {
      return 'Error';
    }
  }
  
  /// Evaluate expression
  static double _evaluateExpression(String expression) {
    // Handle negative numbers
    if (expression.startsWith('-')) {
      expression = '0$expression';
    }
    
    // Process multiplication, division and modulo first
    expression = _processMulDivMod(expression);
    
    // Then process addition and subtraction
    return _processAddSub(expression);
  }
  
  /// Process multiplication, division and modulo operations
  static String _processMulDivMod(String expression) {
    while (expression.contains('*') || expression.contains('/') || expression.contains('%')) {
      // Find first mul/div/mod operator
      int opIndex = -1;
      String operator = '';
      
      int mulIndex = expression.indexOf('*');
      int divIndex = expression.indexOf('/');
      int modIndex = expression.indexOf('%');
      
      // Find the leftmost operator
      List<int> indices = [mulIndex, divIndex, modIndex].where((i) => i != -1).toList();
      if (indices.isEmpty) break;
      
      opIndex = indices.reduce((a, b) => a < b ? a : b);
      operator = expression[opIndex];
      
      // Extract left operand
      int leftStart = _findNumberStart(expression, opIndex - 1);
      String leftStr = expression.substring(leftStart, opIndex);
      double left = double.parse(leftStr);
      
      // Extract right operand
      int rightEnd = _findNumberEnd(expression, opIndex + 1);
      String rightStr = expression.substring(opIndex + 1, rightEnd);
      double right = double.parse(rightStr);
      
      // Calculate result
      double result;
      if (operator == '*') {
        result = left * right;
      } else if (operator == '/') {
        if (right == 0) throw Exception('Division by zero');
        result = left / right;
      } else if (operator == '%') {
        if (right == 0) throw Exception('Modulo by zero');
        result = left % right;
      } else {
        throw Exception('Unknown operator');
      }
      
      // Replace in expression
      expression = expression.substring(0, leftStart) +
          result.toString() +
          expression.substring(rightEnd);
    }
    
    return expression;
  }
  
  /// Process addition and subtraction operations
  static double _processAddSub(String expression) {
    double result = 0;
    int i = 0;
    
    while (i < expression.length) {
      // Find next operator
      int nextOp = _findNextOperator(expression, i);
      
      if (nextOp == -1) {
        // No more operators, process last number
        String numStr = expression.substring(i);
        result += double.parse(numStr);
        break;
      }
      
      // Extract number
      String numStr = expression.substring(i, nextOp);
      double num = double.parse(numStr);
      
      if (i == 0) {
        result = num;
      } else {
        // Get previous operator
        String prevOp = expression[i - 1];
        if (prevOp == '+') {
          result += num;
        } else if (prevOp == '-') {
          result -= num;
        }
      }
      
      i = nextOp + 1;
    }
    
    return result;
  }
  
  /// Find number start position
  static int _findNumberStart(String expression, int from) {
    int start = from;
    while (start > 0) {
      String char = expression[start - 1];
      if (char == '+' || char == '-' || char == '*' || char == '/') {
        break;
      }
      start--;
    }
    return start;
  }
  
  /// Find number end position
  static int _findNumberEnd(String expression, int from) {
    int end = from;
    while (end < expression.length) {
      String char = expression[end];
      if (char == '+' || char == '-' || char == '*' || char == '/') {
        break;
      }
      end++;
    }
    return end;
  }
  
  /// Find next addition or subtraction operator
  static int _findNextOperator(String expression, int from) {
    for (int i = from; i < expression.length; i++) {
      if (expression[i] == '+' || expression[i] == '-') {
        return i;
      }
    }
    return -1;
  }
  
  /// Format result
  static String _formatResult(double result) {
    // If integer, don't show decimal point
    if (result == result.toInt()) {
      return result.toInt().toString();
    }
    
    // Keep at most 8 decimal places
    String resultStr = result.toStringAsFixed(8);
    
    // Remove trailing zeros
    resultStr = resultStr.replaceAll(RegExp(r'0+$'), '');
    resultStr = resultStr.replaceAll(RegExp(r'\.$'), '');
    
    return resultStr;
  }
  
  /// Validate if input is valid
  static bool isValidInput(String current, String newChar) {
    // Empty string, any number is ok
    if (current.isEmpty || current == '0') {
      return true;
    }
    
    // Decimal point validation
    if (newChar == '.') {
      // Get current number
      String currentNumber = _getCurrentNumber(current);
      // If current number already has decimal point, can't add another
      if (currentNumber.contains('.')) {
        return false;
      }
      // If last character is operator, need to add 0 first
      if (current.isNotEmpty && _isOperator(current[current.length - 1])) {
        return false;
      }
    }
    
    return true;
  }
  
  /// Check if character is operator
  static bool _isOperator(String char) {
    return char == '+' || char == '-' || char == '×' || char == '÷' || char == '%';
  }
  
  /// Get current number being input
  static String _getCurrentNumber(String expression) {
    int i = expression.length - 1;
    while (i >= 0 && !_isOperator(expression[i])) {
      i--;
    }
    return expression.substring(i + 1);
  }
}
