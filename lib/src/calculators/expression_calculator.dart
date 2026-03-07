import '../core/expression.dart';
import '../core/parser.dart';

/// Advanced calculator using expression tree evaluation
///
/// Supports:
/// - Basic operations: +, -, *, /, %, ^
/// - Functions: sin, cos, tan, asin, acos, atan, ln, log, sqrt, abs, ceil, floor, exp
/// - Variables: x, y, z, etc.
/// - Expression simplification
/// - Parentheses for grouping
class ExpressionCalculator {
  final ExpressionParser _parser = ExpressionParser();

  /// Parse a string expression into an Expression tree
  ///
  /// Example:
  /// ```dart
  /// final calc = ExpressionCalculator();
  /// final expr = calc.parse('2*x + sin(y)');
  /// ```
  Expression parse(String input) {
    return _parser.parse(input);
  }

  /// Evaluate an expression string with optional variables
  ///
  /// Example:
  /// ```dart
  /// final calc = ExpressionCalculator();
  /// final result = calc.evaluate('2*x + 3', {'x': 5.0});
  /// print(result); // 13.0
  /// ```
  double evaluate(String input, [Map<String, double>? variables]) {
    final expr = parse(input);
    return expr.evaluate(variables);
  }

  /// Parse and simplify an expression
  ///
  /// Example:
  /// ```dart
  /// final calc = ExpressionCalculator();
  /// final simplified = calc.simplify('x + 0');
  /// print(simplified); // x
  /// ```
  Expression simplify(String input) {
    final expr = parse(input);
    return expr.simplify();
  }

  /// Evaluate and format result as string
  ///
  /// Example:
  /// ```dart
  /// final calc = ExpressionCalculator();
  /// final result = calc.calculate('2^3 + sqrt(16)');
  /// print(result); // '12'
  /// ```
  String calculate(String input, [Map<String, double>? variables]) {
    try {
      final result = evaluate(input, variables);
      return _formatResult(result);
    } catch (e) {
      return 'Error';
    }
  }

  /// Format result for display
  String _formatResult(double result) {
    // Handle special cases
    if (result.isNaN) return 'Error';
    if (result.isInfinite) return result.isNegative ? '-∞' : '∞';

    // If integer, don't show decimal point
    if (result == result.toInt()) {
      return result.toInt().toString();
    }

    // Keep at most 10 decimal places
    String resultStr = result.toStringAsFixed(10);

    // Remove trailing zeros
    resultStr = resultStr.replaceAll(RegExp(r'0+$'), '');
    resultStr = resultStr.replaceAll(RegExp(r'\.$'), '');

    return resultStr;
  }
}
