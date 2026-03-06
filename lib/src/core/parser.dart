import 'expression.dart';
import 'token.dart';
import 'lexer.dart';

/// Parser for mathematical expressions
/// 
/// Uses Shunting Yard algorithm to convert infix notation to expression tree.
/// 
/// This implementation is inspired by the parsing approach in math_expressions
/// library, but written from scratch with original code.
/// 
/// Author: H1S97X
/// Reference: https://pub.dev/packages/math_expressions
class ExpressionParser {
  final Lexer _lexer = Lexer();
  
  /// Parse a string expression into an Expression tree
  Expression parse(String input) {
    if (input.isEmpty) {
      throw ArgumentError('Input string is empty');
    }
    
    // Tokenize input
    final tokens = _lexer.tokenize(input);
    
    // Convert to RPN using Shunting Yard
    final rpnTokens = _shuntingYard(tokens);
    
    // Build expression tree from RPN
    return _buildExpression(rpnTokens);
  }
  
  /// Convert infix token stream to RPN using Shunting Yard algorithm
  List<Token> _shuntingYard(List<Token> tokens) {
    final output = <Token>[];
    final operators = <Token>[];
    Token? prevToken;
    
    for (final token in tokens) {
      // Numbers and variables go directly to output
      if (token.type == TokenType.number || token.type == TokenType.variable) {
        output.add(token);
        prevToken = token;
        continue;
      }
      
      // Functions go to operator stack
      if (token.type.isFunction) {
        operators.add(token);
        prevToken = token;
        continue;
      }
      
      // Handle unary minus
      if (token.type == TokenType.minus &&
          (prevToken == null ||
           prevToken.type.isOperator ||
           prevToken.type == TokenType.leftParen)) {
        operators.add(Token(TokenType.unaryMinus, token.text));
        prevToken = Token(TokenType.unaryMinus, token.text);
        continue;
      }
      
      // Handle operators
      if (token.type.isOperator) {
        while (operators.isNotEmpty) {
          final top = operators.last;
          
          if (!top.type.isOperator && !top.type.isFunction) break;
          
          final shouldPop = (token.type.isLeftAssociative &&
                            token.type.precedence <= top.type.precedence) ||
                           (!token.type.isLeftAssociative &&
                            token.type.precedence < top.type.precedence);
          
          if (!shouldPop) break;
          
          output.add(operators.removeLast());
        }
        operators.add(token);
        prevToken = token;
        continue;
      }
      
      // Left parenthesis
      if (token.type == TokenType.leftParen) {
        operators.add(token);
        prevToken = token;
        continue;
      }
      
      // Right parenthesis
      if (token.type == TokenType.rightParen) {
        // Pop until left parenthesis
        while (operators.isNotEmpty && operators.last.type != TokenType.leftParen) {
          output.add(operators.removeLast());
        }
        
        if (operators.isEmpty) {
          throw StateError('Mismatched parentheses');
        }
        
        operators.removeLast(); // Remove left parenthesis
        
        // If there's a function on top, pop it to output
        if (operators.isNotEmpty && operators.last.type.isFunction) {
          output.add(operators.removeLast());
        }
        
        prevToken = token;
        continue;
      }
      
      // Comma (for multi-argument functions, not used yet)
      if (token.type == TokenType.comma) {
        while (operators.isNotEmpty && operators.last.type != TokenType.leftParen) {
          output.add(operators.removeLast());
        }
        prevToken = token;
        continue;
      }
    }
    
    // Pop remaining operators
    while (operators.isNotEmpty) {
      final op = operators.removeLast();
      if (op.type == TokenType.leftParen || op.type == TokenType.rightParen) {
        throw StateError('Mismatched parentheses');
      }
      output.add(op);
    }
    
    return output;
  }
  
  /// Build expression tree from RPN token stream
  Expression _buildExpression(List<Token> rpnTokens) {
    final stack = <Expression>[];
    
    for (final token in rpnTokens) {
      Expression expr;
      
      switch (token.type) {
        case TokenType.number:
          expr = NumberExpression(double.parse(token.text));
          break;
          
        case TokenType.variable:
          expr = VariableExpression(token.text);
          break;
          
        case TokenType.unaryMinus:
          if (stack.isEmpty) throw StateError('Invalid expression');
          expr = NegateExpression(stack.removeLast());
          break;
          
        case TokenType.plus:
          if (stack.length < 2) throw StateError('Invalid expression');
          final right = stack.removeLast();
          final left = stack.removeLast();
          expr = AddExpression(left, right);
          break;
          
        case TokenType.minus:
          if (stack.length < 2) throw StateError('Invalid expression');
          final right = stack.removeLast();
          final left = stack.removeLast();
          expr = SubtractExpression(left, right);
          break;
          
        case TokenType.multiply:
          if (stack.length < 2) throw StateError('Invalid expression');
          final right = stack.removeLast();
          final left = stack.removeLast();
          expr = MultiplyExpression(left, right);
          break;
          
        case TokenType.divide:
          if (stack.length < 2) throw StateError('Invalid expression');
          final right = stack.removeLast();
          final left = stack.removeLast();
          expr = DivideExpression(left, right);
          break;
          
        case TokenType.modulo:
          if (stack.length < 2) throw StateError('Invalid expression');
          final right = stack.removeLast();
          final left = stack.removeLast();
          expr = ModuloExpression(left, right);
          break;
          
        case TokenType.power:
          if (stack.length < 2) throw StateError('Invalid expression');
          final right = stack.removeLast();
          final left = stack.removeLast();
          expr = PowerExpression(left, right);
          break;
          
        case TokenType.sin:
          if (stack.isEmpty) throw StateError('Invalid expression');
          expr = SinExpression(stack.removeLast());
          break;
          
        case TokenType.cos:
          if (stack.isEmpty) throw StateError('Invalid expression');
          expr = CosExpression(stack.removeLast());
          break;
          
        case TokenType.tan:
          if (stack.isEmpty) throw StateError('Invalid expression');
          expr = TanExpression(stack.removeLast());
          break;
          
        case TokenType.asin:
          if (stack.isEmpty) throw StateError('Invalid expression');
          expr = AsinExpression(stack.removeLast());
          break;
          
        case TokenType.acos:
          if (stack.isEmpty) throw StateError('Invalid expression');
          expr = AcosExpression(stack.removeLast());
          break;
          
        case TokenType.atan:
          if (stack.isEmpty) throw StateError('Invalid expression');
          expr = AtanExpression(stack.removeLast());
          break;
          
        case TokenType.ln:
          if (stack.isEmpty) throw StateError('Invalid expression');
          expr = LnExpression(stack.removeLast());
          break;
          
        case TokenType.log:
          if (stack.isEmpty) throw StateError('Invalid expression');
          expr = LogExpression(stack.removeLast());
          break;
          
        case TokenType.sqrt:
          if (stack.isEmpty) throw StateError('Invalid expression');
          expr = SqrtExpression(stack.removeLast());
          break;
          
        case TokenType.abs:
          if (stack.isEmpty) throw StateError('Invalid expression');
          expr = AbsExpression(stack.removeLast());
          break;
          
        case TokenType.ceil:
          if (stack.isEmpty) throw StateError('Invalid expression');
          expr = CeilExpression(stack.removeLast());
          break;
          
        case TokenType.floor:
          if (stack.isEmpty) throw StateError('Invalid expression');
          expr = FloorExpression(stack.removeLast());
          break;
          
        case TokenType.exp:
          if (stack.isEmpty) throw StateError('Invalid expression');
          expr = ExpExpression(stack.removeLast());
          break;
          
        default:
          throw ArgumentError('Unsupported token: $token');
      }
      
      stack.add(expr);
    }
    
    if (stack.length != 1) {
      throw StateError('Invalid expression: multiple values remain');
    }
    
    return stack.first;
  }
}
