import 'package:flutter/material.dart';
import 'package:app_medicamentos/pages/register/name_pathologies.dart';

class CartProvider extends ChangeNotifier {
  final List<Patologia> _items = []; //nombre de la variable del estado definida en la lista
  //Nombre de la vaiable get, con la que puedo acceder
  List<Patologia> get items => _items;

  void add(Patologia item) {
    _items.add(item);
    notifyListeners();
  }

  void remove(Patologia item) {
    _items.remove(item);
    notifyListeners(); //son los que estan escuchando el get
  }

  void removeAll() {
    _items.clear();
    notifyListeners();
  }

  List<String> getCartNames() {
    // Utiliza map para extraer los nombres de los productos y luego convierte el resultado en una lista
    return _items.map((item) => item.name).toList();
  }
}
