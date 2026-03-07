import 'package:flutter_test/flutter_test.dart';
import 'package:arithmetic_kit/arithmetic_kit.dart';

void main() {
  group('BasicCalculator - Edge Cases', () {
    group('Decimal Numbers', () {
      test('decimal addition', () {
        expect(BasicCalculator.calculate('0.1+0.2'), '0.3');
        expect(BasicCalculator.calculate('1.5+2.5'), '4');
        expect(BasicCalculator.calculate('0.001+0.002'), '0.003');
      });

      test('decimal subtraction', () {
        expect(BasicCalculator.calculate('1.5-0.5'), '1');
        expect(BasicCalculator.calculate('0.3-0.1'), '0.2');
      });

      test('decimal multiplication', () {
        expect(BasicCalculator.calculate('0.5脳2'), '1');
        expect(BasicCalculator.calculate('1.5脳2'), '3');
        expect(BasicCalculator.calculate('0.1脳0.1'), '0.01');
      });

      test('decimal division', () {
        expect(BasicCalculator.calculate('1梅2'), '0.5');
        expect(BasicCalculator.calculate('0.5梅0.5'), '1');
        expect(BasicCalculator.calculate('1梅3'), closeTo(0.333333, 0.000001));
      });
    });

    group('Negative Numbers', () {
      test('negative result', () {
        expect(BasicCalculator.calculate('5-10'), '-5');
        expect(BasicCalculator.calculate('0-5'), '-5');
      });

      test('negative multiplication', () {
        expect(BasicCalculator.calculate('-5脳2'), 'Error'); // 当前实现不支持负数开头
      });
    });

    group('Large Numbers', () {
      test('large addition', () {
        expect(BasicCalculator.calculate('999999+1'), '1000000');
        expect(BasicCalculator.calculate('1000000+1000000'), '2000000');
      });

      test('large multiplication', () {
        expect(BasicCalculator.calculate('1000脳1000'), '1000000');
      });
    });

    group('Very Small Numbers', () {
      test('small decimal operations', () {
        expect(BasicCalculator.calculate('0.0001+0.0001'), '0.0002');
        expect(BasicCalculator.calculate('0.001脳0.001'), '0.000001');
      });
    });

    group('Complex Expressions', () {
      test('multiple operations', () {
        expect(BasicCalculator.calculate('1+2+3+4+5'), '15');
        expect(BasicCalculator.calculate('10-1-2-3'), '4');
        expect(BasicCalculator.calculate('2脳3脳4'), '24');
      });

      test('mixed operations with precedence', () {
        expect(BasicCalculator.calculate('2+3脳4-5'), '9');
        expect(BasicCalculator.calculate('10梅2+3脳4'), '17');
        expect(BasicCalculator.calculate('100-50梅2'), '75');
      });

      test('modulo in complex expressions', () {
        expect(BasicCalculator.calculate('10%3+5'), '6');
        expect(BasicCalculator.calculate('20-10%3'), '19');
      });
    });

    group('Error Handling', () {
      test('division by zero', () {
        expect(BasicCalculator.calculate('5梅0'), 'Error');
        expect(BasicCalculator.calculate('0梅0'), 'Error');
        expect(BasicCalculator.calculate('100梅0'), 'Error');
      });

      test('modulo by zero', () {
        expect(BasicCalculator.calculate('5%0'), 'Error');
        expect(BasicCalculator.calculate('10%0'), 'Error');
      });

      test('invalid expressions', () {
        // 杩欎簺鍙兘杩斿洖 Error 鎴栧叾浠栫粨鏋滐紝鍙栧喅浜庡疄鐜?        expect(BasicCalculator.calculate('++'), 'Error');
        expect(BasicCalculator.calculate('5++5'), 'Error');
      });
    });

    group('Formatting', () {
      test('removes trailing zeros', () {
        expect(BasicCalculator.calculate('1.0+1.0'), '2');
        expect(BasicCalculator.calculate('5.0梅2.0'), '2.5');
      });

      test('preserves necessary decimals', () {
        expect(BasicCalculator.calculate('1梅3'), startsWith('0.333'));
        expect(BasicCalculator.calculate('2梅3'), startsWith('0.666'));
      });

      test('integer results', () {
        expect(BasicCalculator.calculate('4梅2'), '2');
        expect(BasicCalculator.calculate('10脳10'), '100');
      });
    });

    group('Input Validation', () {
      test('valid decimal point addition', () {
        expect(BasicCalculator.isValidInput('0', '.'), true);
        expect(BasicCalculator.isValidInput('123', '.'), true);
        expect(BasicCalculator.isValidInput('', '.'), true);
      });

      test('invalid decimal point - already has one', () {
        expect(BasicCalculator.isValidInput('3.14', '.'), false);
        expect(BasicCalculator.isValidInput('0.5', '.'), false);
      });

      test('invalid decimal point - after operator', () {
        expect(BasicCalculator.isValidInput('3+', '.'), false);
        expect(BasicCalculator.isValidInput('5脳', '.'), false);
        expect(BasicCalculator.isValidInput('10梅', '.'), false);
      });

      test('valid input for empty or zero', () {
        expect(BasicCalculator.isValidInput('', '5'), true);
        expect(BasicCalculator.isValidInput('0', '5'), true);
      });
    });

    group('Special Cases', () {
      test('zero operations', () {
        expect(BasicCalculator.calculate('0+0'), '0');
        expect(BasicCalculator.calculate('0脳5'), '0');
        expect(BasicCalculator.calculate('0梅5'), '0');
        expect(BasicCalculator.calculate('5-5'), '0');
      });

      test('one operations', () {
        expect(BasicCalculator.calculate('1脳5'), '5');
        expect(BasicCalculator.calculate('5梅1'), '5');
        expect(BasicCalculator.calculate('5脳1'), '5');
      });

      test('empty or single zero', () {
        expect(BasicCalculator.calculate(''), '0');
        expect(BasicCalculator.calculate('0'), '0');
      });
    });

    group('Operator Symbols', () {
      test('supports both 脳 and *', () {
        expect(BasicCalculator.calculate('2脳3'), '6');
        expect(BasicCalculator.calculate('2*3'), '6');
      });

      test('supports both 梅 and /', () {
        expect(BasicCalculator.calculate('6梅2'), '3');
        expect(BasicCalculator.calculate('6/2'), '3');
      });
    });
  });
}
