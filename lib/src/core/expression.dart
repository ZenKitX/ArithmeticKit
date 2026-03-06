import 'dart:math' as math;

/// Base class for all mathematical expressions
/// 
/// This expression system is inspired by the design patterns from the
/// math_expressions library, but implemented from scratch with original code.
/// 
/// Author: H1S97X
/// 
/// Reference: https://pub.dev/packages/math_expressions
/// 
/// Inspired by expression tree design patterns, this provides a unified
/// interface for all mathematical operations and values.
abstract class Expression {
  /// Evaluate this expression and return the result
  double evaluate([Map<String, double>? variables]);
  
  /// Get a string representation of this expression
  @override
  String toString();
  
  /// Simplify this expression if possible
  Expression simplify() => this;
}

/// Represents a numeric literal
class NumberExpression extends Expression {
  final double value;
  
  NumberExpression(this.value);
  
  @override
  double evaluate([Map<String, double>? variables]) => value;
  
  @override
  String toString() => value == value.toInt() ? value.toInt().toString() : value.toString();
  
  @override
  Expression simplify() => this;
}

/// Represents a variable
class VariableExpression extends Expression {
  final String name;
  
  VariableExpression(this.name);
  
  @override
  double evaluate([Map<String, double>? variables]) {
    if (variables == null || !variables.containsKey(name)) {
      throw ArgumentError('Variable "$name" is not defined');
    }
    return variables[name]!;
  }
  
  @override
  String toString() => name;
}

/// Base class for binary operations
abstract class BinaryExpression extends Expression {
  final Expression left;
  final Expression right;
  
  BinaryExpression(this.left, this.right);
  
  String get operator;
  double compute(double left, double right);
  
  @override
  double evaluate([Map<String, double>? variables]) {
    return compute(
      left.evaluate(variables),
      right.evaluate(variables),
    );
  }
  
  @override
  String toString() => '($left $operator $right)';
}

/// Addition operation
class AddExpression extends BinaryExpression {
  AddExpression(super.left, super.right);
  
  @override
  String get operator => '+';
  
  @override
  double compute(double left, double right) => left + right;
  
  @override
  Expression simplify() {
    final l = left.simplify();
    final r = right.simplify();
    
    // 0 + x = x
    if (l is NumberExpression && l.value == 0) return r;
    // x + 0 = x
    if (r is NumberExpression && r.value == 0) return l;
    // Constant folding: 2 + 3 = 5
    if (l is NumberExpression && r is NumberExpression) {
      return NumberExpression(l.value + r.value);
    }
    
    return AddExpression(l, r);
  }
}

/// Subtraction operation
class SubtractExpression extends BinaryExpression {
  SubtractExpression(super.left, super.right);
  
  @override
  String get operator => '-';
  
  @override
  double compute(double left, double right) => left - right;
  
  @override
  Expression simplify() {
    final l = left.simplify();
    final r = right.simplify();
    
    // x - 0 = x
    if (r is NumberExpression && r.value == 0) return l;
    // x - x = 0 (if same variable)
    if (l.toString() == r.toString()) return NumberExpression(0);
    // Constant folding
    if (l is NumberExpression && r is NumberExpression) {
      return NumberExpression(l.value - r.value);
    }
    
    return SubtractExpression(l, r);
  }
}

/// Multiplication operation
class MultiplyExpression extends BinaryExpression {
  MultiplyExpression(super.left, super.right);
  
  @override
  String get operator => '*';
  
  @override
  double compute(double left, double right) => left * right;
  
  @override
  Expression simplify() {
    final l = left.simplify();
    final r = right.simplify();
    
    // 0 * x = 0
    if (l is NumberExpression && l.value == 0) return NumberExpression(0);
    // x * 0 = 0
    if (r is NumberExpression && r.value == 0) return NumberExpression(0);
    // 1 * x = x
    if (l is NumberExpression && l.value == 1) return r;
    // x * 1 = x
    if (r is NumberExpression && r.value == 1) return l;
    // Constant folding
    if (l is NumberExpression && r is NumberExpression) {
      return NumberExpression(l.value * r.value);
    }
    
    return MultiplyExpression(l, r);
  }
}

/// Division operation
class DivideExpression extends BinaryExpression {
  DivideExpression(super.left, super.right);
  
  @override
  String get operator => '/';
  
  @override
  double compute(double left, double right) {
    if (right == 0) {
      throw ArgumentError('Division by zero');
    }
    return left / right;
  }
  
  @override
  Expression simplify() {
    final l = left.simplify();
    final r = right.simplify();
    
    // x / 1 = x
    if (r is NumberExpression && r.value == 1) return l;
    // 0 / x = 0 (x != 0)
    if (l is NumberExpression && l.value == 0) return NumberExpression(0);
    // Constant folding
    if (l is NumberExpression && r is NumberExpression) {
      if (r.value == 0) throw ArgumentError('Division by zero');
      return NumberExpression(l.value / r.value);
    }
    
    return DivideExpression(l, r);
  }
}

/// Modulo operation
class ModuloExpression extends BinaryExpression {
  ModuloExpression(super.left, super.right);
  
  @override
  String get operator => '%';
  
  @override
  double compute(double left, double right) {
    if (right == 0) {
      throw ArgumentError('Modulo by zero');
    }
    return left % right;
  }
}

/// Power operation
class PowerExpression extends BinaryExpression {
  PowerExpression(super.left, super.right);
  
  @override
  String get operator => '^';
  
  @override
  double compute(double left, double right) => math.pow(left, right).toDouble();
  
  @override
  Expression simplify() {
    final l = left.simplify();
    final r = right.simplify();
    
    // x^0 = 1
    if (r is NumberExpression && r.value == 0) return NumberExpression(1);
    // x^1 = x
    if (r is NumberExpression && r.value == 1) return l;
    // 0^x = 0 (x > 0)
    if (l is NumberExpression && l.value == 0) return NumberExpression(0);
    // 1^x = 1
    if (l is NumberExpression && l.value == 1) return NumberExpression(1);
    // Constant folding
    if (l is NumberExpression && r is NumberExpression) {
      return NumberExpression(math.pow(l.value, r.value).toDouble());
    }
    
    return PowerExpression(l, r);
  }
}

/// Base class for unary operations
abstract class UnaryExpression extends Expression {
  final Expression operand;
  
  UnaryExpression(this.operand);
  
  String get functionName;
  double compute(double value);
  
  @override
  double evaluate([Map<String, double>? variables]) {
    return compute(operand.evaluate(variables));
  }
  
  @override
  String toString() => '$functionName($operand)';
  
  @override
  Expression simplify() {
    final op = operand.simplify();
    
    // Constant folding
    if (op is NumberExpression) {
      return NumberExpression(compute(op.value));
    }
    
    return createSimplified(op);
  }
  
  /// Create a new instance with simplified operand
  Expression createSimplified(Expression operand);
}

/// Negation operation
class NegateExpression extends UnaryExpression {
  NegateExpression(super.operand);
  
  @override
  String get functionName => '-';
  
  @override
  double compute(double value) => -value;
  
  @override
  Expression createSimplified(Expression operand) => NegateExpression(operand);
  
  @override
  String toString() => '(-$operand)';
}

/// Sine function
class SinExpression extends UnaryExpression {
  SinExpression(super.operand);
  
  @override
  String get functionName => 'sin';
  
  @override
  double compute(double value) => math.sin(value);
  
  @override
  Expression createSimplified(Expression operand) => SinExpression(operand);
}

/// Cosine function
class CosExpression extends UnaryExpression {
  CosExpression(super.operand);
  
  @override
  String get functionName => 'cos';
  
  @override
  double compute(double value) => math.cos(value);
  
  @override
  Expression createSimplified(Expression operand) => CosExpression(operand);
}

/// Tangent function
class TanExpression extends UnaryExpression {
  TanExpression(super.operand);
  
  @override
  String get functionName => 'tan';
  
  @override
  double compute(double value) => math.tan(value);
  
  @override
  Expression createSimplified(Expression operand) => TanExpression(operand);
}

/// Arcsine function
class AsinExpression extends UnaryExpression {
  AsinExpression(super.operand);
  
  @override
  String get functionName => 'asin';
  
  @override
  double compute(double value) => math.asin(value);
  
  @override
  Expression createSimplified(Expression operand) => AsinExpression(operand);
}

/// Arccosine function
class AcosExpression extends UnaryExpression {
  AcosExpression(super.operand);
  
  @override
  String get functionName => 'acos';
  
  @override
  double compute(double value) => math.acos(value);
  
  @override
  Expression createSimplified(Expression operand) => AcosExpression(operand);
}

/// Arctangent function
class AtanExpression extends UnaryExpression {
  AtanExpression(super.operand);
  
  @override
  String get functionName => 'atan';
  
  @override
  double compute(double value) => math.atan(value);
  
  @override
  Expression createSimplified(Expression operand) => AtanExpression(operand);
}

/// Natural logarithm
class LnExpression extends UnaryExpression {
  LnExpression(super.operand);
  
  @override
  String get functionName => 'ln';
  
  @override
  double compute(double value) {
    if (value <= 0) throw ArgumentError('ln of non-positive number');
    return math.log(value);
  }
  
  @override
  Expression createSimplified(Expression operand) => LnExpression(operand);
}

/// Base-10 logarithm
class LogExpression extends UnaryExpression {
  LogExpression(super.operand);
  
  @override
  String get functionName => 'log';
  
  @override
  double compute(double value) {
    if (value <= 0) throw ArgumentError('log of non-positive number');
    return math.log(value) / math.ln10;
  }
  
  @override
  Expression createSimplified(Expression operand) => LogExpression(operand);
}

/// Square root
class SqrtExpression extends UnaryExpression {
  SqrtExpression(super.operand);
  
  @override
  String get functionName => 'sqrt';
  
  @override
  double compute(double value) {
    if (value < 0) throw ArgumentError('sqrt of negative number');
    return math.sqrt(value);
  }
  
  @override
  Expression createSimplified(Expression operand) => SqrtExpression(operand);
}

/// Absolute value
class AbsExpression extends UnaryExpression {
  AbsExpression(super.operand);
  
  @override
  String get functionName => 'abs';
  
  @override
  double compute(double value) => value.abs();
  
  @override
  Expression createSimplified(Expression operand) => AbsExpression(operand);
}

/// Ceiling function
class CeilExpression extends UnaryExpression {
  CeilExpression(super.operand);
  
  @override
  String get functionName => 'ceil';
  
  @override
  double compute(double value) => value.ceilToDouble();
  
  @override
  Expression createSimplified(Expression operand) => CeilExpression(operand);
}

/// Floor function
class FloorExpression extends UnaryExpression {
  FloorExpression(super.operand);
  
  @override
  String get functionName => 'floor';
  
  @override
  double compute(double value) => value.floorToDouble();
  
  @override
  Expression createSimplified(Expression operand) => FloorExpression(operand);
}

/// Exponential function (e^x)
class ExpExpression extends UnaryExpression {
  ExpExpression(super.operand);
  
  @override
  String get functionName => 'exp';
  
  @override
  double compute(double value) => math.exp(value);
  
  @override
  Expression createSimplified(Expression operand) => ExpExpression(operand);
  
  @override
  String toString() => 'e^($operand)';
}
