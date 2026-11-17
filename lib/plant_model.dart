class Plant {
  final String id;
  final String nombre;
  final double precio;
  final String rutaImagen;
  final String categoria;
  final String descripcion;
  final String luz;
  final String riego;

  const Plant({
    required this.id,
    required this.nombre,
    required this.precio,
    required this.rutaImagen,
    required this.categoria,
    required this.descripcion,
    required this.luz,
    required this.riego,
  });

  String get precioTexto => '\$${precio.toStringAsFixed(0)}';

  factory Plant.fromMap(String id, Map<String, dynamic> data) {
    final nombre = _leerTexto(data, ['Nombre', 'nombre'], 'Sin nombre');

    return Plant(
      id: id,
      nombre: nombre,
      precio: _leerNumero(data, ['Precio', 'precio']),
      rutaImagen: _leerTexto(data, ['Ruta', 'ruta', 'rutaimagen'], ''),
      categoria: _leerTexto(data, [
        'Categoría',
        'Categoria',
        'categoria',
      ], 'Sin categoría'),
      descripcion: _leerDescripcion(data, nombre),
      luz: _leerTexto(data, ['Luz', 'luz'], 'Sin información'),
      riego: _leerTexto(data, ['Riego', 'riego'], 'Sin información'),
    );
  }
}

String _normalizarCampo(String campo) => campo
    .trim()
    .toLowerCase()
    .replaceAll('á', 'a')
    .replaceAll('é', 'e')
    .replaceAll('í', 'i')
    .replaceAll('ó', 'o')
    .replaceAll('ú', 'u')
    .replaceAll(RegExp(r'[^a-z0-9]'), '');

dynamic _leerCampo(Map<String, dynamic> data, List<String> aliases) {
  for (final alias in aliases) {
    final nombreBuscado = _normalizarCampo(alias);
    for (final entry in data.entries) {
      if (_normalizarCampo(entry.key) == nombreBuscado) {
        return entry.value;
      }
    }
  }
  return null;
}

String _leerTexto(
  Map<String, dynamic> data,
  List<String> aliases,
  String valorPorDefecto,
) {
  final valor = _leerCampo(data, aliases);
  if (valor == null) return valorPorDefecto;
  final texto = valor.toString().trim();
  return texto.isEmpty ? valorPorDefecto : texto;
}

String _leerDescripcion(Map<String, dynamic> data, String nombre) {
  final descripcion = _leerTexto(data, [
    'Descripción',
    'Descripcion',
    'descripcion',
    'Descripción de la planta',
    'Descripcion de la planta',
    'Detalle',
  ], '');
  if (descripcion.isNotEmpty) return descripcion;

  for (final planta in plantasDemo) {
    if (_normalizarCampo(planta.nombre) == _normalizarCampo(nombre)) {
      return planta.descripcion;
    }
  }
  return 'Sin descripción';
}

double _leerNumero(Map<String, dynamic> data, List<String> aliases) {
  final valor = _leerCampo(data, aliases);
  if (valor is num) return valor.toDouble();
  return double.tryParse(valor?.toString().trim() ?? '') ?? 0;
}

const List<Plant> plantasDemo = [
  Plant(
    id: 'demo-1',
    nombre: 'Monstera deliciosa',
    precio: 38,
    rutaImagen: 'img/Plantas/Monstera_Deliciosa.jpg',
    categoria: 'Interior',
    descripcion: 'Planta tropical de hojas grandes que aporta un toque verde y natural a tus espacios.',
    luz: 'Luz indirecta brillante',
    riego: 'Cuando se seque la capa superior',
  ),
  Plant(
    id: 'demo-2',
    nombre: 'Aloe vera',
    precio: 18,
    rutaImagen: 'img/Plantas/Aloe_Vera.jpg',
    categoria: 'Exterior',
    descripcion:
        'Suculenta resistente y fácil de cuidar, ideal para lugares luminosos.',
    luz: 'Luz abundante',
    riego: 'Poco frecuente; dejar secar el sustrato',
  ),
  Plant(
    id: 'demo-3',
    nombre: 'Anturio',
    precio: 28,
    rutaImagen: 'img/Plantas/Anthurium_Andreanum.jpg',
    categoria: 'Interior',
    descripcion: 'Planta ornamental reconocida por sus flores llamativas y hojas brillantes.',
    luz: 'Luz indirecta',
    riego: 'Moderado; mantener humedad ligera',
  ),
  Plant(
    id: 'demo-4',
    nombre: 'Orquídea phalaenopsis',
    precio: 36,
    rutaImagen: 'img/Plantas/Phalaenopsis_Orchid.jpg',
    categoria: 'Interior',
    descripcion: 'Orquídea elegante de floración vistosa que luce muy bien en interiores iluminados.',
    luz: 'Luz indirecta brillante',
    riego: 'Moderado; evitar encharcar',
  ),
  Plant(
    id: 'demo-5',
    nombre: 'Ficus lyrata',
    precio: 42,
    rutaImagen: 'img/Plantas/Ficus_Lyrata.jpg',
    categoria: 'Interior',
    descripcion: 'Árbol de interior de porte elegante y hojas grandes con forma característica.',
    luz: 'Luz brillante indirecta',
    riego: 'Cuando la superficie del sustrato esté seca',
  ),
  Plant(
    id: 'demo-6',
    nombre: 'Alocasia amazónica Polly',
    precio: 32,
    rutaImagen: 'img/Plantas/Alocasia_Amazonica_Polly.jpg',
    categoria: 'Interior',
    descripcion: 'Planta tropical de hojas oscuras con nervaduras claras muy decorativas.',
    luz: 'Luz indirecta brillante',
    riego: 'Regular; mantener el sustrato ligeramente húmedo',
  ),
  Plant(
    id: 'demo-7',
    nombre: 'Begonia maculata',
    precio: 26,
    rutaImagen: 'img/Plantas/Begonia_Maculata.jpg',
    categoria: 'Interior',
    descripcion:
        'Begonia de hojas alargadas con lunares plateados y reverso rojizo.',
    luz: 'Luz indirecta',
    riego: 'Moderado; evitar mojar las hojas',
  ),
  Plant(
    id: 'demo-8',
    nombre: 'Calathea orbifolia',
    precio: 34,
    rutaImagen: 'img/Plantas/Calathea_Orbifolia.jpg',
    categoria: 'Interior',
    descripcion: 'Planta tropical conocida por sus hojas redondas con franjas plateadas.',
    luz: 'Luz indirecta y suave',
    riego: 'Frecuente; mantener humedad sin encharcar',
  ),
  Plant(
    id: 'demo-9',
    nombre: 'Calathea zebrina',
    precio: 30,
    rutaImagen: 'img/Plantas/Calathea_Zebrina.jpg',
    categoria: 'Interior',
    descripcion:
        'Sus hojas aterciopeladas presentan un patrón verde similar a rayas.',
    luz: 'Luz indirecta',
    riego: 'Regular; conservar el sustrato ligeramente húmedo',
  ),
  Plant(
    id: 'demo-10',
    nombre: 'Ceropegia woodii',
    precio: 22,
    rutaImagen: 'img/Plantas/Ceropegia_Woodii.jpg',
    categoria: 'Interior',
    descripcion:
        'Planta colgante de tallos finos y hojas pequeñas en forma de corazón.',
    luz: 'Luz brillante indirecta',
    riego: 'Poco frecuente; dejar secar el sustrato',
  ),
  Plant(
    id: 'demo-11',
    nombre: 'Cinta',
    precio: 16,
    rutaImagen: 'img/Plantas/Chlorophytum_Comosum.jpg',
    categoria: 'Interior',
    descripcion:
        'Planta resistente de hojas arqueadas que produce pequeños hijuelos.',
    luz: 'Luz indirecta',
    riego: 'Moderado; dejar secar ligeramente entre riegos',
  ),
  Plant(
    id: 'demo-12',
    nombre: 'Crotón',
    precio: 29,
    rutaImagen: 'img/Plantas/Codiaeum_Variegatum.jpg',
    categoria: 'Interior',
    descripcion: 'Planta de follaje colorido que añade tonos cálidos a cualquier espacio.',
    luz: 'Luz brillante',
    riego: 'Regular; evitar que el sustrato se seque por completo',
  ),
  Plant(
    id: 'demo-13',
    nombre: 'Árbol de jade',
    precio: 20,
    rutaImagen: 'img/Plantas/Crassula_Ovata.jpg',
    categoria: 'Exterior',
    descripcion: 'Suculenta de hojas carnosas y crecimiento compacto, fácil de mantener.',
    luz: 'Luz abundante',
    riego: 'Escaso; dejar secar completamente el sustrato',
  ),
  Plant(
    id: 'demo-14',
    nombre: 'Poto',
    precio: 19,
    rutaImagen: 'img/Plantas/Epipremnum_Aureum.jpg',
    categoria: 'Interior',
    descripcion:
        'Planta trepadora o colgante de hojas verdes, muy adaptable al hogar.',
    luz: 'Luz indirecta',
    riego: 'Cuando la capa superior del sustrato esté seca',
  ),
  Plant(
    id: 'demo-15',
    nombre: 'Euforbia tirucalli',
    precio: 24,
    rutaImagen: 'img/Plantas/Euphorbia_Tirucalli.jpg',
    categoria: 'Exterior',
    descripcion: 'Suculenta de ramas delgadas y verticales que necesita poco mantenimiento.',
    luz: 'Luz abundante o sol suave',
    riego: 'Escaso; dejar secar el sustrato entre riegos',
  ),
  Plant(
    id: 'demo-16',
    nombre: 'Ficus elastica',
    precio: 35,
    rutaImagen: 'img/Plantas/Ficus_Elastica.jpg',
    categoria: 'Interior',
    descripcion: 'Planta de interior de hojas grandes, firmes y brillantes.',
    luz: 'Luz indirecta brillante',
    riego: 'Moderado; dejar secar la superficie del sustrato',
  ),
  Plant(
    id: 'demo-17',
    nombre: 'Maranta leuconeura',
    precio: 27,
    rutaImagen: 'img/Plantas/Maranta_Leuconeura.jpg',
    categoria: 'Interior',
    descripcion: 'Planta tropical de hojas decoradas con patrones y nervaduras contrastantes.',
    luz: 'Luz indirecta',
    riego: 'Frecuente; mantener humedad ligera',
  ),
  Plant(
    id: 'demo-18',
    nombre: 'Helecho espada',
    precio: 23,
    rutaImagen: 'img/Plantas/Nephrolepis_Exaltata.jpg',
    categoria: 'Interior',
    descripcion:
        'Helecho frondoso de hojas arqueadas que aporta frescura al ambiente.',
    luz: 'Luz indirecta',
    riego: 'Frecuente; mantener el sustrato húmedo',
  ),
  Plant(
    id: 'demo-19',
    nombre: 'Pachira acuática',
    precio: 39,
    rutaImagen: 'img/Plantas/Pachira_Aquatica.jpg',
    categoria: 'Interior',
    descripcion: 'Pequeño árbol ornamental de follaje palmeado, popular para interiores.',
    luz: 'Luz indirecta brillante',
    riego: 'Moderado; dejar secar un poco entre riegos',
  ),
  Plant(
    id: 'demo-20',
    nombre: 'Peperomia sandía',
    precio: 21,
    rutaImagen: 'img/Plantas/Peperomia_Argyreia.jpg',
    categoria: 'Interior',
    descripcion: 'Planta compacta con hojas redondas que recuerdan el patrón de una sandía.',
    luz: 'Luz indirecta',
    riego: 'Moderado; dejar secar la superficie del sustrato',
  ),
  Plant(
    id: 'demo-21',
    nombre: 'Filodendro Brasil',
    precio: 24,
    rutaImagen: 'img/Plantas/Philodendron_Hederaceum_Brasil.jpg',
    categoria: 'Interior',
    descripcion:
        'Planta colgante de hojas acorazonadas con tonos verdes y amarillos.',
    luz: 'Luz indirecta',
    riego: 'Cuando la capa superior del sustrato esté seca',
  ),
  Plant(
    id: 'demo-22',
    nombre: 'Pilea peperomioides',
    precio: 25,
    rutaImagen: 'img/Plantas/Pilea_Peperomioides.jpg',
    categoria: 'Interior',
    descripcion:
        'Planta compacta de hojas redondas sostenidas por largos pecíolos.',
    luz: 'Luz indirecta brillante',
    riego: 'Moderado; dejar secar ligeramente entre riegos',
  ),
  Plant(
    id: 'demo-23',
    nombre: 'Aglaonema rosa',
    precio: 33,
    rutaImagen: 'img/Plantas/Pink_Aglaonema.jpg',
    categoria: 'Interior',
    descripcion: 'Planta ornamental de hojas con matices rosados y verdes.',
    luz: 'Luz indirecta',
    riego: 'Moderado; evitar el exceso de agua',
  ),
  Plant(
    id: 'demo-24',
    nombre: 'Lengua de suegra',
    precio: 28,
    rutaImagen: 'img/Plantas/Sansevieria_Trifasciata.jpg',
    categoria: 'Interior',
    descripcion: 'Planta erguida y resistente con hojas largas, ideal para principiantes.',
    luz: 'Luz indirecta o semisombra',
    riego: 'Escaso; dejar secar el sustrato por completo',
  ),
  Plant(
    id: 'demo-25',
    nombre: 'Collar de perlas',
    precio: 20,
    rutaImagen: 'img/Plantas/Senecio_Rowleyanus.jpg',
    categoria: 'Interior',
    descripcion:
        'Suculenta colgante con tallos cubiertos de pequeñas hojas esféricas.',
    luz: 'Luz brillante indirecta',
    riego: 'Escaso; dejar secar completamente entre riegos',
  ),
  Plant(
    id: 'demo-26',
    nombre: 'Lirio de paz',
    precio: 31,
    rutaImagen: 'img/Plantas/Spathiphyllum.jpg',
    categoria: 'Interior',
    descripcion: 'Planta de hojas verdes y flores claras que se adapta bien a interiores.',
    luz: 'Luz indirecta',
    riego: 'Regular; mantener el sustrato ligeramente húmedo',
  ),
  Plant(
    id: 'demo-27',
    nombre: 'Ave del paraíso',
    precio: 48,
    rutaImagen: 'img/Plantas/Strelitzia_Nicolai.jpg',
    categoria: 'Exterior',
    descripcion:
        'Planta de gran porte con hojas amplias de apariencia tropical.',
    luz: 'Luz abundante',
    riego: 'Regular durante el crecimiento; moderado en invierno',
  ),
  Plant(
    id: 'demo-28',
    nombre: 'Singonio',
    precio: 19,
    rutaImagen: 'img/Plantas/Syngonium_Podophyllum.jpg',
    categoria: 'Interior',
    descripcion: 'Planta trepadora de hojas en forma de flecha que cambia con el crecimiento.',
    luz: 'Luz indirecta',
    riego: 'Moderado; dejar secar un poco entre riegos',
  ),
  Plant(
    id: 'demo-29',
    nombre: 'Amor de hombre',
    precio: 17,
    rutaImagen: 'img/Plantas/Tradescantia_Zebrina.jpg',
    categoria: 'Interior',
    descripcion: 'Planta colgante de hojas con franjas moradas y plateadas.',
    luz: 'Luz brillante indirecta',
    riego: 'Moderado; evitar encharcar',
  ),
  Plant(
    id: 'demo-30',
    nombre: 'Zamioculca',
    precio: 37,
    rutaImagen: 'img/Plantas/Zamioculcas_Zamiifolia.jpg',
    categoria: 'Interior',
    descripcion:
        'Planta resistente de hojas brillantes que requiere pocos cuidados.',
    luz: 'Luz indirecta o semisombra',
    riego: 'Escaso; dejar secar el sustrato entre riegos',
  ),
];
