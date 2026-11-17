import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cart_provider.dart';
import 'plant_model.dart';

class PlantDetailsScreen extends StatelessWidget {
  final Plant planta;

  const PlantDetailsScreen({super.key, required this.planta});

  @override
  Widget build(BuildContext context) {
    final tieneLuz = _tieneInformacion(planta.luz);
    final tieneRiego = _tieneInformacion(planta.riego);

    return Scaffold(
      appBar: AppBar(title: Text(planta.nombre)),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: AspectRatio(
                    aspectRatio: 4 / 3,
                    child: Image.asset(
                      planta.rutaImagen,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const ColoredBox(
                            color: Color(0xFFE8F5E9),
                            child: Icon(
                              Icons.local_florist,
                              size: 96,
                              color: Color(0xFF4CAF50),
                            ),
                          ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Card(
                  color: Colors.white,
                  elevation: 1,
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          planta.nombre,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Text(
                              planta.precioTexto,
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFDCEBFA),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                planta.categoria,
                                style: const TextStyle(
                                  color: Color(0xFF0D47A1),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Text(
                          'Descripción',
                          style: Theme.of(context).textTheme.titleSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          planta.descripcion,
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                color: const Color(0xFF4B5563),
                                fontSize: 15,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (tieneLuz || tieneRiego) ...[
                  const SizedBox(height: 16),
                  Text(
                    'Cuidados básicos',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      if (tieneLuz)
                        Expanded(
                          child: _CareCard(
                            icon: Icons.wb_sunny_outlined,
                            titulo: 'Luz',
                            detalle: planta.luz,
                          ),
                        ),
                      if (tieneLuz && tieneRiego) const SizedBox(width: 12),
                      if (tieneRiego)
                        Expanded(
                          child: _CareCard(
                            icon: Icons.water_drop_outlined,
                            titulo: 'Riego',
                            detalle: planta.riego,
                          ),
                        ),
                    ],
                  ),
                ],
                const SizedBox(height: 20),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        context.read<CartProvider>().agregar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${planta.nombre} agregada al carrito',
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.add_shopping_cart),
                      label: const Text('Agregar al carrito'),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        context.read<CartProvider>().quitar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${planta.nombre} eliminada del carrito',
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.delete),
                      label: const Text('Eliminar del carrito'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

bool _tieneInformacion(String valor) {
  final texto = valor.trim().toLowerCase();
  return texto.isNotEmpty && texto != 'sin información';
}

class _CareCard extends StatelessWidget {
  final IconData icon;
  final String titulo;
  final String detalle;

  const _CareCard({
    required this.icon,
    required this.titulo,
    required this.detalle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: const Color(0xFF1565C0)),
            const SizedBox(height: 8),
            Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(
              detalle,
              style: Theme.of(context).textTheme.bodySmall
                  ?.copyWith(color: const Color(0xFF4B5563)),
            ),
          ],
        ),
      ),
    );
  }
}
