# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.3.0] - 2026-03-06

### Added
- **Custom Expression System** - Original implementation inspired by math_expressions
  - Expression tree structure with base Expression class
  - Binary operations: Add, Subtract, Multiply, Divide, Modulo, Power
  - Unary operations: Negate, Sin, Cos, Tan, Asin, Acos, Atan, Ln, Log, Sqrt, Abs, Ceil, Floor, Exp
  - Expression simplification with constant folding and identity rules
  - Variable binding and evaluation
  - Lexer for tokenizing mathematical expressions
  - Parser using Shunting Yard algorithm for proper operator precedence
  - Support for parentheses and nested expressions
  - Support for variable names with numbers (e.g., x1, x2, y1, y2)
- **ExpressionCalculator** - High-level API for expression evaluation
  - Parse string expressions into expression trees
  - Evaluate expressions with variable substitution
  - Simplify expressions
  - Format results for display
- Comprehensive test suite with 60+ test cases
- Example application demonstrating all features
- LICENSE file with MIT license
- Author and acknowledgments information

### Changed
- Removed math_expressions dependency - now using custom implementation
- Updated package version to 0.3.0
- Enhanced documentation with expression system architecture

### Acknowledgments
- Expression system design inspired by [math_expressions](https://pub.dev/packages/math_expressions)
- Implementation is completely original and written from scratch
- Author: **H1S97X**

### Technical Details
- Zero external dependencies (pure Dart implementation)
- Follows established design patterns from math_expressions
- Maintains compatibility with existing BasicCalculator and ScientificCalculator APIs
- Expression tree allows for future extensions (differentiation, optimization, etc.)

## [0.2.0] - 2026-03-06

### Added
- **ExpressionCalculator** - Advanced calculator using math_expressions library
  - Robust expression parsing with proper operator precedence
  - Variable binding and evaluation
  - Expression simplification
  - Symbolic differentiation
  - Support for complex mathematical expressions
  - Custom function creation
  - Variable extraction from expressions
  - Expression validation
- Integration with math_expressions library for advanced features
- Support for additional functions: arcsin, arccos, arctan, abs, ceil, floor, sgn
- Symbol normalization (π, ×, ÷, ², ³)
- Comprehensive test suite for ExpressionCalculator

### Changed
- Updated package version to 0.2.0
- Enhanced documentation with ExpressionCalculator examples

## [0.1.0] - 2026-03-06

### Added
- Initial release of ArithmeticKit
- BasicCalculator with support for +, -, ×, ÷, % operations
- ScientificCalculator with trigonometric functions (sin, cos, tan, asin, acos, atan)
- Logarithmic functions (log, ln)
- Power operations (^, x², e^, 10^)
- Square root function (sqrt)
- Mathematical constants (π, e)
- Input validation for basic calculator
- Comprehensive documentation and examples
- Zero external dependencies (except math_expressions in v0.2.0)
