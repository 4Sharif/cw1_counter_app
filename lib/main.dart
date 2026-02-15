import 'package:flutter/material.dart';

void main() {
  runApp(const CW1App());
}

class CW1App extends StatelessWidget {
  const CW1App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CounterPage(),
    );
  }
}

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _counter = 0;
  int _step = 1;

  void _setStep(int step) {
    setState(() {
      _step = step;
    });
  }

  void _increment() {
    setState(() {
      _counter += _step;
    });
  }

  void _decrement() {
    setState(() {
      _counter = (_counter - _step);
      if (_counter < 0) _counter = 0;
    });
  }

  void _reset() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool canDecrement = _counter > 0;
    final bool canReset = _counter > 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text("CW #01 - Counter"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Counter Value", style: TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
              Text(
                "$_counter",
                style: const TextStyle(fontSize: 42, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 18),

              Text("Step: $_step", style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                children: [
                  OutlinedButton(
                    onPressed: () => _setStep(1),
                    child: const Text("+1"),
                  ),
                  OutlinedButton(
                    onPressed: () => _setStep(5),
                    child: const Text("+5"),
                  ),
                  OutlinedButton(
                    onPressed: () => _setStep(10),
                    child: const Text("+10"),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _increment,
                    child: const Text("Increment"),
                  ),
                  ElevatedButton(
                    onPressed: canDecrement ? _decrement : null,
                    child: const Text("Decrement"),
                  ),
                  ElevatedButton(
                    onPressed: canReset ? _reset : null,
                    child: const Text("Reset"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}