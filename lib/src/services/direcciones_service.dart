import 'package:flutter/material.dart';
import 'package:soal_natura/src/models/direccion_registro_form_model.dart';

class DireccionesService extends ChangeNotifier {
  final _direccionRegistroForm = DireccionRegistroFormModel();

  DireccionRegistroFormModel get direccionRegistroForm =>
      _direccionRegistroForm;

  set direccionRegistroForm(DireccionRegistroFormModel value) {
    _direccionRegistroForm.domicilio = value.domicilio;
    _direccionRegistroForm.colonia = value.colonia;
    _direccionRegistroForm.ciudad = value.ciudad;
    _direccionRegistroForm.estado = value.estado;
    _direccionRegistroForm.cp = value.cp;
    _direccionRegistroForm.cruces = value.cruces;
    _direccionRegistroForm.cliente = value.cliente;
    notifyListeners();
  }
}
