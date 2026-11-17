import 'package:flutter/material.dart';

import 'auth_screen.dart';

import 'core_theme.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'img/Plantas/logos/Splash.png',
                width: 220,
                height: 220,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 24.0),
              const Text(
                'cultiva, aprende y crece',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textoPrincipal,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12.0),
              const Text(
                'Vivero+ es una herramienta que te ayuda con el cuidado de las plantas y tener un mejor entorno',
                style: TextStyle(
                  fontSize: 15,
                  color: AppColors.textoSecundario,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AuthScreen()),
                  );
                },
                child: const Text('Comenzar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
