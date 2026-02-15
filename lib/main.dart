import 'package:flutter/material.dart';

void main() {
  runApp(const CW1App());
}

class CW1App extends StatefulWidget {
  const CW1App({super.key});

  @override
  State<CW1App> createState() => _CW1AppState();
}

class _CW1AppState extends State<CW1App> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode = (_themeMode == ThemeMode.light) ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "CW #01",
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: _themeMode,
      home: HomePage(
        themeMode: _themeMode,
        onToggleTheme: _toggleTheme,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final ThemeMode themeMode;
  final VoidCallback onToggleTheme;

  const HomePage({
    super.key,
    required this.themeMode,
    required this.onToggleTheme,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
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
      _counter = _counter - _step;
      if (_counter < 0) _counter = 0;
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  bool _isFirstImage = true;

  late final AnimationController _controller;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _fade = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _controller.value = 1.0;
  }

  void _toggleImage() {
    _controller.reverse().then((_) {
      setState(() {
        _isFirstImage = !_isFirstImage;
      });
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Edit image1 and image2 file path to work on your machine (Right now it's set to my full path)
  String get _currentAsset => _isFirstImage ? "/Users/mohamed/Documents/CompSci/Current_Classes/MAD/hw/hw2/cw1_counter_app/lib/assets/image1.png" : "/Users/mohamed/Documents/CompSci/Current_Classes/MAD/hw/hw2/cw1_counter_app/lib/assets/image2.png";

  @override
  Widget build(BuildContext context) {
    final bool canDecrement = _counter > 0;
    final bool canReset = _counter > 0;
    final bool isDark = widget.themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text("CW #01 - Counter & Image Toggle"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: widget.onToggleTheme,
            icon: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
            tooltip: "Toggle Theme",
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Text(
            "Task 1: Counter",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 10),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
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
                      OutlinedButton(onPressed: () => _setStep(1), child: const Text("+1")),
                      OutlinedButton(onPressed: () => _setStep(5), child: const Text("+5")),
                      OutlinedButton(onPressed: () => _setStep(10), child: const Text("+10")),
                    ],
                  ),
                  const SizedBox(height: 18),

                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    alignment: WrapAlignment.center,
                    children: [
                      ElevatedButton(onPressed: _increment, child: const Text("Increment")),
                      ElevatedButton(
                        onPressed: canDecrement ? _decrement : null,
                        child: const Text("Decrement"),
                      ),
                      ElevatedButton(
                        onPressed: canReset ? _resetCounter : null,
                        child: const Text("Reset"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 22),

          Text(
            "Task 2: Image Toggle and Theme",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 10),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    "Current Image: ${_isFirstImage ? "Image 1" : "Image 2"}",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 14),

                  FadeTransition(
                    opacity: _fade,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.asset(
                        _currentAsset,
                        height: 240,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    alignment: WrapAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: _toggleImage,
                        child: const Text("Toggle Image"),
                      ),
                      ElevatedButton(
                        onPressed: widget.onToggleTheme,
                        child: Text(isDark ? "Switch to Light" : "Switch to Dark"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}