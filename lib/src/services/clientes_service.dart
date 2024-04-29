import 'package:flutter/material.dart';
import 'package:soal_natura/src/models/cliente_registro_form_model.dart';
import 'package:soal_natura/src/models/cliente_search_model.dart';
import 'package:soal_natura/src/utils/http_utils.dart';

class ClientesService extends ChangeNotifier {
  final _clienteRegistroForm = ClienteRegistroFormModel();
  List<ClienteSearchModel> _clientesSearch = [];

  ClienteRegistroFormModel get clienteRegistroForm => _clienteRegistroForm;
  List<ClienteSearchModel> get clientesSearch => _clientesSearch;

  set clienteRegistroForm(ClienteRegistroFormModel value) {
    _clienteRegistroForm.nombre = value.nombre;
    _clienteRegistroForm.telefono = value.telefono;
    _clienteRegistroForm.direccion = value.direccion;

    notifyListeners();
  }

  set clientesSearch(List<ClienteSearchModel> value) {
    _clientesSearch = value;
    notifyListeners();
  }

  void addClienteSearch(ClienteSearchModel cliente) {
    _clientesSearch.add(cliente);
    notifyListeners();
  }

  void handleSearchCliente(String query) async {
    final clientesDB = await Http.get(
      "api/clientes",
      {
        "populate[0]": "direcciones",
        "populate[1]": "ventas",
        "pagination[pageSize]": "5",
        "_q": query,
      },
    );

    print(clientesDB.data["data"]);

    clientesSearch = clientesDB.data["data"]
        .map<ClienteSearchModel>(
            (cliente) => ClienteSearchModel.fromJson(cliente))
        .toList();

    notifyListeners();
  }
}
