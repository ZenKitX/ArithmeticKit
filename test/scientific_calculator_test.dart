import 'package:flutter_test/flutter_test.dart';
import 'package:arithmetic_kit/arithmetic_kit.dart';
import 'dart:math' as math;

void main() {
  group('ScientificCalculator', () {
    group('Basic Operations', () {
      test('addition and multiplication', () {
        expect(ScientificCalculator.calculate('2+3脳4'), '14');
      });

      test('parentheses', () {
        expect(ScientificCalculator.calculate('(2+3)脳4'), '20');
      });
    });

    group('Trigonometric Functions', () {
      test('sin', () {
        final result = double.parse(ScientificCalculator.calculate('sin0'));
        expect(result, closeTo(0, 0.0001));
      });

      test('cos', () {
        final result = double.parse(ScientificCalculator.calculate('cos0'));
        expect(result, closeTo(1, 0.0001));
      });

      test('tan', () {
        final result = double.parse(ScientificCalculator.calculate('tan0'));
        expect(result, closeTo(0, 0.0001));
      });
    });

    group('Logarithmic Functions', () {
      test('log', () {
        expect(ScientificCalculator.calculate('log100'), '2');
      });

      test('ln', () {
        final result = double.parse(
          ScientificCalculator.calculate('ln${math.e}'),
        );
        expect(result, closeTo(1, 0.0001));
      });
    });

    group('Power Operations', () {
      test('power', () {
        expect(ScientificCalculator.calculate('2^8'), '256');
      });

      test('square root', () {
        expect(ScientificCalculator.calculate('sqrt16'), '4');
      });

      test('e power', () {
        final result = double.parse(ScientificCalculator.calculate('e^0'));
        expect(result, closeTo(1, 0.0001));
      });

      test('10 power', () {
        expect(ScientificCalculator.calculate('10^3'), '1000');
      });
    });

    group('Constants', () {
      test('pi', () {
        final result = double.parse(ScientificCalculator.calculate('蟺'));
        expect(result, closeTo(math.pi, 0.0001));
      });

      test('e', () {
        final result = double.parse(ScientificCalculator.calculate('e'));
        expect(result, closeTo(math.e, 0.0001));
      });
    });

    group('Edge Cases', () {
      test('empty or zero', () {
        expect(ScientificCalculator.calculate(''), '0');
        expect(ScientificCalculator.calculate('0'), '0');
      });

      test('invalid result', () {
        expect(ScientificCalculator.calculate('sqrt-1'), 'Error');
      });
    });
  });
}
