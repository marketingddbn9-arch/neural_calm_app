import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const NeuralCalmApp());
}

class NeuralCalmApp extends StatelessWidget {
  const NeuralCalmApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Neural Calm',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        primaryColor: const Color(0xFF7C5CFA),
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.interTightTextTheme(
          Theme.of(context).textTheme,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF7C5CFA),
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF7C5CFA),
        scaffoldBackgroundColor: const Color(0xFF1A1A1A),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF7C5CFA),
          brightness: Brightness.dark,
        ),
      ),
      themeMode: ThemeMode.system,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const Center(
      child: Text(
        'Home Tab',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    ),
    const Center(
      child: Text(
        'Check-in Tab',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    ),
    const Center(
      child: Text(
        'Analytics Tab',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Neural Calm'),
        centerTitle: true,
        backgroundColor: const Color(0xFF7C5CFA),
        foregroundColor: Colors.white,
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: 'Check-in',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Analytics',
          ),
        ],
      ),
    );
  }
}
