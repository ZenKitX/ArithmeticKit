import 'package:arithmetic_kit/arithmetic_kit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BasicCalculator', () {
    group('Basic Operations', () {
      test('addition', () {
        expect(BasicCalculator.calculate('2+3'), '5');
        expect(BasicCalculator.calculate('10+20'), '30');
        expect(BasicCalculator.calculate('0.5+0.5'), '1');
      });

      test('subtraction', () {
        expect(BasicCalculator.calculate('5-3'), '2');
        expect(BasicCalculator.calculate('10-20'), '-10');
        expect(BasicCalculator.calculate('0.5-0.3'), '0.2');
      });

      test('multiplication', () {
        expect(BasicCalculator.calculate('2×3'), '6');
        expect(BasicCalculator.calculate('2*3'), '6');
        expect(BasicCalculator.calculate('0.5×2'), '1');
      });

      test('division', () {
        expect(BasicCalculator.calculate('6÷2'), '3');
        expect(BasicCalculator.calculate('6/2'), '3');
        expect(BasicCalculator.calculate('1÷2'), '0.5');
      });

      test('modulo', () {
        expect(BasicCalculator.calculate('10%3'), '1');
        expect(BasicCalculator.calculate('7%2'), '1');
      });
    });

    group('Order of Operations', () {
      test('multiplication before addition', () {
        expect(BasicCalculator.calculate('2+3×4'), '14');
      });

      test('division before subtraction', () {
        expect(BasicCalculator.calculate('10-6÷2'), '7');
      });

      test('complex expression', () {
        expect(BasicCalculator.calculate('2+3×4-6÷2'), '11');
      });
    });

    group('Edge Cases', () {
      test('empty or zero', () {
        expect(BasicCalculator.calculate(''), '0');
        expect(BasicCalculator.calculate('0'), '0');
      });

      test('division by zero', () {
        expect(BasicCalculator.calculate('5÷0'), 'Error');
      });

      test('modulo by zero', () {
        expect(BasicCalculator.calculate('5%0'), 'Error');
      });
    });

    group('Input Validation', () {
      test('valid decimal point', () {
        expect(BasicCalculator.isValidInput('3', '.'), true);
        expect(BasicCalculator.isValidInput('3.14', '.'), false);
      });

      test('decimal point after operator', () {
        expect(BasicCalculator.isValidInput('3+', '.'), false);
      });
    });
  });
}
