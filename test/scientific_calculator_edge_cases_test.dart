import 'dart:math' as math;

import 'package:arithmetic_kit/arithmetic_kit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ScientificCalculator - Edge Cases', () {
    group('Trigonometric Functions - Special Values', () {
      test('sin special angles', () {
        // sin(0) = 0
        final sin0 = double.parse(ScientificCalculator.calculate('sin0'));
        expect(sin0, closeTo(0, 0.0001));

        // sin(π/2) = 1
        final sinPiOver2 = double.parse(
          ScientificCalculator.calculate('sin${math.pi / 2}'),
        );
        expect(sinPiOver2, closeTo(1, 0.0001));

        // sin(π) = 0
        final sinPi = double.parse(
          ScientificCalculator.calculate('sin${math.pi}'),
        );
        expect(sinPi, closeTo(0, 0.0001));
      });

      test('cos special angles', () {
        // cos(0) = 1
        final cos0 = double.parse(ScientificCalculator.calculate('cos0'));
        expect(cos0, closeTo(1, 0.0001));

        // cos(π/2) = 0
        final cosPiOver2 = double.parse(
          ScientificCalculator.calculate('cos${math.pi / 2}'),
        );
        expect(cosPiOver2, closeTo(0, 0.0001));

        // cos(π) = -1
        final cosPi = double.parse(
          ScientificCalculator.calculate('cos${math.pi}'),
        );
        expect(cosPi, closeTo(-1, 0.0001));
      });

      test('tan special angles', () {
        // tan(0) = 0
        final tan0 = double.parse(ScientificCalculator.calculate('tan0'));
        expect(tan0, closeTo(0, 0.0001));

        // tan(π/4) = 1
        final tanPiOver4 = double.parse(
          ScientificCalculator.calculate('tan${math.pi / 4}'),
        );
        expect(tanPiOver4, closeTo(1, 0.0001));
      });
    });

    group('Inverse Trigonometric Functions', () {
      test('asin valid range', () {
        // asin(0) = 0
        final asin0 = double.parse(ScientificCalculator.calculate('asin0'));
        expect(asin0, closeTo(0, 0.0001));

        // asin(1) = π/2
        final asin1 = double.parse(ScientificCalculator.calculate('asin1'));
        expect(asin1, closeTo(math.pi / 2, 0.0001));

        // asin(-1) = -π/2
        final asinNeg1 = double.parse(ScientificCalculator.calculate('asin-1'));
        expect(asinNeg1, closeTo(-math.pi / 2, 0.0001));
      });

      test('asin out of range', () {
        // asin(2) should return NaN -> Error
        expect(ScientificCalculator.calculate('asin2'), 'Error');
        expect(ScientificCalculator.calculate('asin-2'), 'Error');
      });

      test('acos valid range', () {
        // acos(1) = 0
        final acos1 = double.parse(ScientificCalculator.calculate('acos1'));
        expect(acos1, closeTo(0, 0.0001));

        // acos(0) = π/2
        final acos0 = double.parse(ScientificCalculator.calculate('acos0'));
        expect(acos0, closeTo(math.pi / 2, 0.0001));
      });

      test('atan', () {
        // atan(0) = 0
        final atan0 = double.parse(ScientificCalculator.calculate('atan0'));
        expect(atan0, closeTo(0, 0.0001));

        // atan(1) = π/4
        final atan1 = double.parse(ScientificCalculator.calculate('atan1'));
        expect(atan1, closeTo(math.pi / 4, 0.0001));
      });
    });

    group('Logarithmic Functions', () {
      test('log special values', () {
        expect(ScientificCalculator.calculate('log1'), '0');
        expect(ScientificCalculator.calculate('log10'), '1');
        expect(ScientificCalculator.calculate('log100'), '2');
        expect(ScientificCalculator.calculate('log1000'), '3');
      });

      test('log invalid values', () {
        // log(0) = NaN -> Error
        expect(ScientificCalculator.calculate('log0'), 'Error');
        // log(-1) = NaN -> Error
        expect(ScientificCalculator.calculate('log-1'), 'Error');
      });

      test('ln special values', () {
        expect(ScientificCalculator.calculate('ln1'), '0');

        final lnE = double.parse(ScientificCalculator.calculate('ln${math.e}'));
        expect(lnE, closeTo(1, 0.0001));
      });

      test('ln invalid values', () {
        expect(ScientificCalculator.calculate('ln0'), 'Error');
        expect(ScientificCalculator.calculate('ln-1'), 'Error');
      });
    });

    group('Power Operations', () {
      test('positive powers', () {
        expect(ScientificCalculator.calculate('2^0'), '1');
        expect(ScientificCalculator.calculate('2^1'), '2');
        expect(ScientificCalculator.calculate('2^2'), '4');
        expect(ScientificCalculator.calculate('2^3'), '8');
        expect(ScientificCalculator.calculate('2^10'), '1024');
      });

      test('negative powers', () {
        expect(ScientificCalculator.calculate('2^-1'), '0.5');
        expect(ScientificCalculator.calculate('10^-1'), '0.1');

        final result = double.parse(ScientificCalculator.calculate('2^-2'));
        expect(result, closeTo(0.25, 0.0001));
      });

      test('fractional powers', () {
        expect(ScientificCalculator.calculate('4^0.5'), '2');
        expect(ScientificCalculator.calculate('9^0.5'), '3');

        final result = double.parse(
          ScientificCalculator.calculate('8^0.333333'),
        );
        expect(result, closeTo(2, 0.01));
      });

      test('zero base', () {
        expect(ScientificCalculator.calculate('0^0'), '1');
        expect(ScientificCalculator.calculate('0^1'), '0');
        expect(ScientificCalculator.calculate('0^2'), '0');
      });

      test('e power', () {
        expect(ScientificCalculator.calculate('e^0'), '1');

        final eToOne = double.parse(ScientificCalculator.calculate('e^1'));
        expect(eToOne, closeTo(math.e, 0.0001));

        final eToTwo = double.parse(ScientificCalculator.calculate('e^2'));
        expect(eToTwo, closeTo(math.e * math.e, 0.0001));
      });

      test('10 power', () {
        expect(ScientificCalculator.calculate('10^0'), '1');
        expect(ScientificCalculator.calculate('10^1'), '10');
        expect(ScientificCalculator.calculate('10^2'), '100');
        expect(ScientificCalculator.calculate('10^3'), '1000');
      });
    });

    group('Square Root', () {
      test('perfect squares', () {
        expect(ScientificCalculator.calculate('sqrt0'), '0');
        expect(ScientificCalculator.calculate('sqrt1'), '1');
        expect(ScientificCalculator.calculate('sqrt4'), '2');
        expect(ScientificCalculator.calculate('sqrt9'), '3');
        expect(ScientificCalculator.calculate('sqrt16'), '4');
        expect(ScientificCalculator.calculate('sqrt25'), '5');
        expect(ScientificCalculator.calculate('sqrt100'), '10');
      });

      test('non-perfect squares', () {
        final sqrt2 = double.parse(ScientificCalculator.calculate('sqrt2'));
        expect(sqrt2, closeTo(1.414213, 0.0001));

        final sqrt3 = double.parse(ScientificCalculator.calculate('sqrt3'));
        expect(sqrt3, closeTo(1.732050, 0.0001));
      });

      test('negative square root', () {
        // sqrt(-1) = NaN -> Error
        expect(ScientificCalculator.calculate('sqrt-1'), 'Error');
        expect(ScientificCalculator.calculate('sqrt-4'), 'Error');
      });
    });

    group('Constants', () {
      test('pi constant', () {
        final pi = double.parse(ScientificCalculator.calculate('π'));
        expect(pi, closeTo(math.pi, 0.0001));

        final piTimes2 = double.parse(ScientificCalculator.calculate('π2'));
        expect(piTimes2, closeTo(math.pi * 2, 0.0001));
      });

      test('e constant', () {
        final e = double.parse(ScientificCalculator.calculate('e'));
        expect(e, closeTo(math.e, 0.0001));

        final eTimes2 = double.parse(ScientificCalculator.calculate('e2'));
        expect(eTimes2, closeTo(math.e * 2, 0.0001));
      });
    });

    group('Parentheses', () {
      test('simple parentheses', () {
        expect(ScientificCalculator.calculate('(2+3)'), '5');
        expect(ScientificCalculator.calculate('(10-5)'), '5');
        expect(ScientificCalculator.calculate('2(3+4)'), '14');
      });

      test('nested parentheses', () {
        expect(ScientificCalculator.calculate('((2+3)4)'), '20');
        expect(ScientificCalculator.calculate('2((3+4)5)'), '70');
      });

      test('multiple parentheses', () {
        expect(ScientificCalculator.calculate('(2+3)(4+5)'), '45');
        expect(ScientificCalculator.calculate('(10-5)+(3×2)'), '11');
      });
    });

    group('Complex Expressions', () {
      test('mixed functions and operations', () {
        // sin(0) + cos(0) = 0 + 1 = 1
        final result1 = double.parse(
          ScientificCalculator.calculate('sin0+cos0'),
        );
        expect(result1, closeTo(1, 0.0001));

        // log(10) × 2 = 1 × 2 = 2
        expect(ScientificCalculator.calculate('log10×2'), '2');
      });

      test('functions with constants', () {
        // sin(π) = 0
        final sinPi = double.parse(ScientificCalculator.calculate('sinπ'));
        expect(sinPi, closeTo(0, 0.0001));

        // ln(e) = 1
        final lnE = double.parse(ScientificCalculator.calculate('lne'));
        expect(lnE, closeTo(1, 0.0001));
      });
    });

    group('Error Handling', () {
      test('invalid results return Error', () {
        expect(ScientificCalculator.calculate('sqrt-1'), 'Error');
        expect(ScientificCalculator.calculate('log0'), 'Error');
        expect(ScientificCalculator.calculate('ln-1'), 'Error');
        expect(ScientificCalculator.calculate('asin2'), 'Error');
      });

      test('empty or zero', () {
        expect(ScientificCalculator.calculate(''), '0');
        expect(ScientificCalculator.calculate('0'), '0');
      });
    });

    group('Formatting', () {
      test('scientific notation for large numbers', () {
        final result = ScientificCalculator.calculate('10^20');
        expect(result, contains('e'));
      });

      test('scientific notation for small numbers', () {
        final result = ScientificCalculator.calculate('10^-10');
        expect(result, contains('e'));
      });

      test('normal notation for reasonable numbers', () {
        expect(ScientificCalculator.calculate('2^8'), '256');
        expect(ScientificCalculator.calculate('10^3'), '1000');
      });
    });
  });
}
