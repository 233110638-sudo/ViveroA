import 'package:flutter/material.dart';

import 'onboarding_screen.dart';
import 'auth_repository.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthRepository _auth = AuthRepository();

  @override
  void initState() {
    super.initState();
    _decidirDestino();
  }

  Future<void> _decidirDestino() async {
    final sesionFuture = _auth.cambiosDeSecion.first;
    await Future.delayed(const Duration(seconds: 2));
    final usuario = await sesionFuture;
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            usuario != null ? const HomeScreen() : const OnboardingScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: Image.asset(
          'img/Plantas/logos/splash2.png',
          width: 220,
          height: 220,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
