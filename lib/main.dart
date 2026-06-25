import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/auth/login_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/checkin/checkin_screen.dart';
import 'screens/analytics/analytics_screen.dart';
import 'config/app_theme.dart';

void main() {
  runApp(const NeuralCalmApp());
}

class NeuralCalmApp extends StatefulWidget {
  const NeuralCalmApp({Key? key}) : super(key: key);

  @override
  State<NeuralCalmApp> createState() => _NeuralCalmAppState();
}

class _NeuralCalmAppState extends State<NeuralCalmApp> {
  bool isLoggedIn = false;

  void _handleLogin() {
    setState(() {
      isLoggedIn = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Neural Calm',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        primaryColor: AppTheme.primaryPurple,
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
        primaryColor: AppTheme.primaryPurple,
        scaffoldBackgroundColor: const Color(0xFF1A1A1A),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF7C5CFA),
          brightness: Brightness.dark,
        ),
      ),
      themeMode: ThemeMode.system,
      home: isLoggedIn
          ? const MainApp()
          : LoginScreen(onLoginSuccess: _handleLogin),
    );
  }
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),      // Home
    const CheckInScreen(),   // Check-in
    const AnalyticsScreen(), // Analytics
  ];

  final List<String> _tabLabels = ['Home', 'Check-in', 'Analytics'];
  final List<IconData> _tabIcons = [
    Icons.home_outlined,
    Icons.edit_outlined,
    Icons.bar_chart_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: Colors.grey.shade200,
              width: 1,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                _screens.length,
                (index) => _buildNavItem(index),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index) {
    final isActive = _currentIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive
              ? AppTheme.primaryPurple.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _tabIcons[index],
              color: isActive ? AppTheme.primaryPurple : Colors.grey,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              _tabLabels[index],
              style: AppTheme.caption.copyWith(
                color: isActive ? AppTheme.primaryPurple : Colors.grey,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}