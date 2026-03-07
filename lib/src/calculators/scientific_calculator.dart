import 'dart:math' as math;

/// Scientific calculator with advanced mathematical functions
class ScientificCalculator {
  /// Calculate scientific expression
  ///
  /// Supports:
  /// - Basic operations: +, -, ×, ÷, %
  /// - Trigonometric: sin, cos, tan, asin, acos, atan
  /// - Logarithmic: log, ln
  /// - Power: ^, x²
  /// - Root: sqrt
  /// - Constants: π, e
  /// - Special: 10^, e^
  ///
  /// Example:
  /// ```dart
  /// final result = ScientificCalculator.calculate('sin(π/2)');
  /// print(result); // '1'
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

      // Check if result is valid
      if (result.isNaN || result.isInfinite) {
        return 'Error';
      }

      // Format result
      return _formatResult(result);
    } catch (e) {
      return 'Error';
    }
  }

  /// Evaluate expression
  static double _evaluateExpression(String expression) {
    // Add implicit multiplication
    expression = _addImplicitMultiplication(expression);

    // Process scientific functions
    expression = _processScientificFunctions(expression);

    // Process power operations
    expression = _processPower(expression);

    // Use basic calculation logic for remaining operations
    return _evaluateBasic(expression);
  }

  /// Add implicit multiplication where needed
  static String _addImplicitMultiplication(String expression) {
    StringBuffer result = StringBuffer();

    for (int i = 0; i < expression.length; i++) {
      result.write(expression[i]);

      if (i < expression.length - 1) {
        String current = expression[i];
        String next = expression[i + 1];

        // Add * between:
        // - number and (
        // - ) and number
        // - ) and (
        // - constant and number
        bool needsMultiplication = false;

        if (current == ')' && (next == '(' || _isDigit(next))) {
          needsMultiplication = true;
        } else if (_isDigit(current) && next == '(') {
          needsMultiplication = true;
        } else if ((current == 'π' || current == 'e') &&
            (_isDigit(next) || next == '(')) {
          needsMultiplication = true;
        } else if (current == ')' && (next == 'π' || next == 'e')) {
          needsMultiplication = true;
        }

        if (needsMultiplication) {
          result.write('*');
        }
      }
    }

    return result.toString();
  }

  /// Check if character is a digit
  static bool _isDigit(String char) {
    return char.codeUnitAt(0) >= 48 && char.codeUnitAt(0) <= 57;
  }

  /// Process scientific functions
  static String _processScientificFunctions(String expression) {
    // Process 10^ and e^ first to avoid premature replacement of e
    // Process 10^ (power of 10)
    while (expression.contains('10^')) {
      int index = expression.indexOf('10^');
      int numStart = index + 3;
      String numStr = _extractNumber(expression, numStart);
      if (numStr.isEmpty) break;
      double num = double.parse(numStr);
      double result = math.pow(10, num).toDouble();
      String resultStr = result.toString();
      expression = expression.replaceFirst('10^$numStr', resultStr);
    }

    // Process e^ (power of e) - must be before replacing standalone e
    while (expression.contains('e^')) {
      int index = expression.indexOf('e^');
      int numStart = index + 2;
      String numStr = _extractNumber(expression, numStart);
      if (numStr.isEmpty) break;
      double num = double.parse(numStr);
      double result = math.exp(num);
      expression = expression.replaceFirst('e^$numStr', result.toString());
    }

    // Now safe to replace π and e constants
    // But be careful not to replace 'e' in scientific notation (e.g., 1e-10)
    expression = expression.replaceAll('π', math.pi.toString());

    // Replace 'e' only when it's not part of scientific notation
    StringBuffer result = StringBuffer();
    for (int i = 0; i < expression.length; i++) {
      if (expression[i] == 'e') {
        // Check if this is scientific notation
        bool isScientificNotation = false;
        if (i > 0 && i < expression.length - 1) {
          String prev = expression[i - 1];
          String next = expression[i + 1];
          // If previous is digit and next is +/- or digit, it's scientific notation
          if (_isDigit(prev) &&
              (next == '+' || next == '-' || _isDigit(next))) {
            isScientificNotation = true;
          }
        }

        if (!isScientificNotation) {
          result.write(math.e.toString());
        } else {
          result.write('e');
        }
      } else {
        result.write(expression[i]);
      }
    }
    expression = result.toString();

    // Process asin (arcsine)
    while (expression.contains('asin')) {
      int index = expression.indexOf('asin');
      int numStart = index + 4;
      String numStr = _extractNumber(expression, numStart);
      double num = double.parse(numStr);
      double result = math.asin(num);
      expression = expression.replaceFirst('asin$numStr', result.toString());
    }

    // Process acos (arccosine)
    while (expression.contains('acos')) {
      int index = expression.indexOf('acos');
      int numStart = index + 4;
      String numStr = _extractNumber(expression, numStart);
      double num = double.parse(numStr);
      double result = math.acos(num);
      expression = expression.replaceFirst('acos$numStr', result.toString());
    }

    // Process atan (arctangent)
    while (expression.contains('atan')) {
      int index = expression.indexOf('atan');
      int numStart = index + 4;
      String numStr = _extractNumber(expression, numStart);
      double num = double.parse(numStr);
      double result = math.atan(num);
      expression = expression.replaceFirst('atan$numStr', result.toString());
    }

    // Process sqrt
    while (expression.contains('sqrt')) {
      int index = expression.indexOf('sqrt');
      int numStart = index + 4;
      String numStr = _extractNumber(expression, numStart);
      double num = double.parse(numStr);
      double result = math.sqrt(num);
      expression = expression.replaceFirst('sqrt$numStr', result.toString());
    }

    // Process x² (square)
    while (expression.contains('x²')) {
      int index = expression.indexOf('x²');
      String numStr = _extractNumberBackward(expression, index - 1);
      double num = double.parse(numStr);
      double result = num * num;
      expression = expression.replaceFirst('${numStr}x²', result.toString());
    }

    // Process sin
    while (expression.contains('sin')) {
      int index = expression.indexOf('sin');
      int numStart = index + 3;
      String numStr = _extractNumber(expression, numStart);
      double num = double.parse(numStr);
      double result = math.sin(num);
      expression = expression.replaceFirst('sin$numStr', result.toString());
    }

    // Process cos
    while (expression.contains('cos')) {
      int index = expression.indexOf('cos');
      int numStart = index + 3;
      String numStr = _extractNumber(expression, numStart);
      double num = double.parse(numStr);
      double result = math.cos(num);
      expression = expression.replaceFirst('cos$numStr', result.toString());
    }

    // Process tan
    while (expression.contains('tan')) {
      int index = expression.indexOf('tan');
      int numStart = index + 3;
      String numStr = _extractNumber(expression, numStart);
      double num = double.parse(numStr);
      double result = math.tan(num);
      expression = expression.replaceFirst('tan$numStr', result.toString());
    }

    // Process log
    while (expression.contains('log')) {
      int index = expression.indexOf('log');
      int numStart = index + 3;
      String numStr = _extractNumber(expression, numStart);
      double num = double.parse(numStr);
      double result = math.log(num) / math.ln10;
      expression = expression.replaceFirst('log$numStr', result.toString());
    }

    // Process ln
    while (expression.contains('ln')) {
      int index = expression.indexOf('ln');
      int numStart = index + 2;
      String numStr = _extractNumber(expression, numStart);
      double num = double.parse(numStr);
      double result = math.log(num);
      expression = expression.replaceFirst('ln$numStr', result.toString());
    }

    return expression;
  }

  /// Extract number from position
  static String _extractNumber(String expression, int start) {
    StringBuffer num = StringBuffer();

    // Handle negative sign at the start
    if (start < expression.length && expression[start] == '-') {
      num.write('-');
      start++;
    }

    bool hasE = false;
    for (int i = start; i < expression.length; i++) {
      String char = expression[i];
      if (char == '.' ||
          (char.codeUnitAt(0) >= 48 && char.codeUnitAt(0) <= 57)) {
        num.write(char);
      } else if (char == 'e' && !hasE && i > start) {
        // This might be scientific notation
        num.write(char);
        hasE = true;
        // Check if next char is +/- and include it
        if (i + 1 < expression.length &&
            (expression[i + 1] == '+' || expression[i + 1] == '-')) {
          num.write(expression[i + 1]);
          i++; // Skip the +/- in next iteration
        }
      } else {
        break;
      }
    }
    return num.toString();
  }

  /// Process power operations
  static String _processPower(String expression) {
    while (expression.contains('^')) {
      int index = expression.indexOf('^');

      // Extract left operand
      String leftStr = _extractNumberBackward(expression, index - 1);
      double left = double.parse(leftStr);

      // Extract right operand
      String rightStr = _extractNumber(expression, index + 1);
      double right = double.parse(rightStr);

      // Calculate result
      double result = math.pow(left, right).toDouble();

      // Replace in expression
      expression = expression.replaceFirst(
        '$leftStr^$rightStr',
        result.toString(),
      );
    }

    return expression;
  }

  /// Extract number backward from position
  static String _extractNumberBackward(String expression, int end) {
    StringBuffer num = StringBuffer();
    bool hasNegative = false;
    bool hasE = false;

    for (int i = end; i >= 0; i--) {
      String char = expression[i];
      if (char == '.' ||
          (char.codeUnitAt(0) >= 48 && char.codeUnitAt(0) <= 57)) {
        num.write(char);
      } else if (char == 'e' && !hasE) {
        // This might be scientific notation
        num.write(char);
        hasE = true;
      } else if ((char == '+' || char == '-') &&
          hasE &&
          i > 0 &&
          expression[i - 1] == 'e') {
        // This is the sign in scientific notation (e.g., e-10)
        num.write(char);
      } else if (char == '-' && i > 0 && !hasNegative) {
        // Check if this is a negative sign (not subtraction operator)
        String prevChar = expression[i - 1];
        if (prevChar == '(' ||
            prevChar == '^' ||
            prevChar == '*' ||
            prevChar == '/' ||
            prevChar == '+' ||
            prevChar == '-') {
          num.write(char);
          hasNegative = true;
        }
        break;
      } else {
        break;
      }
    }
    return num.toString().split('').reversed.join();
  }

  /// Basic evaluation (simple eval logic)
  static double _evaluateBasic(String expression) {
    // Process parentheses
    while (expression.contains('(')) {
      int closeIndex = expression.indexOf(')');
      int openIndex = expression.lastIndexOf('(', closeIndex);
      String subExpr = expression.substring(openIndex + 1, closeIndex);
      double subResult = _evaluateBasic(subExpr);
      expression =
          expression.substring(0, openIndex) +
          subResult.toString() +
          expression.substring(closeIndex + 1);
    }

    // Process multiplication and division
    expression = _processMulDiv(expression);

    // Process addition and subtraction
    return _processAddSub(expression);
  }

  /// Process multiplication and division
  static String _processMulDiv(String expression) {
    while (expression.contains('*') || expression.contains('/')) {
      int mulIndex = expression.indexOf('*');
      int divIndex = expression.indexOf('/');

      int opIndex;
      String op;
      if (mulIndex == -1) {
        opIndex = divIndex;
        op = '/';
      } else if (divIndex == -1) {
        opIndex = mulIndex;
        op = '*';
      } else {
        if (mulIndex < divIndex) {
          opIndex = mulIndex;
          op = '*';
        } else {
          opIndex = divIndex;
          op = '/';
        }
      }

      String leftStr = _extractNumberBackward(expression, opIndex - 1);
      String rightStr = _extractNumber(expression, opIndex + 1);
      double left = double.parse(leftStr);
      double right = double.parse(rightStr);

      double result = op == '*' ? left * right : left / right;

      expression = expression.replaceFirst(
        '$leftStr$op$rightStr',
        result.toString(),
      );
    }

    return expression;
  }

  /// Process addition and subtraction
  static double _processAddSub(String expression) {
    List<String> parts = [];
    List<String> operators = [];

    StringBuffer currentNum = StringBuffer();
    for (int i = 0; i < expression.length; i++) {
      String char = expression[i];
      if (char == '+' || char == '-') {
        // Check if this is part of scientific notation (e.g., 1e-10)
        bool isScientificNotation = false;
        if (i > 0 && expression[i - 1] == 'e') {
          isScientificNotation = true;
        }

        if (isScientificNotation) {
          // This is part of scientific notation, not an operator
          currentNum.write(char);
        } else if (currentNum.isNotEmpty) {
          parts.add(currentNum.toString());
          operators.add(char);
          currentNum.clear();
        } else if (char == '-') {
          currentNum.write(char);
        }
      } else {
        currentNum.write(char);
      }
    }
    if (currentNum.isNotEmpty) {
      parts.add(currentNum.toString());
    }

    if (parts.isEmpty) return 0;

    double result = double.parse(parts[0]);
    for (int i = 0; i < operators.length; i++) {
      if (operators[i] == '+') {
        result += double.parse(parts[i + 1]);
      } else {
        result -= double.parse(parts[i + 1]);
      }
    }

    return result;
  }

  /// Format result
  static String _formatResult(double result) {
    if (result == result.toInt() && result.abs() < 1e10) {
      return result.toInt().toString();
    }

    if (result.abs() >= 1e10 || (result.abs() < 1e-6 && result != 0)) {
      return result.toStringAsExponential(6);
    }

    String resultStr = result.toStringAsFixed(8);
    resultStr = resultStr.replaceAll(RegExp(r'0+$'), '');
    resultStr = resultStr.replaceAll(RegExp(r'\.$'), '');

    return resultStr;
  }
}
