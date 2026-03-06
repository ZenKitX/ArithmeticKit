import '../lib/arithmetic_kit.dart';
import 'dart:math' as math;

void main() {
  final calc = ExpressionCalculator();
  
  print('=== Basic Operations ===');
  print('2+3 = ${calc.calculate('2+3')}');
  print('10-6/2 = ${calc.calculate('10-6/2')}');
  print('2*3^2 = ${calc.calculate('2*3^2')}');
  print('(2+3)*4 = ${calc.calculate('(2+3)*4')}');
  
  print('\n=== Trigonometric Functions ===');
  print('sin(0) = ${calc.calculate('sin(0)')}');
  print('cos(0) = ${calc.calculate('cos(0)')}');
  print('tan(${math.pi/4}) = ${calc.calculate('tan(${math.pi/4})')}');
  
  print('\n=== Logarithmic Functions ===');
  print('ln(${math.e}) = ${calc.calculate('ln(${math.e})')}');
  print('log(100) = ${calc.calculate('log(100)')}');
  
  print('\n=== Other Functions ===');
  print('sqrt(16) = ${calc.calculate('sqrt(16)')}');
  print('abs(-5) = ${calc.calculate('abs(-5)')}');
  print('ceil(3.2) = ${calc.calculate('ceil(3.2)')}');
  print('floor(3.8) = ${calc.calculate('floor(3.8)')}');
  print('exp(1) = ${calc.calculate('exp(1)')}');
  
  print('\n=== Variables ===');
  print('2*x+3 where x=5: ${calc.calculate('2*x+3', {'x': 5.0})}');
  print('x^2+y^2 where x=3, y=4: ${calc.calculate('x^2+y^2', {'x': 3.0, 'y': 4.0})}');
  
  print('\n=== Expression Simplification ===');
  print('x+0 simplifies to: ${calc.simplify('x+0')}');
  print('x*1 simplifies to: ${calc.simplify('x*1')}');
  print('x*0 simplifies to: ${calc.simplify('x*0')}');
  print('2+3 simplifies to: ${calc.simplify('2+3')}');
  
  print('\n=== Complex Expressions ===');
  // Quadratic formula: (-b + sqrt(b^2 - 4*a*c)) / (2*a)
  // For x^2 - 5x + 6 = 0, roots are 2 and 3
  final root = calc.calculate(
    '(-b + sqrt(b^2 - 4*a*c)) / (2*a)',
    {'a': 1.0, 'b': -5.0, 'c': 6.0},
  );
  print('Quadratic root: $root');
  
  // Distance formula: sqrt((x2-x1)^2 + (y2-y1)^2)
  final distance = calc.calculate(
    'sqrt((x2-x1)^2 + (y2-y1)^2)',
    {'x1': 0.0, 'y1': 0.0, 'x2': 3.0, 'y2': 4.0},
  );
  print('Distance: $distance');
  
  // Compound interest: P * (1 + r)^t
  final interest = calc.calculate(
    'P * (1 + r)^t',
    {'P': 1000.0, 'r': 0.05, 't': 10.0},
  );
  print('Compound interest: $interest');
  
  print('\n=== Expression Tree ===');
  final expr = calc.parse('2*x + sin(y)');
  print('Parsed expression: $expr');
  print('Evaluated with x=3, y=0: ${expr.evaluate({'x': 3.0, 'y': 0.0})}');
}
