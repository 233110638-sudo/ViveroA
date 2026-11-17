import 'package:cloud_firestore/cloud_firestore.dart';

import 'plant_model.dart';

class PlantRepository {
  final CollectionReference<Map<String, dynamic>> _plantas = FirebaseFirestore
      .instance
      .collection('Plants');

  Future<List<Plant>> obtenerPlantas() async {
    final snapshot = await _plantas.get();
    final plantas = snapshot.docs
        .map((doc) => Plant.fromMap(doc.id, doc.data()))
        .toList();
    plantas.sort(
      (a, b) => a.nombre.toLowerCase().compareTo(b.nombre.toLowerCase()),
    );
    return plantas;
  }
}
