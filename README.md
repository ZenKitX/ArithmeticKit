# ArithmeticKit

A comprehensive Flutter package for arithmetic calculations with expression tree evaluation, basic and scientific calculator logic.

## Features

- 🔢 **Basic Calculator**: Addition, subtraction, multiplication, division, modulo
- 🔬 **Scientific Calculator**: Trigonometric, logarithmic, power, root functions
- 🌲 **Expression System**: Custom expression tree with parsing and evaluation
- 🎯 **Expression Calculator**: Advanced expression parsing with variables
- 📐 **Constants**: π (pi), e (Euler's number)
- 🎯 **High Precision**: Double precision calculations
- 🚀 **Zero Dependencies**: Pure Dart implementation
- ✅ **Input Validation**: Built-in validation for calculator inputs
- 🧮 **Expression Simplification**: Constant folding and identity rules
- 📊 **Variable Binding**: Evaluate expressions with variables

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  arithmetic_kit: ^0.3.0
```

Then run:

```bash
flutter pub get
```

## Quick Start

### Basic Calculator

```dart
import 'package:arithmetic_kit/arithmetic_kit.dart';

void main() {
  // Basic arithmetic
  final result1 = BasicCalculator.calculate('2+3×4');
  print(result1); // '14'
  
  final result2 = BasicCalculator.calculate('100÷4-5');
  print(result2); // '20'
  
  final result3 = BasicCalculator.calculate('10%3');
  print(result3); // '1'
  
  // Validate input
  final isValid = BasicCalculator.isValidInput('3.14', '.');
  print(isValid); // false (already has decimal point)
}
```

### Scientific Calculator

```dart
import 'package:arithmetic_kit/arithmetic_kit.dart';

void main() {
  // Trigonometric functions
  final sinResult = ScientificCalculator.calculate('sin(π/2)');
  print(sinResult); // '1'
  
  final cosResult = ScientificCalculator.calculate('cos(0)');
  print(cosResult); // '1'
  
  // Logarithmic functions
  final logResult = ScientificCalculator.calculate('log(100)');
  print(logResult); // '2'
  
  final lnResult = ScientificCalculator.calculate('ln(e)');
  print(lnResult); // '1'
  
  // Power and root
  final powerResult = ScientificCalculator.calculate('2^8');
  print(powerResult); // '256'
  
  final sqrtResult = ScientificCalculator.calculate('sqrt(16)');
  print(sqrtResult); // '4'
}
```

### Expression Calculator

The ExpressionCalculator provides advanced expression parsing and evaluation with variable support:

```dart
import 'package:arithmetic_kit/arithmetic_kit.dart';

void main() {
  final calc = ExpressionCalculator();
  
  // Simple expressions
  print(calc.calculate('2+3*4'));        // '14'
  print(calc.calculate('(2+3)*4'));      // '20'
  print(calc.calculate('2^3 + sqrt(16)')); // '12'
  
  // Expressions with variables
  print(calc.calculate('2*x+3', {'x': 5.0}));              // '13'
  print(calc.calculate('x^2+y^2', {'x': 3.0, 'y': 4.0}));  // '25'
  
  // Complex expressions
  final quadratic = calc.calculate(
    '(-b + sqrt(b^2 - 4*a*c)) / (2*a)',
    {'a': 1.0, 'b': -5.0, 'c': 6.0},
  );
  print(quadratic); // '3' (root of x^2 - 5x + 6 = 0)
  
  // Distance formula
  final distance = calc.calculate(
    'sqrt((x2-x1)^2 + (y2-y1)^2)',
    {'x1': 0.0, 'y1': 0.0, 'x2': 3.0, 'y2': 4.0},
  );
  print(distance); // '5'
  
  // Expression simplification
  print(calc.simplify('x+0'));  // 'x'
  print(calc.simplify('x*1'));  // 'x'
  print(calc.simplify('x*0'));  // '0'
  print(calc.simplify('2+3'));  // '5'
}
```

### Working with Expression Trees

For advanced use cases, you can work directly with expression trees:

```dart
import 'package:arithmetic_kit/arithmetic_kit.dart';

void main() {
  final calc = ExpressionCalculator();
  
  // Parse expression into tree
  final expr = calc.parse('2*x + sin(y)');
  print(expr); // '((2 * x) + sin(y))'
  
  // Evaluate with different variable values
  print(expr.evaluate({'x': 3.0, 'y': 0.0}));     // 6.0
  print(expr.evaluate({'x': 5.0, 'y': 1.5708}));  // 11.0 (approx)
  
  // Simplify expression
  final simplified = expr.simplify();
  print(simplified);
  
  // Build expressions programmatically
  final x = VariableExpression('x');
  final two = NumberExpression(2.0);
  final expr2 = MultiplyExpression(two, x);
  print(expr2.evaluate({'x': 5.0})); // 10.0
}
```

## Supported Operations

### Basic Calculator

| Operation | Symbol | Example | Result |
|-----------|--------|---------|--------|
| Addition | + | `2+3` | `5` |
| Subtraction | - | `5-2` | `3` |
| Multiplication | × or * | `3×4` | `12` |
| Division | ÷ or / | `10÷2` | `5` |
| Modulo | % | `10%3` | `1` |

### Scientific Calculator & Expression Calculator

#### Trigonometric Functions
- `sin(x)` - Sine (radians)
- `cos(x)` - Cosine (radians)
- `tan(x)` - Tangent (radians)
- `asin(x)` or `arcsin(x)` - Arcsine
- `acos(x)` or `arccos(x)` - Arccosine
- `atan(x)` or `arctan(x)` - Arctangent

#### Logarithmic Functions
- `log(x)` - Base-10 logarithm
- `ln(x)` - Natural logarithm (base-e)

#### Power and Root
- `x^y` - Power (x to the power of y)
- `sqrt(x)` - Square root
- `exp(x)` - Exponential (e^x)

#### Other Functions
- `abs(x)` - Absolute value
- `ceil(x)` - Ceiling (round up)
- `floor(x)` - Floor (round down)

#### Constants
- `π` or `pi` - Pi (3.14159265358979...)
- `e` - Euler's number (2.71828182845904...)

## Expression System Architecture

ArithmeticKit includes a custom expression tree system inspired by established design patterns:

```
Expression (base class)
├── NumberExpression (literals)
├── VariableExpression (variables)
├── BinaryExpression (two operands)
│   ├── AddExpression (+)
│   ├── SubtractExpression (-)
│   ├── MultiplyExpression (*)
│   ├── DivideExpression (/)
│   ├── ModuloExpression (%)
│   └── PowerExpression (^)
└── UnaryExpression (one operand)
    ├── NegateExpression (-)
    ├── SinExpression, CosExpression, TanExpression
    ├── AsinExpression, AcosExpression, AtanExpression
    ├── LnExpression, LogExpression
    ├── SqrtExpression, AbsExpression
    ├── CeilExpression, FloorExpression
    └── ExpExpression
```

### Parsing Pipeline

1. **Lexer**: Tokenizes input string into tokens
2. **Parser**: Uses Shunting Yard algorithm to convert infix to RPN
3. **Expression Builder**: Constructs expression tree from RPN tokens
4. **Evaluator**: Traverses tree to compute result

## Error Handling

All calculators return `'Error'` for invalid operations:

```dart
BasicCalculator.calculate('5÷0');           // 'Error' (division by zero)
ScientificCalculator.calculate('sqrt(-1)'); // 'Error' (invalid input)
ExpressionCalculator.calculate('1/0');      // 'Error' (division by zero)
ExpressionCalculator.calculate('ln(0)');    // 'Error' (undefined)
```

## Design Principles

1. **Zero Dependencies**: Pure Dart implementation with no external packages
2. **High Precision**: Uses double type for calculations
3. **Type Safety**: Strong typing to avoid runtime errors
4. **Clean API**: Simple, intuitive method signatures
5. **Extensible**: Expression tree allows for future enhancements
6. **Well-Tested**: Comprehensive test suite with 60+ test cases

## Examples

See the [example](example/) directory for complete examples:

- `basic_example.dart` - Basic calculator usage
- `scientific_example.dart` - Scientific calculator usage
- `expression_example.dart` - Expression calculator with variables and simplification

## API Reference

### BasicCalculator

- `static String calculate(String expression)` - Calculate basic arithmetic expression
- `static bool isValidInput(String current, String newChar)` - Validate input

### ScientificCalculator

- `static String calculate(String expression)` - Calculate scientific expression

### ExpressionCalculator

- `Expression parse(String input)` - Parse string to expression tree
- `double evaluate(String input, [Map<String, double>? variables])` - Evaluate expression
- `Expression simplify(String input)` - Simplify expression
- `String calculate(String input, [Map<String, double>? variables])` - Evaluate and format

### Expression Classes

- `Expression` - Base class for all expressions
- `NumberExpression(double value)` - Numeric literal
- `VariableExpression(String name)` - Variable
- `AddExpression(left, right)` - Addition
- `SubtractExpression(left, right)` - Subtraction
- `MultiplyExpression(left, right)` - Multiplication
- `DivideExpression(left, right)` - Division
- `PowerExpression(left, right)` - Power
- `SinExpression(operand)` - Sine function
- And many more...

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for a detailed history of changes.

## Version History

- **0.3.0** - Custom expression system with tree evaluation
- **0.2.0** - Added ExpressionCalculator with math_expressions
- **0.1.0** - Initial release with BasicCalculator and ScientificCalculator

## Acknowledgments

This package's expression system design was inspired by the [math_expressions](https://pub.dev/packages/math_expressions) library. While the implementation is completely original and written from scratch, we learned valuable design patterns and architectural approaches from studying that project.

Special thanks to:
- The math_expressions library authors for their excellent work on expression parsing and evaluation
- **H1S97X** - Package author and primary developer

## References

- [math_expressions on pub.dev](https://pub.dev/packages/math_expressions) - Inspiration for expression tree architecture
- [Shunting Yard Algorithm](https://en.wikipedia.org/wiki/Shunting-yard_algorithm) - Parsing algorithm used
- [Expression Trees](https://en.wikipedia.org/wiki/Binary_expression_tree) - Core data structure
