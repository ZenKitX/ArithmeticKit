/// Benchmark tests for ArithmeticKit
///
/// Run with: dart run benchmark/calculator_benchmark.dart
import '../lib/arithmetic_kit.dart';
import 'dart:io';

void main() {
  print('=== ArithmeticKit Performance Benchmark ===\n');

  // Warm up
  print('Warming up...');
  for (int i = 0; i < 1000; i++) {
    BasicCalculator.calculate('2+3*4');
  }
  print('Warm up complete.\n');

  // Run benchmarks
  benchmarkBasicCalculator();
  benchmarkScientificCalculator();
  benchmarkExpressionCalculator();
  benchmarkExpressionParsing();
  benchmarkExpressionSimplification();
  benchmarkComplexExpressions();

  print('\n=== Benchmark Complete ===');
}

void benchmarkBasicCalculator() {
  print('--- BasicCalculator Benchmark ---');

  final expressions = ['2+3', '10-6/2', '2+3×4', '100÷4-5', '10%3'];

  for (final expr in expressions) {
    final stopwatch = Stopwatch()..start();
    const iterations = 100000;

    for (int i = 0; i < iterations; i++) {
      BasicCalculator.calculate(expr);
    }

    stopwatch.stop();
    final avgTime = stopwatch.elapsedMicroseconds / iterations;
    print('  $expr: ${avgTime.toStringAsFixed(2)} μs/op ($iterations ops)');
  }
  print('');
}

void benchmarkScientificCalculator() {
  print('--- ScientificCalculator Benchmark ---');

  final expressions = [
    'sin(0)',
    'cos(π)',
    'tan(π/4)',
    'log(100)',
    'ln(e)',
    'sqrt(16)',
    '2^8',
  ];

  for (final expr in expressions) {
    final stopwatch = Stopwatch()..start();
    const iterations = 50000;

    for (int i = 0; i < iterations; i++) {
      ScientificCalculator.calculate(expr);
    }

    stopwatch.stop();
    final avgTime = stopwatch.elapsedMicroseconds / iterations;
    print('  $expr: ${avgTime.toStringAsFixed(2)} μs/op ($iterations ops)');
  }
  print('');
}

void benchmarkExpressionCalculator() {
  print('--- ExpressionCalculator Benchmark ---');

  final calc = ExpressionCalculator();
  final expressions = [
    '2+3*4',
    '(2+3)*4',
    '2^3 + sqrt(16)',
    'sin(0) + cos(0)',
    'log(100) * ln(e)',
  ];

  for (final expr in expressions) {
    final stopwatch = Stopwatch()..start();
    const iterations = 50000;

    for (int i = 0; i < iterations; i++) {
      calc.calculate(expr);
    }

    stopwatch.stop();
    final avgTime = stopwatch.elapsedMicroseconds / iterations;
    print('  $expr: ${avgTime.toStringAsFixed(2)} μs/op ($iterations ops)');
  }
  print('');
}

void benchmarkExpressionParsing() {
  print('--- Expression Parsing Benchmark ---');

  final calc = ExpressionCalculator();
  final expressions = [
    '2+3',
    '2+3*4',
    '(2+3)*4',
    'sin(x) + cos(y)',
    'sqrt((x2-x1)^2 + (y2-y1)^2)',
  ];

  for (final expr in expressions) {
    final stopwatch = Stopwatch()..start();
    const iterations = 10000;

    for (int i = 0; i < iterations; i++) {
      calc.parse(expr);
    }

    stopwatch.stop();
    final avgTime = stopwatch.elapsedMicroseconds / iterations;
    print('  $expr: ${avgTime.toStringAsFixed(2)} μs/op ($iterations ops)');
  }
  print('');
}

void benchmarkExpressionSimplification() {
  print('--- Expression Simplification Benchmark ---');

  final calc = ExpressionCalculator();
  final expressions = ['x+0', 'x*1', 'x*0', '2+3', '(x+0)*1'];

  for (final expr in expressions) {
    final stopwatch = Stopwatch()..start();
    const iterations = 10000;

    for (int i = 0; i < iterations; i++) {
      calc.simplify(expr);
    }

    stopwatch.stop();
    final avgTime = stopwatch.elapsedMicroseconds / iterations;
    print('  $expr: ${avgTime.toStringAsFixed(2)} μs/op ($iterations ops)');
  }
  print('');
}

void benchmarkComplexExpressions() {
  print('--- Complex Expressions Benchmark ---');

  final calc = ExpressionCalculator();

  // Parse once, evaluate many times
  print('  Parse once, evaluate many times:');
  final expr = calc.parse('x^2 + y^2');
  final stopwatch = Stopwatch()..start();
  const iterations = 100000;

  for (int i = 0; i < iterations; i++) {
    expr.evaluate({'x': 3.0, 'y': 4.0});
  }

  stopwatch.stop();
  final avgTime = stopwatch.elapsedMicroseconds / iterations;
  print('    x^2 + y^2: ${avgTime.toStringAsFixed(2)} μs/op ($iterations ops)');

  // Parse and evaluate each time
  print('  Parse and evaluate each time:');
  final stopwatch2 = Stopwatch()..start();
  const iterations2 = 10000;

  for (int i = 0; i < iterations2; i++) {
    calc.evaluate('x^2 + y^2', {'x': 3.0, 'y': 4.0});
  }

  stopwatch2.stop();
  final avgTime2 = stopwatch2.elapsedMicroseconds / iterations2;
  print(
    '    x^2 + y^2: ${avgTime2.toStringAsFixed(2)} μs/op ($iterations2 ops)',
  );

  final speedup = avgTime2 / avgTime;
  print('    Speedup: ${speedup.toStringAsFixed(1)}x faster when parsing once');
  print('');
}
