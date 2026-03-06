# ArithmeticKit 代码风格指南

本文档定义了 ArithmeticKit 项目的代码风格规范。

## 基本原则

1. **一致性**: 保持代码风格一致
2. **可读性**: 代码应该易于理解
3. **简洁性**: 避免不必要的复杂性
4. **可维护性**: 便于后续维护和扩展

## 命名规范

### 文件命名

- 使用 `snake_case`（小写下划线）
- 文件名应该描述其内容

```dart
// 好的示例
basic_calculator.dart
expression_calculator.dart
lexer.dart

// 不好的示例
BasicCalculator.dart
expressionCalculator.dart
Lexer.dart
```

### 类命名

- 使用 `PascalCase`（大驼峰）
- 类名应该是名词或名词短语

```dart
// 好的示例
class BasicCalculator {}
class ExpressionCalculator {}
class NumberExpression {}

// 不好的示例
class basicCalculator {}
class expression_calculator {}
class Calculate {}
```

### 变量和方法命名

- 使用 `camelCase`（小驼峰）
- 变量名应该是名词
- 方法名应该是动词或动词短语
- 布尔变量使用 `is`、`has`、`can` 等前缀

```dart
// 好的示例
final calculator = BasicCalculator();
final isValid = true;
final hasError = false;

double evaluate(Map<String, double> variables) {}
bool validate(String input) {}

// 不好的示例
final Calculator = BasicCalculator();
final valid = true;

double evaluation(Map<String, double> variables) {}
bool check(String input) {}
```

### 常量命名

- 使用 `lowerCamelCase`
- 编译时常量使用 `const`

```dart
// 好的示例
const pi = 3.14159265358979;
const e = 2.71828182845904;
const maxIterations = 1000;

// 不好的示例
const PI = 3.14159265358979;
const MAX_ITERATIONS = 1000;
```

### 枚举命名

- 枚举类型使用 `PascalCase`
- 枚举值使用 `camelCase`

```dart
// 好的示例
enum TokenType {
  number,
  operator,
  function,
}

// 不好的示例
enum token_type {
  NUMBER,
  OPERATOR,
  FUNCTION,
}
```

## 代码格式

### 缩进

- 使用 2 个空格缩进
- 不使用 Tab

### 行长度

- 每行最多 80 个字符
- 超过时适当换行

```dart
// 好的示例
final result = calculator.evaluate(
  '2*x + sin(y)',
  {'x': 3.0, 'y': 0.0},
);

// 不好的示例
final result = calculator.evaluate('2*x + sin(y)', {'x': 3.0, 'y': 0.0});
```

### 尾随逗号

- 多行参数列表使用尾随逗号
- 有助于格式化和 diff

```dart
// 好的示例
final expr = AddExpression(
  NumberExpression(2.0),
  NumberExpression(3.0),
);

// 不好的示例
final expr = AddExpression(
  NumberExpression(2.0),
  NumberExpression(3.0)
);
```

### 空行

- 类成员之间使用一个空行
- 逻辑块之间使用一个空行
- 不要有多个连续空行

```dart
class ExpressionCalculator {
  final Lexer lexer;

  ExpressionCalculator(this.lexer);

  Expression parse(String input) {
    // 实现
  }

  double evaluate(String input) {
    // 实现
  }
}
```

## 类型注解

### 公共 API

- 必须显式声明返回类型
- 必须显式声明参数类型

```dart
// 好的示例
double evaluate(
  String input,
  Map<String, double>? variables,
) {
  // 实现
}

// 不好的示例
evaluate(input, variables) {
  // 实现
}
```

### 局部变量

- 可以省略类型（使用类型推断）
- 复杂类型建议显式声明

```dart
// 好的示例
final calculator = ExpressionCalculator();
final result = calculator.evaluate('2+3');

// 也可以
final ExpressionCalculator calculator = ExpressionCalculator();
final double result = calculator.evaluate('2+3');
```

## 文档注释

### 公共 API

- 所有公共类、方法、属性必须有文档注释
- 使用 `///` 三斜线注释
- 第一行是简短描述（一句话）
- 详细说明另起段落
- 包含使用示例

```dart
/// 表达式计算器。
///
/// 提供高级表达式解析和评估功能，支持变量、函数和表达式简化。
///
/// ## 使用示例
///
/// ```dart
/// final calc = ExpressionCalculator();
/// final result = calc.evaluate('2*x+3', {'x': 5.0});
/// print(result); // 13.0
/// ```
class ExpressionCalculator {
  /// 计算表达式的值。
  ///
  /// 参数:
  /// - [input]: 表达式字符串
  /// - [variables]: 变量值映射（可选）
  ///
  /// 返回计算结果，如果出错返回 NaN。
  ///
  /// 抛出 [FormatException] 如果表达式格式错误。
  double evaluate(
    String input, [
    Map<String, double>? variables,
  ]) {
    // 实现
  }
}
```

### 私有成员

- 复杂逻辑使用行内注释
- 使用 `//` 双斜线注释

```dart
double _calculateResult(Expression expr) {
  // 先简化表达式
  final simplified = expr.simplify();
  
  // 然后评估
  return simplified.evaluate();
}
```

## 最佳实践

### 使用 const

- 尽可能使用 `const` 构造函数
- 编译时常量使用 `const`

```dart
// 好的示例
const expr = NumberExpression(3.14);
const pi = 3.14159265358979;

// 不好的示例
final expr = NumberExpression(3.14);
var pi = 3.14159265358979;
```

### 使用 final

- 不可变变量使用 `final`
- 优先使用 `final` 而不是 `var`

```dart
// 好的示例
final calculator = ExpressionCalculator();
final result = calculator.evaluate('2+3');

// 不好的示例
var calculator = ExpressionCalculator();
var result = calculator.evaluate('2+3');
```

### 避免 null

- 使用非空类型
- 必要时使用 `?` 标记可空类型
- 使用 `required` 标记必需参数

```dart
// 好的示例
class VariableExpression extends Expression {
  final String name;
  
  const VariableExpression(this.name);
  
  @override
  double evaluate([Map<String, double>? variables]) {
    return variables?[name] ?? double.nan;
  }
}

// 不好的示例
class VariableExpression extends Expression {
  String? name;
  
  VariableExpression(this.name);
  
  double evaluate(Map<String, double>? variables) {
    return variables![name]!;
  }
}
```

### 使用命名参数

- 多个参数时使用命名参数
- 提高可读性

```dart
// 好的示例
calculator.evaluate(
  input: '2*x+3',
  variables: {'x': 5.0},
);

// 不好的示例
calculator.evaluate('2*x+3', {'x': 5.0});
```

### 错误处理

- 使用异常处理错误情况
- 提供有意义的错误信息
- 文档中说明可能抛出的异常

```dart
/// 解析表达式字符串。
///
/// 抛出 [FormatException] 如果表达式格式错误。
Expression parse(String input) {
  if (input.isEmpty) {
    throw FormatException('表达式不能为空');
  }
  
  // ...
}
```

### 不可变对象

- 表达式对象应该是不可变的
- 使用 `const` 构造函数

```dart
// 好的做法
class NumberExpression extends Expression {
  final double value;
  
  const NumberExpression(this.value);
  
  @override
  double evaluate([Map<String, double>? variables]) => value;
}

// 不好的做法
class NumberExpression extends Expression {
  double value;
  
  NumberExpression(this.value);
  
  void setValue(double newValue) {
    value = newValue;
  }
}
```

## 测试风格

### 测试命名

- 使用描述性的测试名称
- 说明测试的内容和期望

```dart
test('加法表达式应该正确计算两个数字的和', () {
  final expr = AddExpression(
    NumberExpression(2.0),
    NumberExpression(3.0),
  );
  
  expect(expr.evaluate(), 5.0);
});
```

### 测试组织

- 使用 `group` 组织相关测试
- 使用 `setUp` 和 `tearDown` 管理测试状态

```dart
group('ExpressionCalculator', () {
  late ExpressionCalculator calculator;

  setUp(() {
    calculator = ExpressionCalculator();
  });

  group('基础运算', () {
    test('加法', () {
      expect(calculator.evaluate('2+3'), 5.0);
    });

    test('减法', () {
      expect(calculator.evaluate('5-2'), 3.0);
    });
  });

  group('变量', () {
    test('单个变量', () {
      expect(calculator.evaluate('2*x', {'x': 3.0}), 6.0);
    });

    test('多个变量', () {
      expect(
        calculator.evaluate('x+y', {'x': 2.0, 'y': 3.0}),
        5.0,
      );
    });
  });
});
```

### 测试覆盖

- 测试正常情况
- 测试边界情况
- 测试错误情况

```dart
group('DivideExpression', () {
  test('正常除法', () {
    final expr = DivideExpression(
      NumberExpression(6.0),
      NumberExpression(2.0),
    );
    expect(expr.evaluate(), 3.0);
  });

  test('除以零返回 NaN', () {
    final expr = DivideExpression(
      NumberExpression(6.0),
      NumberExpression(0.0),
    );
    expect(expr.evaluate().isNaN, true);
  });

  test('零除以任何数返回零', () {
    final expr = DivideExpression(
      NumberExpression(0.0),
      NumberExpression(5.0),
    );
    expect(expr.evaluate(), 0.0);
  });
});
```

## 表达式类规范

### 基类实现

```dart
/// 表达式基类。
///
/// 所有表达式类都应该继承此类并实现 [evaluate] 和 [simplify] 方法。
abstract class Expression {
  const Expression();

  /// 计算表达式的值。
  ///
  /// 参数:
  /// - [variables]: 变量值映射（可选）
  ///
  /// 返回计算结果。
  double evaluate([Map<String, double>? variables]);

  /// 简化表达式。
  ///
  /// 返回简化后的表达式。
  Expression simplify();

  /// 字符串表示。
  @override
  String toString();
}
```

### 二元运算实现

```dart
/// 二元运算表达式基类。
abstract class BinaryExpression extends Expression {
  const BinaryExpression(this.left, this.right);

  final Expression left;
  final Expression right;

  @override
  Expression simplify() {
    final simplifiedLeft = left.simplify();
    final simplifiedRight = right.simplify();

    // 常量折叠
    if (simplifiedLeft is NumberExpression &&
        simplifiedRight is NumberExpression) {
      return NumberExpression(
        _operate(simplifiedLeft.value, simplifiedRight.value),
      );
    }

    return _create(simplifiedLeft, simplifiedRight);
  }

  /// 执行运算
  double _operate(double left, double right);

  /// 创建新表达式
  Expression _create(Expression left, Expression right);
}
```

### 一元运算实现

```dart
/// 一元运算表达式基类。
abstract class UnaryExpression extends Expression {
  const UnaryExpression(this.operand);

  final Expression operand;

  @override
  Expression simplify() {
    final simplifiedOperand = operand.simplify();

    // 常量折叠
    if (simplifiedOperand is NumberExpression) {
      return NumberExpression(_operate(simplifiedOperand.value));
    }

    return _create(simplifiedOperand);
  }

  /// 执行运算
  double _operate(double value);

  /// 创建新表达式
  Expression _create(Expression operand);
}
```

## 工具

### 格式化

```bash
# 格式化所有文件
dart format .

# 检查格式（不修改）
dart format --output=none --set-exit-if-changed .
```

### 分析

```bash
# 运行代码分析
flutter analyze

# 修复可自动修复的问题
dart fix --apply
```

### 测试

```bash
# 运行所有测试
flutter test

# 运行特定测试
flutter test test/calculators/expression_calculator_test.dart

# 生成覆盖率报告
flutter test --coverage
```

---

遵循这些规范将帮助保持代码库的一致性和可维护性。

**文档版本**: 1.0  
**创建日期**: 2026-03-06  
**作者**: ZenKitX Team

