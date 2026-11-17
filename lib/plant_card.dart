import 'package:flutter/material.dart';

import 'core_theme.dart';

class PlantCard extends StatelessWidget {
  final String nombre;
  final String precio;
  final String rutaImagen;
  final String categoria;
  final VoidCallback onTap;

  const PlantCard({
    super.key,
    required this.nombre,
    required this.precio,
    required this.rutaImagen,
    required this.categoria,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    rutaImagen,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const ColoredBox(
                          color: Color(0xFFE8F5E9),
                          child: Icon(Icons.local_florist, color: Colors.green),
                        ),
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.92),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        categoria,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textoSobreClaro,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nombre,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textoSobreClaro,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    precio,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textoSobreClaro,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
