# ArithmeticKit 架构设计

本文档描述 ArithmeticKit 项目的架构设计原则和实现方案。

## 目录

1. [设计原则](#设计原则)
2. [目录结构](#目录结构)
3. [模块划分](#模块划分)
4. [表达式系统](#表达式系统)
5. [解析流程](#解析流程)
6. [扩展指南](#扩展指南)

## 设计原则

### 1. 零依赖原则 (Zero Dependencies)

ArithmeticKit 不依赖任何外部包，完全使用 Dart 标准库实现。

**优势:**
- 无版本冲突
- 更小的包体积
- 更快的编译速度
- 完全可控的实现

### 2. 单一职责原则 (Single Responsibility Principle)

每个类只负责一个明确的功能。

**示例:**
- `Lexer` 只负责词法分析
- `Parser` 只负责语法分析
- `Expression` 只负责表达式评估

### 3. 开闭原则 (Open-Closed Principle)

对扩展开放，对修改关闭。

**实现:**
- 添加新函数不需要修改现有代码
- 通过继承 `UnaryExpression` 添加新函数
- 通过继承 `BinaryExpression` 添加新运算符

### 4. 组合优于继承 (Composition Over Inheritance)

使用组合构建复杂表达式。

**实现:**
- 表达式树使用组合模式
- 复杂表达式由简单表达式组合而成

### 5. 不可变性 (Immutability)

表达式对象一旦创建就不可修改。

**优势:**
- 线程安全
- 易于缓存
- 易于推理

## 目录结构

```
lib/
├── arithmetic_kit.dart              # 主导出文件
└── src/                             # 源代码目录
    ├── calculators/                 # 计算器
    │   ├── basic_calculator.dart    # 基础计算器
    │   ├── scientific_calculator.dart # 科学计算器
    │   └── expression_calculator.dart # 表达式计算器
    └── core/                        # 核心模块
        ├── expression.dart          # 表达式类
        ├── lexer.dart               # 词法分析器
        ├── parser.dart              # 语法分析器
        └── token.dart               # Token 类

test/                                # 测试目录
├── calculators/                     # 计算器测试
│   ├── basic_calculator_test.dart
│   ├── scientific_calculator_test.dart
│   └── expression_calculator_test.dart
├── core/                            # 核心模块测试
│   ├── expression_test.dart
│   ├── lexer_test.dart
│   └── parser_test.dart
└── integration_test.dart            # 集成测试
```

## 模块划分

### Calculators（计算器）

提供高层次的计算接口。

#### BasicCalculator

**职责:**
- 解析基础算术表达式
- 执行加减乘除和取模运算
- 验证输入有效性

**特点:**
- 静态方法，无需实例化
- 简单直接的 API
- 适合基础计算场景

#### ScientificCalculator

**职责:**
- 解析科学表达式
- 支持三角函数、对数、幂运算等
- 处理数学常量（π, e）

**特点:**
- 扩展 BasicCalculator 的功能
- 支持更多数学函数
- 适合科学计算场景

#### ExpressionCalculator

**职责:**
- 解析复杂表达式
- 支持变量绑定
- 表达式简化
- 表达式树操作

**特点:**
- 最强大的计算器
- 支持变量和函数
- 可以操作表达式树
- 适合高级计算场景

### Core（核心模块）

实现底层的解析和评估逻辑。

#### Token

**职责:**
- 定义 Token 类型
- 表示词法单元

**类型:**
- `NumberToken` - 数字
- `VariableToken` - 变量
- `OperatorToken` - 运算符
- `FunctionToken` - 函数
- `LeftParenToken` - 左括号
- `RightParenToken` - 右括号
- `CommaToken` - 逗号

#### Lexer

**职责:**
- 词法分析
- 将字符串转换为 Token 流

**特点:**
- 单遍扫描
- 支持多字符 Token
- 错误检测

#### Parser

**职责:**
- 语法分析
- 将 Token 流转换为表达式树

**算法:**
- Shunting Yard 算法
- 中缀转后缀
- 后缀构建表达式树

#### Expression

**职责:**
- 表达式评估
- 表达式简化
- 表达式表示

**类型:**
- `NumberExpression` - 数字字面量
- `VariableExpression` - 变量
- `BinaryExpression` - 二元运算
- `UnaryExpression` - 一元运算

## 表达式系统

### 表达式树结构

```
Expression (抽象基类)
├── NumberExpression (数字字面量)
├── VariableExpression (变量)
├── BinaryExpression (二元运算，抽象基类)
│   ├── AddExpression (+)
│   ├── SubtractExpression (-)
│   ├── MultiplyExpression (*)
│   ├── DivideExpression (/)
│   ├── ModuloExpression (%)
│   └── PowerExpression (^)
└── UnaryExpression (一元运算，抽象基类)
    ├── NegateExpression (-)
    ├── SinExpression (sin)
    ├── CosExpression (cos)
    ├── TanExpression (tan)
    ├── AsinExpression (asin)
    ├── AcosExpression (acos)
    ├── AtanExpression (atan)
    ├── LnExpression (ln)
    ├── LogExpression (log)
    ├── SqrtExpression (sqrt)
    ├── AbsExpression (abs)
    ├── CeilExpression (ceil)
    ├── FloorExpression (floor)
    └── ExpExpression (exp)
```

### 表达式接口

所有表达式类都实现以下接口：

```dart
abstract class Expression {
  /// 计算表达式的值
  double evaluate([Map<String, double>? variables]);
  
  /// 简化表达式
  Expression simplify();
  
  /// 字符串表示
  String toString();
}
```

### 表达式示例

#### 简单表达式

```dart
// 2 + 3
final expr = AddExpression(
  NumberExpression(2.0),
  NumberExpression(3.0),
);
print(expr.evaluate()); // 5.0
```

#### 复杂表达式

```dart
// 2*x + sin(y)
final expr = AddExpression(
  MultiplyExpression(
    NumberExpression(2.0),
    VariableExpression('x'),
  ),
  SinExpression(
    VariableExpression('y'),
  ),
);
print(expr.evaluate({'x': 3.0, 'y': 0.0})); // 6.0
```

### 表达式简化

表达式简化使用以下规则：

#### 常量折叠

```dart
// 2 + 3 → 5
AddExpression(
  NumberExpression(2.0),
  NumberExpression(3.0),
).simplify() // NumberExpression(5.0)
```

#### 加法单位元

```dart
// x + 0 → x
AddExpression(
  VariableExpression('x'),
  NumberExpression(0.0),
).simplify() // VariableExpression('x')
```

#### 乘法单位元

```dart
// x * 1 → x
MultiplyExpression(
  VariableExpression('x'),
  NumberExpression(1.0),
).simplify() // VariableExpression('x')
```

#### 乘法零元

```dart
// x * 0 → 0
MultiplyExpression(
  VariableExpression('x'),
  NumberExpression(0.0),
).simplify() // NumberExpression(0.0)
```

## 解析流程

### 完整流程

```
输入字符串
    ↓
[Lexer] 词法分析
    ↓
Token 流
    ↓
[Parser] 语法分析
    ↓
表达式树
    ↓
[Expression] 评估
    ↓
结果
```

### 详细步骤

#### 1. 词法分析 (Lexer)

将字符串分解为 Token：

```
输入: "2*x + sin(y)"
输出: [
  NumberToken(2),
  OperatorToken('*'),
  VariableToken('x'),
  OperatorToken('+'),
  FunctionToken('sin'),
  LeftParenToken(),
  VariableToken('y'),
  RightParenToken(),
]
```

#### 2. 语法分析 (Parser)

使用 Shunting Yard 算法转换为后缀表达式：

```
中缀: 2 * x + sin(y)
后缀: 2 x * y sin +
```

然后从后缀表达式构建表达式树：

```
      +
     / \
    *   sin
   / \   |
  2   x  y
```

#### 3. 表达式评估 (Expression)

递归评估表达式树：

```dart
// 评估 2*x + sin(y)，其中 x=3, y=0
final result = expr.evaluate({'x': 3.0, 'y': 0.0});
// = (2 * 3) + sin(0)
// = 6 + 0
// = 6.0
```

### Shunting Yard 算法

Shunting Yard 算法用于将中缀表达式转换为后缀表达式（逆波兰表示法）。

#### 算法步骤

1. 创建输出队列和运算符栈
2. 从左到右扫描 Token：
   - 数字/变量：直接加入输出队列
   - 函数：压入运算符栈
   - 运算符：
     - 如果栈顶运算符优先级更高，弹出到输出队列
     - 将当前运算符压入栈
   - 左括号：压入运算符栈
   - 右括号：弹出运算符直到遇到左括号
3. 将栈中剩余运算符弹出到输出队列

#### 运算符优先级

| 优先级 | 运算符 |
|--------|--------|
| 4 | `^` (幂) |
| 3 | `*`, `/`, `%` |
| 2 | `+`, `-` |
| 1 | 函数 |

#### 示例

```
输入: 2 + 3 * 4

步骤:
1. 读取 2 → 输出: [2]
2. 读取 + → 栈: [+]
3. 读取 3 → 输出: [2, 3]
4. 读取 * → 栈: [+, *] (优先级高于+)
5. 读取 4 → 输出: [2, 3, 4]
6. 结束 → 弹出栈: [2, 3, 4, *, +]

后缀表达式: 2 3 4 * +
```

## 扩展指南

### 添加新函数

按照以下步骤添加新的数学函数：

#### 1. 创建表达式类

在 `lib/src/core/expression.dart` 中添加：

```dart
/// 双曲正弦函数表达式
class SinhExpression extends UnaryExpression {
  const SinhExpression(super.operand);

  @override
  double evaluate([Map<String, double>? variables]) {
    final value = operand.evaluate(variables);
    return (exp(value) - exp(-value)) / 2;
  }

  @override
  String toString() => 'sinh($operand)';
}
```

#### 2. 在 Lexer 中注册

在 `lib/src/core/lexer.dart` 的 `_readFunction()` 方法中添加：

```dart
case 'sinh':
  return FunctionToken('sinh');
```

#### 3. 在 Parser 中处理

在 `lib/src/core/parser.dart` 的 `_buildExpression()` 方法中添加：

```dart
case 'sinh':
  return SinhExpression(operand);
```

#### 4. 添加测试

在 `test/core/expression_test.dart` 中添加：

```dart
test('sinh 函数', () {
  final expr = SinhExpression(NumberExpression(0.0));
  expect(expr.evaluate(), 0.0);
});
```

#### 5. 更新文档

在 `README.md` 和 `doc/API.md` 中添加函数说明。

### 添加新运算符

按照以下步骤添加新的二元运算符：

#### 1. 创建表达式类

```dart
/// 整除运算表达式
class IntDivideExpression extends BinaryExpression {
  const IntDivideExpression(super.left, super.right);

  @override
  double evaluate([Map<String, double>? variables]) {
    final leftValue = left.evaluate(variables);
    final rightValue = right.evaluate(variables);
    if (rightValue == 0) {
      return double.nan;
    }
    return (leftValue ~/ rightValue).toDouble();
  }

  @override
  String toString() => '($left // $right)';
}
```

#### 2. 在 Lexer 中识别

在 `lib/src/core/lexer.dart` 中添加运算符识别逻辑。

#### 3. 在 Parser 中处理

在 `lib/src/core/parser.dart` 中添加运算符优先级和构建逻辑。

#### 4. 添加测试

#### 5. 更新文档

## 设计模式

### 组合模式 (Composite Pattern)

表达式树使用组合模式：

- `Expression` 是组件接口
- `NumberExpression` 和 `VariableExpression` 是叶子节点
- `BinaryExpression` 和 `UnaryExpression` 是组合节点

### 访问者模式 (Visitor Pattern)

简化操作使用访问者模式：

- `simplify()` 方法遍历表达式树
- 对每个节点应用简化规则

### 策略模式 (Strategy Pattern)

不同的计算器使用不同的解析策略：

- `BasicCalculator` 使用简单的字符串替换
- `ScientificCalculator` 使用正则表达式
- `ExpressionCalculator` 使用完整的解析器

## 性能优化

### 1. 常量折叠

在编译时计算常量表达式：

```dart
// 2 + 3 在解析时就计算为 5
final expr = parse('2 + 3').simplify();
// expr = NumberExpression(5.0)
```

### 2. 表达式缓存

缓存已解析的表达式：

```dart
final cache = <String, Expression>{};

Expression parseWithCache(String input) {
  return cache.putIfAbsent(input, () => parse(input));
}
```

### 3. 惰性评估

只在需要时才评估子表达式：

```dart
// 如果 x 为 0，不需要评估 y
// x * y
if (x == 0) return 0;
return x * y;
```

## 最佳实践

### 1. 使用不可变对象

```dart
// ✅ 好的做法
final expr = AddExpression(
  NumberExpression(2.0),
  NumberExpression(3.0),
);

// ❌ 不好的做法
var expr = AddExpression(
  NumberExpression(2.0),
  NumberExpression(3.0),
);
expr = MultiplyExpression(expr, NumberExpression(4.0));
```

### 2. 提供清晰的错误信息

```dart
// ✅ 好的做法
if (rightValue == 0) {
  throw ArgumentError('除数不能为零');
}

// ❌ 不好的做法
if (rightValue == 0) {
  throw Exception('错误');
}
```

### 3. 编写全面的测试

```dart
group('DivideExpression', () {
  test('正常除法', () {
    final expr = DivideExpression(
      NumberExpression(6.0),
      NumberExpression(2.0),
    );
    expect(expr.evaluate(), 3.0);
  });

  test('除以零', () {
    final expr = DivideExpression(
      NumberExpression(6.0),
      NumberExpression(0.0),
    );
    expect(expr.evaluate().isNaN, true);
  });
});
```

## 总结

ArithmeticKit 的架构设计遵循 SOLID 原则和常见设计模式，通过模块化、可扩展的设计，实现了：

1. **零依赖**：完全使用 Dart 标准库
2. **易扩展**：添加新功能不需要修改现有代码
3. **易测试**：模块独立，测试简单直接
4. **高性能**：优化的解析和评估算法
5. **易理解**：清晰的结构和完善的文档

这种设计为项目的长期发展和维护奠定了坚实的基础。

---

**文档版本**: 1.0  
**创建日期**: 2026-03-06  
**作者**: ZenKitX Team

