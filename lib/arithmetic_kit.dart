library arithmetic_kit;

/// ArithmeticKit - Comprehensive arithmetic calculation package
///
/// A pure Dart package providing basic and scientific calculator functionality
/// with expression tree evaluation and zero external dependencies.
///
/// ## Author
///
/// **H1S97X**
///
/// ## Acknowledgments
///
/// The expression system design was inspired by the math_expressions library.
/// While the implementation is completely original, we learned valuable design
/// patterns from studying that project.
///
/// Reference: https://pub.dev/packages/math_expressions
///
/// ## Features
///
/// - 🔢 **Basic Calculator**: Addition, subtraction, multiplication, division, modulo
/// - 🔬 **Scientific Calculator**: Trigonometric, logarithmic, power, root functions
/// - 🌲 **Expression System**: Custom expression tree with parsing and evaluation
/// - 📐 **Mathematical Constants**: π (pi), e (Euler's number)
/// - 🎯 **High Precision**: Double precision floating-point calculations
/// - 🚀 **Zero Dependencies**: Pure Dart implementation, no external packages
/// - ✅ **Input Validation**: Built-in validation for calculator inputs
/// - 🎨 **Clean API**: Simple, intuitive method signatures
///
/// ## Installation
///
/// Add to your `pubspec.yaml`:
///
/// ```yaml
/// dependencies:
///   arithmetic_kit: ^0.3.0
/// ```
///
/// ## Quick Start
///
/// ### Basic Calculator
///
/// The [BasicCalculator] class provides fundamental arithmetic operations:
///
/// ```dart
/// import 'package:arithmetic_kit/arithmetic_kit.dart';
///
/// // Basic arithmetic
/// final result = BasicCalculator.calculate('2+3×4');
/// print(result); // '14'
///
/// // Supports multiple operators
/// final complex = BasicCalculator.calculate('10-6÷2+3×4');
/// print(complex); // '19'
///
/// // Validate input before adding to expression
/// final isValid = BasicCalculator.isValidInput('3.14', '.');
/// print(isValid); // false (already has decimal point)
/// ```
///
/// ### Scientific Calculator
///
/// The [ScientificCalculator] class extends basic operations with advanced
/// mathematical functions:
///
/// ```dart
/// import 'package:arithmetic_kit/arithmetic_kit.dart';
///
/// // Trigonometric functions
/// final sinResult = ScientificCalculator.calculate('sin(π/2)');
/// print(sinResult); // '1'
///
/// // Logarithmic functions
/// final logResult = ScientificCalculator.calculate('log(100)');
/// print(logResult); // '2'
///
/// // Power operations
/// final powerResult = ScientificCalculator.calculate('2^8');
/// print(powerResult); // '256'
///
/// // Square root
/// final sqrtResult = ScientificCalculator.calculate('sqrt(16)');
/// print(sqrtResult); // '4'
///
/// // Using constants
/// final piResult = ScientificCalculator.calculate('π×2');
/// print(piResult); // '6.283185...'
/// ```
///
/// ## Supported Operations
///
/// ### Basic Calculator
///
/// | Operation | Symbol | Example | Result |
/// |-----------|--------|---------|--------|
/// | Addition | + | `2+3` | `5` |
/// | Subtraction | - | `5-2` | `3` |
/// | Multiplication | × or * | `3×4` | `12` |
/// | Division | ÷ or / | `10÷2` | `5` |
/// | Modulo | % | `10%3` | `1` |
///
/// ### Scientific Calculator
///
/// #### Trigonometric Functions
/// - `sin(x)` - Sine (radians)
/// - `cos(x)` - Cosine (radians)
/// - `tan(x)` - Tangent (radians)
/// - `asin(x)` - Arcsine
/// - `acos(x)` - Arccosine
/// - `atan(x)` - Arctangent
///
/// #### Logarithmic Functions
/// - `log(x)` - Base-10 logarithm
/// - `ln(x)` - Natural logarithm (base-e)
///
/// #### Power and Root
/// - `x^y` - Power (x to the power of y)
/// - `x²` - Square
/// - `sqrt(x)` - Square root
/// - `e^x` - Exponential (e to the power of x)
/// - `10^x` - Power of 10
///
/// #### Constants
/// - `π` - Pi (3.14159265358979...)
/// - `e` - Euler's number (2.71828182845904...)
///
/// ## Error Handling
///
/// Both calculators return `'Error'` for invalid operations:
///
/// ```dart
/// BasicCalculator.calculate('5÷0');        // 'Error' (division by zero)
/// ScientificCalculator.calculate('sqrt-1'); // 'Error' (invalid input)
/// ScientificCalculator.calculate('log0');   // 'Error' (undefined)
/// ```
///
/// ## Design Principles
///
/// 1. **Zero Dependencies**: Pure Dart implementation
/// 2. **High Precision**: Uses double type for calculations
/// 3. **Type Safety**: Strong typing to avoid runtime errors
/// 4. **Clean API**: Simple, intuitive method signatures
/// 5. **Error Handling**: Graceful error handling with 'Error' return value
///
/// ## See Also
///
/// - [BasicCalculator] - Basic arithmetic operations
/// - [ScientificCalculator] - Advanced mathematical functions

// Export calculators
export 'src/calculators/basic_calculator.dart';
export 'src/calculators/scientific_calculator.dart';
export 'src/calculators/expression_calculator.dart';

// Export expression system
export 'src/core/expression.dart';
export 'src/core/token.dart';
export 'src/core/lexer.dart';
export 'src/core/parser.dart';
