import 'dart:math' as math;

import 'package:arithmetic_kit/arithmetic_kit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ExpressionCalculator', () {
    late ExpressionCalculator calc;

    setUp(() {
      calc = ExpressionCalculator();
    });

    group('Basic Operations', () {
      test('addition', () {
        expect(calc.evaluate('2+3'), equals(5.0));
        expect(calc.evaluate('10+20+30'), equals(60.0));
      });

      test('subtraction', () {
        expect(calc.evaluate('5-3'), equals(2.0));
        expect(calc.evaluate('10-5-2'), equals(3.0));
      });

      test('multiplication', () {
        expect(calc.evaluate('3*4'), equals(12.0));
        expect(calc.evaluate('2*3*4'), equals(24.0));
      });

      test('division', () {
        expect(calc.evaluate('10/2'), equals(5.0));
        expect(calc.evaluate('20/4/2'), equals(2.5));
      });

      test('modulo', () {
        expect(calc.evaluate('10%3'), equals(1.0));
        expect(calc.evaluate('17%5'), equals(2.0));
      });

      test('power', () {
        expect(calc.evaluate('2^3'), equals(8.0));
        expect(calc.evaluate('10^2'), equals(100.0));
      });
    });

    group('Operator Precedence', () {
      test('multiplication before addition', () {
        expect(calc.evaluate('2+3*4'), equals(14.0));
      });

      test('division before subtraction', () {
        expect(calc.evaluate('10-6/2'), equals(7.0));
      });

      test('power before multiplication', () {
        expect(calc.evaluate('2*3^2'), equals(18.0));
      });

      test('complex precedence', () {
        expect(calc.evaluate('2+3*4-10/2'), equals(9.0));
      });
    });

    group('Parentheses', () {
      test('simple grouping', () {
        expect(calc.evaluate('(2+3)*4'), equals(20.0));
      });

      test('nested parentheses', () {
        expect(calc.evaluate('((2+3)*4)/5'), equals(4.0));
      });

      test('multiple groups', () {
        expect(calc.evaluate('(2+3)*(4+5)'), equals(45.0));
      });
    });

    group('Unary Minus', () {
      test('negative number', () {
        expect(calc.evaluate('-5'), equals(-5.0));
      });

      test('negative in expression', () {
        expect(calc.evaluate('10+-5'), equals(5.0));
      });

      test('negative with parentheses', () {
        expect(calc.evaluate('-(2+3)'), equals(-5.0));
      });
    });

    group('Trigonometric Functions', () {
      test('sin', () {
        expect(calc.evaluate('sin(0)'), equals(0.0));
        expect(calc.evaluate('sin(${math.pi / 2})'), closeTo(1.0, 1e-10));
      });

      test('cos', () {
        expect(calc.evaluate('cos(0)'), equals(1.0));
        expect(calc.evaluate('cos(${math.pi})'), closeTo(-1.0, 1e-10));
      });

      test('tan', () {
        expect(calc.evaluate('tan(0)'), equals(0.0));
        expect(calc.evaluate('tan(${math.pi / 4})'), closeTo(1.0, 1e-10));
      });

      test('asin', () {
        expect(calc.evaluate('asin(0)'), equals(0.0));
        expect(calc.evaluate('asin(1)'), closeTo(math.pi / 2, 1e-10));
      });

      test('acos', () {
        expect(calc.evaluate('acos(1)'), equals(0.0));
        expect(calc.evaluate('acos(0)'), closeTo(math.pi / 2, 1e-10));
      });

      test('atan', () {
        expect(calc.evaluate('atan(0)'), equals(0.0));
        expect(calc.evaluate('atan(1)'), closeTo(math.pi / 4, 1e-10));
      });
    });

    group('Logarithmic Functions', () {
      test('ln', () {
        expect(calc.evaluate('ln(1)'), equals(0.0));
        expect(calc.evaluate('ln(${math.e})'), closeTo(1.0, 1e-10));
      });

      test('log', () {
        expect(calc.evaluate('log(1)'), equals(0.0));
        expect(calc.evaluate('log(10)'), closeTo(1.0, 1e-10));
        expect(calc.evaluate('log(100)'), closeTo(2.0, 1e-10));
      });
    });

    group('Other Functions', () {
      test('sqrt', () {
        expect(calc.evaluate('sqrt(4)'), equals(2.0));
        expect(calc.evaluate('sqrt(16)'), equals(4.0));
        expect(calc.evaluate('sqrt(2)'), closeTo(math.sqrt(2), 1e-10));
      });

      test('abs', () {
        expect(calc.evaluate('abs(5)'), equals(5.0));
        expect(calc.evaluate('abs(-5)'), equals(5.0));
      });

      test('ceil', () {
        expect(calc.evaluate('ceil(3.2)'), equals(4.0));
        expect(calc.evaluate('ceil(-3.2)'), equals(-3.0));
      });

      test('floor', () {
        expect(calc.evaluate('floor(3.8)'), equals(3.0));
        expect(calc.evaluate('floor(-3.2)'), equals(-4.0));
      });

      test('exp', () {
        expect(calc.evaluate('exp(0)'), equals(1.0));
        expect(calc.evaluate('exp(1)'), closeTo(math.e, 1e-10));
      });
    });

    group('Variables', () {
      test('single variable', () {
        expect(calc.evaluate('x', {'x': 5.0}), equals(5.0));
      });

      test('variable in expression', () {
        expect(calc.evaluate('2*x+3', {'x': 5.0}), equals(13.0));
      });

      test('multiple variables', () {
        expect(calc.evaluate('x+y', {'x': 3.0, 'y': 4.0}), equals(7.0));
      });

      test('complex expression with variables', () {
        expect(calc.evaluate('x^2+y^2', {'x': 3.0, 'y': 4.0}), equals(25.0));
      });
    });

    group('Expression Simplification', () {
      test('addition with zero', () {
        final expr = calc.simplify('x+0');
        expect(expr.toString(), equals('x'));
      });

      test('multiplication by one', () {
        final expr = calc.simplify('x*1');
        expect(expr.toString(), equals('x'));
      });

      test('multiplication by zero', () {
        final expr = calc.simplify('x*0');
        expect(expr.toString(), equals('0'));
      });

      test('constant folding', () {
        final expr = calc.simplify('2+3');
        expect(expr.toString(), equals('5'));
      });

      test('power simplification', () {
        final expr = calc.simplify('x^1');
        expect(expr.toString(), equals('x'));
      });
    });

    group('Complex Expressions', () {
      test('quadratic formula', () {
        // (-b + sqrt(b^2 - 4*a*c)) / (2*a)
        // For x^2 - 5x + 6 = 0, roots are 2 and 3
        final result = calc.evaluate('(-b + sqrt(b^2 - 4*a*c)) / (2*a)', {
          'a': 1.0,
          'b': -5.0,
          'c': 6.0,
        });
        expect(result, closeTo(3.0, 1e-10));
      });

      test('distance formula', () {
        // sqrt((x2-x1)^2 + (y2-y1)^2)
        final result = calc.evaluate('sqrt((x2-x1)^2 + (y2-y1)^2)', {
          'x1': 0.0,
          'y1': 0.0,
          'x2': 3.0,
          'y2': 4.0,
        });
        expect(result, equals(5.0));
      });

      test('compound interest', () {
        // P * (1 + r)^t
        final result = calc.evaluate('P * (1 + r)^t', {
          'P': 1000.0,
          'r': 0.05,
          't': 10.0,
        });
        expect(result, closeTo(1628.89, 0.01));
      });
    });

    group('Calculate Method (String Output)', () {
      test('integer result', () {
        expect(calc.calculate('2+3'), equals('5'));
      });

      test('decimal result', () {
        expect(calc.calculate('10/3'), equals('3.3333333333'));
      });

      test('error handling', () {
        expect(calc.calculate('1/0'), equals('Error'));
      });
    });

    group('Error Handling', () {
      test('division by zero', () {
        expect(() => calc.evaluate('1/0'), throwsA(isA<ArgumentError>()));
      });

      test('undefined variable', () {
        expect(() => calc.evaluate('x'), throwsA(isA<ArgumentError>()));
      });

      test('invalid syntax', () {
        expect(() => calc.evaluate('2++3'), throwsA(anything));
      });

      test('mismatched parentheses', () {
        expect(() => calc.evaluate('(2+3'), throwsA(isA<StateError>()));
      });

      test('sqrt of negative', () {
        expect(() => calc.evaluate('sqrt(-1)'), throwsA(isA<ArgumentError>()));
      });

      test('ln of non-positive', () {
        expect(() => calc.evaluate('ln(0)'), throwsA(isA<ArgumentError>()));
        expect(() => calc.evaluate('ln(-1)'), throwsA(isA<ArgumentError>()));
      });
    });
  });
}
