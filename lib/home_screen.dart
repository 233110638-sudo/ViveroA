import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth_repository.dart';
import 'auth_screen.dart';
import 'plant_details_screen.dart';
import 'catalogo_screen.dart';

import 'cart_provider.dart';
import 'core_theme.dart';
import 'plant_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool esFavorito = false;

  void alternativoFavorito() {
    setState(() {
      esFavorito = !esFavorito;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Vivero+',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Cerrar sesión',
            onPressed: () async {
              await AuthRepository().cerrarSesion();
              if (!mounted) return;
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const AuthScreen()),
                (route) => false,
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                '🛒 ${context.watch<CartProvider>().cantidad}',
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ],
        backgroundColor: const Color(0xFF1565C0),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'img/Plantas/logos/Logo.png',
                width: 220,
                height: 220,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 24),
              const Text(
                'Bienvenidos a Vivero+',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textoPrincipal,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Cuida tus plantas como cuidas tu mente',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textoSecundario,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                AuthRepository().usuarioActual?.email ?? '',
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: alternativoFavorito,
                icon: Icon(
                  esFavorito ? Icons.favorite : Icons.favorite_border,
                  color: esFavorito ? const Color(0xFF1565C0) : null,
                ),
                label: Text(
                  esFavorito ? 'En favoritos' : 'Agregar a favoritos',
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 12,
                runSpacing: 12,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<CartProvider>().agregar();
                    },
                    icon: const Icon(Icons.add_shopping_cart),
                    label: const Text('Agregar al carrito'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<CartProvider>().quitar();
                    },
                    icon: const Icon(Icons.delete),
                    label: const Text('Eliminar del carrito'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CatalogoScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.list_alt),
                  label: const Text('Catálogo'),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PlantDetailsScreen(planta: plantasDemo.first),
                          ),
                        );
                      },
                      child: _StatCard(
                        icon: Icons.local_florist,
                        label: '12 plantas',
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _StatCard(
                      icon: Icons.water_drop,
                      label: '3 por regar',
                    ),
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

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;

  const _StatCard({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: const Color(0xFF1565C0)),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 13, color: Color(0xFF0D47A1)),
          ),
        ],
      ),
    );
  }
}
