# ArithmeticKit Quick Reference

## Installation

```yaml
dependencies:
  arithmetic_kit: ^0.3.0
```

## Import

```dart
import 'package:arithmetic_kit/arithmetic_kit.dart';
```

## Basic Calculator

```dart
// Simple operations
BasicCalculator.calculate('2+3');      // '5'
BasicCalculator.calculate('10-6');     // '4'
BasicCalculator.calculate('3×4');      // '12'
BasicCalculator.calculate('10÷2');     // '5'
BasicCalculator.calculate('10%3');     // '1'

// Complex expressions
BasicCalculator.calculate('2+3×4');    // '14' (precedence)
BasicCalculator.calculate('(2+3)×4');  // '20' (parentheses not supported)

// Validation
BasicCalculator.isValidInput('3.14', '.'); // false
```

## Scientific Calculator

```dart
// Trigonometric
ScientificCalculator.calculate('sin(0)');     // '0'
ScientificCalculator.calculate('cos(π)');     // '-1'
ScientificCalculator.calculate('tan(π/4)');   // '1'

// Inverse trig
ScientificCalculator.calculate('asin(1)');    // '1.5708'
ScientificCalculator.calculate('acos(0)');    // '1.5708'
ScientificCalculator.calculate('atan(1)');    // '0.7854'

// Logarithms
ScientificCalculator.calculate('log(100)');   // '2'
ScientificCalculator.calculate('ln(e)');      // '1'

// Powers and roots
ScientificCalculator.calculate('2^8');        // '256'
ScientificCalculator.calculate('sqrt(16)');   // '4'
ScientificCalculator.calculate('e^2');        // '7.389'
ScientificCalculator.calculate('10^3');       // '1000'
```

## Expression Calculator

### Basic Usage

```dart
final calc = ExpressionCalculator();

// Simple expressions
calc.calculate('2+3*4');           // '14'
calc.calculate('(2+3)*4');         // '20'
calc.calculate('2^3 + sqrt(16)');  // '12'
```

### With Variables

```dart
final calc = ExpressionCalculator();

// Single variable
calc.calculate('2*x+3', {'x': 5.0});  // '13'

// Multiple variables
calc.calculate('x^2+y^2', {
  'x': 3.0,
  'y': 4.0,
}); // '25'

// Variable names with numbers
calc.calculate('sqrt((x2-x1)^2 + (y2-y1)^2)', {
  'x1': 0.0, 'y1': 0.0,
  'x2': 3.0, 'y2': 4.0,
}); // '5'
```

### Expression Simplification

```dart
final calc = ExpressionCalculator();

calc.simplify('x+0');   // 'x'
calc.simplify('x*1');   // 'x'
calc.simplify('x*0');   // '0'
calc.simplify('2+3');   // '5'
calc.simplify('x^1');   // 'x'
```

### Parse and Reuse

```dart
final calc = ExpressionCalculator();

// Parse once
final expr = calc.parse('x^2 + y^2');

// Evaluate many times
print(expr.evaluate({'x': 3.0, 'y': 4.0}));   // 25.0
print(expr.evaluate({'x': 5.0, 'y': 12.0}));  // 169.0
print(expr.evaluate({'x': 8.0, 'y': 15.0}));  // 289.0
```

## Supported Functions

| Function | Description | Example |
|----------|-------------|---------|
| `sin(x)` | Sine | `sin(0)` → 0 |
| `cos(x)` | Cosine | `cos(0)` → 1 |
| `tan(x)` | Tangent | `tan(0)` → 0 |
| `asin(x)` | Arcsine | `asin(1)` → π/2 |
| `acos(x)` | Arccosine | `acos(1)` → 0 |
| `atan(x)` | Arctangent | `atan(1)` → π/4 |
| `ln(x)` | Natural log | `ln(e)` → 1 |
| `log(x)` | Base-10 log | `log(100)` → 2 |
| `sqrt(x)` | Square root | `sqrt(16)` → 4 |
| `abs(x)` | Absolute value | `abs(-5)` → 5 |
| `ceil(x)` | Ceiling | `ceil(3.2)` → 4 |
| `floor(x)` | Floor | `floor(3.8)` → 3 |
| `exp(x)` | Exponential (e^x) | `exp(1)` → e |

## Operators

| Operator | Description | Precedence | Associativity |
|----------|-------------|------------|---------------|
| `+` | Addition | 1 | Left |
| `-` | Subtraction | 1 | Left |
| `*` | Multiplication | 2 | Left |
| `/` | Division | 2 | Left |
| `%` | Modulo | 2 | Left |
| `^` | Power | 3 | Right |
| `-x` | Unary minus | 5 | Right |

## Constants

| Constant | Value | Usage |
|----------|-------|-------|
| `π` or `pi` | 3.14159... | `sin(π/2)` |
| `e` | 2.71828... | `ln(e)` |

## Common Formulas

### Quadratic Formula

```dart
// Solve ax^2 + bx + c = 0
final root1 = calc.calculate(
  '(-b + sqrt(b^2 - 4*a*c)) / (2*a)',
  {'a': 1.0, 'b': -5.0, 'c': 6.0},
);

final root2 = calc.calculate(
  '(-b - sqrt(b^2 - 4*a*c)) / (2*a)',
  {'a': 1.0, 'b': -5.0, 'c': 6.0},
);
```

### Distance Formula

```dart
final distance = calc.calculate(
  'sqrt((x2-x1)^2 + (y2-y1)^2)',
  {'x1': 0.0, 'y1': 0.0, 'x2': 3.0, 'y2': 4.0},
);
```

### Compound Interest

```dart
// A = P(1 + r)^t
final amount = calc.calculate(
  'P * (1 + r)^t',
  {'P': 1000.0, 'r': 0.05, 't': 10.0},
);
```

### Circle Area

```dart
final area = calc.calculate(
  'π * r^2',
  {'r': 5.0},
);
```

### Pythagorean Theorem

```dart
final hypotenuse = calc.calculate(
  'sqrt(a^2 + b^2)',
  {'a': 3.0, 'b': 4.0},
);
```

## Error Handling

All calculators return `'Error'` for invalid operations:

```dart
calc.calculate('1/0');      // 'Error' (division by zero)
calc.calculate('sqrt(-1)'); // 'Error' (domain error)
calc.calculate('ln(0)');    // 'Error' (undefined)
calc.calculate('log(-1)');  // 'Error' (domain error)
```

## Expression Tree API

### Building Expressions Programmatically

```dart
// Build: 2*x + 3
final expr = AddExpression(
  MultiplyExpression(
    NumberExpression(2.0),
    VariableExpression('x'),
  ),
  NumberExpression(3.0),
);

print(expr.evaluate({'x': 5.0})); // 13.0
```

### Available Expression Classes

- `NumberExpression(double)` - Numeric literal
- `VariableExpression(String)` - Variable
- `AddExpression(left, right)` - Addition
- `SubtractExpression(left, right)` - Subtraction
- `MultiplyExpression(left, right)` - Multiplication
- `DivideExpression(left, right)` - Division
- `ModuloExpression(left, right)` - Modulo
- `PowerExpression(left, right)` - Power
- `NegateExpression(operand)` - Negation
- `SinExpression(operand)` - Sine
- `CosExpression(operand)` - Cosine
- `TanExpression(operand)` - Tangent
- `AsinExpression(operand)` - Arcsine
- `AcosExpression(operand)` - Arccosine
- `AtanExpression(operand)` - Arctangent
- `LnExpression(operand)` - Natural log
- `LogExpression(operand)` - Base-10 log
- `SqrtExpression(operand)` - Square root
- `AbsExpression(operand)` - Absolute value
- `CeilExpression(operand)` - Ceiling
- `FloorExpression(operand)` - Floor
- `ExpExpression(operand)` - Exponential

## Tips

1. **Parse once, evaluate many**: If evaluating the same expression with different variables, parse it once and reuse the expression tree.

2. **Simplify for performance**: Simplification can reduce computation time for complex expressions.

3. **Use parentheses**: Make operator precedence explicit with parentheses.

4. **Variable naming**: Variables can contain letters and numbers (e.g., `x1`, `y2`, `temp1`).

5. **Radians for trig**: All trigonometric functions use radians, not degrees.

## Version History

- **0.3.0** - Custom expression system with tree evaluation
- **0.2.0** - Added ExpressionCalculator
- **0.1.0** - Initial release
