import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:hotel1/screens/booking_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 4));

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const BookingPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [const Color.fromARGB(255, 4, 21, 46), Colors.blue[400]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Lottie.asset(
            'assets/lottie/An3.json',
            width: 230,
            height: 230,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
