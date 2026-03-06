/// Token types for mathematical expressions
enum TokenType {
  // Values
  number,
  variable,
  
  // Operators
  plus,
  minus,
  multiply,
  divide,
  modulo,
  power,
  unaryMinus,
  
  // Functions
  sin,
  cos,
  tan,
  asin,
  acos,
  atan,
  ln,
  log,
  sqrt,
  abs,
  ceil,
  floor,
  exp,
  
  // Delimiters
  leftParen,
  rightParen,
  comma,
}

/// Extension to provide token properties
extension TokenTypeProperties on TokenType {
  /// Whether this token is an operator
  bool get isOperator {
    switch (this) {
      case TokenType.plus:
      case TokenType.minus:
      case TokenType.multiply:
      case TokenType.divide:
      case TokenType.modulo:
      case TokenType.power:
      case TokenType.unaryMinus:
        return true;
      default:
        return false;
    }
  }
  
  /// Whether this token is a function
  bool get isFunction {
    switch (this) {
      case TokenType.sin:
      case TokenType.cos:
      case TokenType.tan:
      case TokenType.asin:
      case TokenType.acos:
      case TokenType.atan:
      case TokenType.ln:
      case TokenType.log:
      case TokenType.sqrt:
      case TokenType.abs:
      case TokenType.ceil:
      case TokenType.floor:
      case TokenType.exp:
        return true;
      default:
        return false;
    }
  }
  
  /// Operator precedence (higher = evaluated first)
  int get precedence {
    switch (this) {
      case TokenType.plus:
      case TokenType.minus:
        return 1;
      case TokenType.multiply:
      case TokenType.divide:
      case TokenType.modulo:
        return 2;
      case TokenType.power:
        return 3;
      case TokenType.unaryMinus:
        return 5;
      default:
        return 0;
    }
  }
  
  /// Whether operator is left-associative
  bool get isLeftAssociative {
    switch (this) {
      case TokenType.power:
      case TokenType.unaryMinus:
        return false;
      default:
        return true;
    }
  }
}

/// Represents a token in a mathematical expression
class Token {
  final TokenType type;
  final String text;
  
  const Token(this.type, this.text);
  
  @override
  String toString() => '($type: $text)';
  
  @override
  bool operator ==(Object other) =>
      other is Token && other.type == type && other.text == text;
  
  @override
  int get hashCode => Object.hash(type, text);
}
