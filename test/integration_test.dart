/// Integration test to verify all components work together
import '../lib/arithmetic_kit.dart';

void main() {
  print('=== ArithmeticKit v0.3.0 Integration Test ===\n');

  // Test 1: Basic Calculator
  print('Test 1: BasicCalculator');
  assert(BasicCalculator.calculate('2+3') == '5');
  assert(BasicCalculator.calculate('10-6/2') == '7');
  assert(BasicCalculator.calculate('2+3脳4') == '14');
  print('鉁?BasicCalculator works\n');

  // Test 2: Scientific Calculator
  print('Test 2: ScientificCalculator');
  assert(ScientificCalculator.calculate('sin(0)') == '0');
  assert(ScientificCalculator.calculate('cos(0)') == '1');
  assert(ScientificCalculator.calculate('sqrt(16)') == '4');
  print('鉁?ScientificCalculator works\n');

  // Test 3: Expression Calculator - Basic
  print('Test 3: ExpressionCalculator - Basic');
  final calc = ExpressionCalculator();
  assert(calc.calculate('2+3*4') == '14');
  assert(calc.calculate('(2+3)*4') == '20');
  assert(calc.calculate('2^3') == '8');
  print('鉁?ExpressionCalculator basic operations work\n');

  // Test 4: Expression Calculator - Variables
  print('Test 4: ExpressionCalculator - Variables');
  assert(calc.calculate('2*x+3', {'x': 5.0}) == '13');
  assert(calc.calculate('x^2+y^2', {'x': 3.0, 'y': 4.0}) == '25');
  print('鉁?ExpressionCalculator variables work\n');

  // Test 5: Expression Calculator - Functions
  print('Test 5: ExpressionCalculator - Functions');
  assert(calc.calculate('sin(0)') == '0');
  assert(calc.calculate('sqrt(16)') == '4');
  assert(calc.calculate('abs(-5)') == '5');
  print('鉁?ExpressionCalculator functions work\n');

  // Test 6: Expression Simplification
  print('Test 6: Expression Simplification');
  assert(calc.simplify('x+0').toString() == 'x');
  assert(calc.simplify('x*1').toString() == 'x');
  assert(calc.simplify('x*0').toString() == '0');
  assert(calc.simplify('2+3').toString() == '5');
  print('鉁?Expression simplification works\n');

  // Test 7: Expression Tree
  print('Test 7: Expression Tree');
  final expr = calc.parse('2*x + sin(y)');
  assert(expr.evaluate({'x': 3.0, 'y': 0.0}) == 6.0);
  print('鉁?Expression tree works\n');

  // Test 8: Lexer
  print('Test 8: Lexer');
  final lexer = Lexer();
  final tokens = lexer.tokenize('2+3*4');
  assert(tokens.length == 5);
  assert(tokens[0].type == TokenType.number);
  assert(tokens[1].type == TokenType.plus);
  assert(tokens[2].type == TokenType.number);
  assert(tokens[3].type == TokenType.multiply);
  assert(tokens[4].type == TokenType.number);
  print('鉁?Lexer works\n');

  // Test 9: Parser
  print('Test 9: Parser');
  final parser = ExpressionParser();
  final parsedExpr = parser.parse('2+3*4');
  assert(parsedExpr.evaluate() == 14.0);
  print('鉁?Parser works\n');

  // Test 10: Complex Expression
  print('Test 10: Complex Expression');
  final distance = calc.calculate('sqrt((x2-x1)^2 + (y2-y1)^2)', {
    'x1': 0.0,
    'y1': 0.0,
    'x2': 3.0,
    'y2': 4.0,
  });
  assert(distance == '5');
  print('鉁?Complex expressions work\n');

  print('=== All Tests Passed! ===');
  print('ArithmeticKit v0.3.0 is working correctly.');
}
