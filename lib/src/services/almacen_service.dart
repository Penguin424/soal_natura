import 'package:flutter/material.dart';
import 'package:soal_natura/src/models/almacen/producto_model.dart';
import 'package:soal_natura/src/utils/http_utils.dart';

class AlmacenService extends ChangeNotifier {
  List<ProductoModel> _productos = [];

  List<ProductoModel> get productos => _productos;

  set productos(List<ProductoModel> value) {
    _productos = value;
    notifyListeners();
  }

  Future<void> handleGetProductos() async {
    final productosDB = await Http.get("api/productos", {
      "_limit": "10000",
    });

    productos = productosDB.data["data"]
        .map<ProductoModel>((producto) => ProductoModel.fromJson(producto))
        .toList();
  }
}
