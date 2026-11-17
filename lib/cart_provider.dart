import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  int _cantidad = 0;
  int get cantidad => _cantidad;

  void agregar() {
    _cantidad++;
    notifyListeners();
  }

  void quitar() {
    if (_cantidad > 0) {
      _cantidad--;
      notifyListeners();
    }
  }
}
