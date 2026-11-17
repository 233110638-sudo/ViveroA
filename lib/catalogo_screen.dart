import 'package:flutter/material.dart';

import 'plant_card.dart';
import 'plant_details_screen.dart';
import 'plant_model.dart';
import 'plant_repository.dart';

class CatalogoScreen extends StatefulWidget {
  const CatalogoScreen({super.key});

  @override
  State<CatalogoScreen> createState() => _CatalogoScreenState();
}

class _CatalogoScreenState extends State<CatalogoScreen> {
  final TextEditingController _busquedaController = TextEditingController();
  final PlantRepository _repository = PlantRepository();
  List<Plant> _plantas = [];
  bool _cargando = true;
  String? _error;
  String _categoriaSeleccionada = 'Todas';

  @override
  void initState() {
    super.initState();
    _cargarPlantas();
  }

  Future<void> _cargarPlantas() async {
    setState(() {
      _cargando = true;
      _error = null;
    });
    try {
      final plantas = await _repository.obtenerPlantas();
      if (!mounted) return;
      setState(() => _plantas = plantas);
    } catch (e) {
      debugPrint('Error al cargar las plantas: $e');
      if (!mounted) return;
      setState(() {
        _error = 'Error al cargar las plantas, intenta de nuevo';
      });
    } finally {
      if (mounted) {
        setState(() => _cargando = false);
      }
    }
  }

  List<String> get _categorias {
    final categoriasUnicas = _plantas
        .map((planta) => planta.categoria)
        .toSet()
        .toList();
    categoriasUnicas.sort();
    return ['Todas', ...categoriasUnicas];
  }

  @override
  void dispose() {
    _busquedaController.dispose();
    super.dispose();
  }

  Widget _contenido(List<Plant> plantasFiltradas) {
    if (_cargando) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.white),
      );
    }
    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.cloud_off, size: 42, color: Colors.white70),
              const SizedBox(height: 8),
              Text(
                _error!,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _cargarPlantas,
                child: const Text('Reintentar'),
              ),
            ],
          ),
        ),
      );
    }
    if (plantasFiltradas.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.search_off, size: 42, color: Colors.white70),
              const SizedBox(height: 8),
              Text(
                'No encontramos plantas con esa búsqueda.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      );
    }
    return LayoutBuilder(
      builder: (context, constraints) {
        final columnas = constraints.maxWidth >= 600 ? 3 : 2;
        return GridView.builder(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          itemCount: plantasFiltradas.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columnas,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.72,
          ),
          itemBuilder: (context, index) {
            final planta = plantasFiltradas[index];
            return Hero(
              tag: 'planta-${planta.id}',
              child: PlantCard(
                nombre: planta.nombre,
                precio: planta.precioTexto,
                rutaImagen: planta.rutaImagen,
                categoria: planta.categoria,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlantDetailsScreen(planta: planta),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final consulta = _busquedaController.text.trim().toLowerCase();
    final plantasFiltradas = _plantas.where((planta) {
      final coincideNombre = planta.nombre.toLowerCase().contains(consulta);
      final coincideCategoria =
          _categoriaSeleccionada == 'Todas' ||
          planta.categoria == _categoriaSeleccionada;
      return coincideNombre && coincideCategoria;
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Catálogo')),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
              child: TextField(
                controller: _busquedaController,
                onChanged: (_) => setState(() {}),
                style: const TextStyle(color: Color(0xFF1F2937), fontSize: 16),
                cursorColor: const Color(0xFF1565C0),
                decoration: InputDecoration(
                  hintText: 'Buscar una planta...',
                  hintStyle: const TextStyle(color: Color(0xFF6B7280)),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Color(0xFF4B5563),
                  ),
                  suffixIcon: _busquedaController.text.isEmpty
                      ? null
                      : IconButton(
                          tooltip: 'Limpiar búsqueda',
                          onPressed: () {
                            _busquedaController.clear();
                            setState(() {});
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Color(0xFF4B5563),
                          ),
                        ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
                spacing: 8,
                children: _categorias.map((categoria) {
                  final seleccionada = _categoriaSeleccionada == categoria;
                  return ChoiceChip(
                    label: Text(categoria),
                    selected: seleccionada,
                    onSelected: (_) => setState(() {
                      _categoriaSeleccionada = categoria;
                    }),
                    selectedColor: const Color(0xFFDCEBFA),
                    backgroundColor: Colors.white,
                    labelStyle: TextStyle(
                      color: seleccionada
                          ? const Color(0xFF0D47A1)
                          : const Color(0xFF1F2937),
                      fontWeight: seleccionada
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                    side: BorderSide.none,
                    showCheckmark: false,
                  );
                }).toList(),
              ),
            ),
            if (!_cargando && _error == null)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 10),
                child: Text(
                  '${plantasFiltradas.length} plantas disponibles',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            Expanded(child: _contenido(plantasFiltradas)),
          ],
        ),
      ),
    );
  }
}
