import 'package:flutter/material.dart';
import 'package:arithmetic_kit/arithmetic_kit.dart';

void main() {
  runApp(const ArithmeticKitExampleApp());
}

class ArithmeticKitExampleApp extends StatelessWidget {
  const ArithmeticKitExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ArithmeticKit Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const ExampleHomePage(),
    );
  }
}

class ExampleHomePage extends StatefulWidget {
  const ExampleHomePage({super.key});

  @override
  State<ExampleHomePage> createState() => _ExampleHomePageState();
}

class _ExampleHomePageState extends State<ExampleHomePage> {
  final TextEditingController _controller = TextEditingController();
  String _result = '';
  bool _isScientific = false;

  void _calculate() {
    setState(() {
      final expression = _controller.text;
      _result = _isScientific
          ? ScientificCalculator.calculate(expression)
          : BasicCalculator.calculate(expression);
    });
  }

  void _clear() {
    setState(() {
      _controller.clear();
      _result = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('ArithmeticKit Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Mode Toggle
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Basic'),
                Switch(
                  value: _isScientific,
                  onChanged: (value) {
                    setState(() {
                      _isScientific = value;
                    });
                  },
                ),
                const Text('Scientific'),
              ],
            ),
            const SizedBox(height: 20),

            // Input Field
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Expression',
                border: OutlineInputBorder(),
                hintText: 'Enter expression (e.g., 2+3×4)',
              ),
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),

            // Calculate Button
            ElevatedButton(
              onPressed: _calculate,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
              child: const Text('Calculate', style: TextStyle(fontSize: 18)),
            ),
            const SizedBox(height: 10),

            // Clear Button
            OutlinedButton(
              onPressed: _clear,
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
              child: const Text('Clear', style: TextStyle(fontSize: 18)),
            ),
            const SizedBox(height: 30),

            // Result Display
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Result:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _result.isEmpty ? '—' : _result,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: _result == 'Error' ? Colors.red : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Examples
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Examples:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (!_isScientific) ...[
                      _buildExample('Basic Operations', [
                        '2+3',
                        '10-5',
                        '3×4',
                        '15÷3',
                        '10%3',
                      ]),
                      _buildExample('Order of Operations', [
                        '2+3×4',
                        '10-6÷2',
                        '(2+3)×4',
                      ]),
                      _buildExample('Decimals', ['0.5+0.5', '1.5×2', '1÷3']),
                    ] else ...[
                      _buildExample('Trigonometric', [
                        'sin0',
                        'cos0',
                        'tan0',
                        'sin(π/2)',
                      ]),
                      _buildExample('Logarithmic', [
                        'log100',
                        'ln(e)',
                        'log10',
                      ]),
                      _buildExample('Power & Root', [
                        '2^8',
                        'sqrt16',
                        'e^2',
                        '10^3',
                      ]),
                      _buildExample('Constants', ['π', 'e', 'π×2']),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExample(String title, List<String> examples) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: examples.map((example) {
              return ActionChip(
                label: Text(example),
                onPressed: () {
                  _controller.text = example;
                  _calculate();
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
