# ArithmeticKit API 参考文档

本文档提供 ArithmeticKit 的完整 API 参考。

## 目录

- [基础计算器](#基础计算器)
- [科学计算器](#科学计算器)
- [表达式计算器](#表达式计算器)
- [表达式类](#表达式类)
- [词法分析器](#词法分析器)
- [语法分析器](#语法分析器)

---

## 基础计算器

### BasicCalculator

基础算术计算器，支持加减乘除和取模运算。

#### 静态方法

##### calculate

```dart
static String calculate(String expression)
```

计算基础算术表达式。

**参数:**
- `expression`: 算术表达式字符串

**返回:** 计算结果字符串，如果出错返回 `'Error'`

**支持的运算符:**
- `+` - 加法
- `-` - 减法
- `×` 或 `*` - 乘法
- `÷` 或 `/` - 除法
- `%` - 取模

**示例:**
```dart
final result1 = BasicCalculator.calculate('2+3×4');
print(result1); // '14'

final result2 = BasicCalculator.calculate('100÷4-5');
print(result2); // '20'

final result3 = BasicCalculator.calculate('10%3');
print(result3); // '1'
```

##### isValidInput

```dart
static bool isValidInput(String current, String newChar)
```

验证输入是否有效。

**参数:**
- `current`: 当前输入字符串
- `newChar`: 要添加的新字符

**返回:** 是否可以添加该字符

**示例:**
```dart
final isValid = BasicCalculator.isValidInput('3.14', '.');
print(isValid); // false (已经有小数点)

final isValid2 = BasicCalculator.isValidInput('5', '+');
print(isValid2); // true
```

---

## 科学计算器

### ScientificCalculator

科学计算器，支持三角函数、对数、幂运算等。

#### 静态方法

##### calculate

```dart
static String calculate(String expression)
```

计算科学表达式。

**参数:**
- `expression`: 科学表达式字符串

**返回:** 计算结果字符串，如果出错返回 `'Error'`

**支持的函数:**

**三角函数:**
- `sin(x)` - 正弦（弧度）
- `cos(x)` - 余弦（弧度）
- `tan(x)` - 正切（弧度）
- `asin(x)` 或 `arcsin(x)` - 反正弦
- `acos(x)` 或 `arccos(x)` - 反余弦
- `atan(x)` 或 `arctan(x)` - 反正切

**对数函数:**
- `log(x)` - 常用对数（以 10 为底）
- `ln(x)` - 自然对数（以 e 为底）

**幂和根:**
- `x^y` - 幂运算（x 的 y 次方）
- `sqrt(x)` - 平方根
- `exp(x)` - 指数函数（e^x）

**其他函数:**
- `abs(x)` - 绝对值
- `ceil(x)` - 向上取整
- `floor(x)` - 向下取整

**常量:**
- `π` 或 `pi` - 圆周率（3.14159265358979...）
- `e` - 自然常数（2.71828182845904...）

**示例:**
```dart
// 三角函数
final sinResult = ScientificCalculator.calculate('sin(π/2)');
print(sinResult); // '1'

final cosResult = ScientificCalculator.calculate('cos(0)');
print(cosResult); // '1'

// 对数函数
final logResult = ScientificCalculator.calculate('log(100)');
print(logResult); // '2'

final lnResult = ScientificCalculator.calculate('ln(e)');
print(lnResult); // '1'

// 幂和根
final powerResult = ScientificCalculator.calculate('2^8');
print(powerResult); // '256'

final sqrtResult = ScientificCalculator.calculate('sqrt(16)');
print(sqrtResult); // '4'
```

---

## 表达式计算器

### ExpressionCalculator

高级表达式计算器，支持变量、表达式树和简化。

#### 构造函数

```dart
ExpressionCalculator()
```

创建表达式计算器实例。

#### 方法

##### parse

```dart
Expression parse(String input)
```

将字符串解析为表达式树。

**参数:**
- `input`: 表达式字符串

**返回:** 表达式树对象

**抛出:** `FormatException` 如果表达式格式错误

**示例:**
```dart
final calc = ExpressionCalculator();
final expr = calc.parse('2*x + sin(y)');
print(expr); // '((2 * x) + sin(y))'
```

##### evaluate

```dart
double evaluate(String input, [Map<String, double>? variables])
```

计算表达式的值。

**参数:**
- `input`: 表达式字符串
- `variables`: 变量值映射（可选）

**返回:** 计算结果

**抛出:** `FormatException` 如果表达式格式错误

**示例:**
```dart
final calc = ExpressionCalculator();

// 简单表达式
final result1 = calc.evaluate('2+3*4');
print(result1); // 14.0

// 带变量的表达式
final result2 = calc.evaluate('2*x+3', {'x': 5.0});
print(result2); // 13.0

// 多变量表达式
final result3 = calc.evaluate('x^2+y^2', {'x': 3.0, 'y': 4.0});
print(result3); // 25.0
```

##### simplify

```dart
Expression simplify(String input)
```

简化表达式。

**参数:**
- `input`: 表达式字符串

**返回:** 简化后的表达式树

**简化规则:**
- 常量折叠：`2+3` → `5`
- 加法单位元：`x+0` → `x`
- 乘法单位元：`x*1` → `x`
- 乘法零元：`x*0` → `0`

**示例:**
```dart
final calc = ExpressionCalculator();

print(calc.simplify('x+0'));  // 'x'
print(calc.simplify('x*1'));  // 'x'
print(calc.simplify('x*0'));  // '0'
print(calc.simplify('2+3'));  // '5'
```

##### calculate

```dart
String calculate(String input, [Map<String, double>? variables])
```

计算表达式并格式化结果。

**参数:**
- `input`: 表达式字符串
- `variables`: 变量值映射（可选）

**返回:** 格式化的结果字符串，如果出错返回 `'Error'`

**示例:**
```dart
final calc = ExpressionCalculator();

print(calc.calculate('2+3*4'));        // '14'
print(calc.calculate('(2+3)*4'));      // '20'
print(calc.calculate('2^3 + sqrt(16)')); // '12'

// 带变量
print(calc.calculate('2*x+3', {'x': 5.0}));  // '13'
```

---

## 表达式类

### Expression

所有表达式的基类。

#### 方法

##### evaluate

```dart
double evaluate([Map<String, double>? variables])
```

计算表达式的值。

**参数:**
- `variables`: 变量值映射（可选）

**返回:** 计算结果

##### simplify

```dart
Expression simplify()
```

简化表达式。

**返回:** 简化后的表达式

##### toString

```dart
String toString()
```

返回表达式的字符串表示。

### NumberExpression

数字字面量表达式。

#### 构造函数

```dart
NumberExpression(double value)
```

**参数:**
- `value`: 数字值

**示例:**
```dart
final expr = NumberExpression(3.14);
print(expr.evaluate()); // 3.14
```

### VariableExpression

变量表达式。

#### 构造函数

```dart
VariableExpression(String name)
```

**参数:**
- `name`: 变量名

**示例:**
```dart
final expr = VariableExpression('x');
print(expr.evaluate({'x': 5.0})); // 5.0
```

### BinaryExpression

二元运算表达式（抽象基类）。

#### 子类

##### AddExpression

加法表达式。

```dart
AddExpression(Expression left, Expression right)
```

**示例:**
```dart
final expr = AddExpression(
  NumberExpression(2.0),
  NumberExpression(3.0),
);
print(expr.evaluate()); // 5.0
```

##### SubtractExpression

减法表达式。

```dart
SubtractExpression(Expression left, Expression right)
```

##### MultiplyExpression

乘法表达式。

```dart
MultiplyExpression(Expression left, Expression right)
```

##### DivideExpression

除法表达式。

```dart
DivideExpression(Expression left, Expression right)
```

##### ModuloExpression

取模表达式。

```dart
ModuloExpression(Expression left, Expression right)
```

##### PowerExpression

幂运算表达式。

```dart
PowerExpression(Expression left, Expression right)
```

### UnaryExpression

一元运算表达式（抽象基类）。

#### 子类

##### NegateExpression

取负表达式。

```dart
NegateExpression(Expression operand)
```

##### SinExpression

正弦函数表达式。

```dart
SinExpression(Expression operand)
```

##### CosExpression

余弦函数表达式。

```dart
CosExpression(Expression operand)
```

##### TanExpression

正切函数表达式。

```dart
TanExpression(Expression operand)
```

##### AsinExpression

反正弦函数表达式。

```dart
AsinExpression(Expression operand)
```

##### AcosExpression

反余弦函数表达式。

```dart
AcosExpression(Expression operand)
```

##### AtanExpression

反正切函数表达式。

```dart
AtanExpression(Expression operand)
```

##### LnExpression

自然对数函数表达式。

```dart
LnExpression(Expression operand)
```

##### LogExpression

常用对数函数表达式。

```dart
LogExpression(Expression operand)
```

##### SqrtExpression

平方根函数表达式。

```dart
SqrtExpression(Expression operand)
```

##### AbsExpression

绝对值函数表达式。

```dart
AbsExpression(Expression operand)
```

##### CeilExpression

向上取整函数表达式。

```dart
CeilExpression(Expression operand)
```

##### FloorExpression

向下取整函数表达式。

```dart
FloorExpression(Expression operand)
```

##### ExpExpression

指数函数表达式。

```dart
ExpExpression(Expression operand)
```

---

## 词法分析器

### Lexer

词法分析器，将字符串转换为 Token 流。

#### 构造函数

```dart
Lexer(String input)
```

**参数:**
- `input`: 输入字符串

#### 方法

##### tokenize

```dart
List<Token> tokenize()
```

将输入字符串转换为 Token 列表。

**返回:** Token 列表

**抛出:** `FormatException` 如果输入格式错误

**示例:**
```dart
final lexer = Lexer('2+3*4');
final tokens = lexer.tokenize();
// [Number(2), Plus, Number(3), Multiply, Number(4)]
```

---

## 语法分析器

### Parser

语法分析器，使用 Shunting Yard 算法将中缀表达式转换为表达式树。

#### 构造函数

```dart
Parser(List<Token> tokens)
```

**参数:**
- `tokens`: Token 列表

#### 方法

##### parse

```dart
Expression parse()
```

解析 Token 列表为表达式树。

**返回:** 表达式树

**抛出:** `FormatException` 如果语法错误

**示例:**
```dart
final lexer = Lexer('2+3*4');
final tokens = lexer.tokenize();
final parser = Parser(tokens);
final expr = parser.parse();
print(expr.evaluate()); // 14.0
```

---

## Token 类型

### Token

Token 基类。

#### 子类

- `NumberToken(double value)` - 数字
- `VariableToken(String name)` - 变量
- `OperatorToken(String operator)` - 运算符
- `FunctionToken(String name)` - 函数
- `LeftParenToken()` - 左括号
- `RightParenToken()` - 右括号
- `CommaToken()` - 逗号

---

## 错误处理

所有计算方法在遇到错误时返回 `'Error'` 字符串：

```dart
BasicCalculator.calculate('5÷0');           // 'Error' (除以零)
ScientificCalculator.calculate('sqrt(-1)'); // 'Error' (无效输入)
ExpressionCalculator().calculate('1/0');    // 'Error' (除以零)
ExpressionCalculator().calculate('ln(0)');  // 'Error' (未定义)
```

解析方法在遇到格式错误时抛出 `FormatException`：

```dart
try {
  final calc = ExpressionCalculator();
  calc.parse('2++3'); // 抛出 FormatException
} catch (e) {
  print('解析错误: $e');
}
```

---

## 性能考虑

- 基础计算：< 1 毫秒
- 科学计算：< 2 毫秒
- 表达式解析：< 5 毫秒
- 表达式计算：< 1 毫秒（已解析）
- 表达式简化：< 10 毫秒

---

## 版本历史

- **v0.3.0** (2026-03-06)
  - 自定义表达式系统
  - 表达式树评估
  - 表达式简化
  - 零外部依赖
  
- **v0.2.0** (2024-03-05)
  - 添加 ExpressionCalculator
  - 使用 math_expressions 包
  
- **v0.1.0** (2024-03-03)
  - 初始版本
  - BasicCalculator 和 ScientificCalculator

---

**文档版本**: 1.0  
**更新日期**: 2026-03-06  
**作者**: ZenKitX Team

