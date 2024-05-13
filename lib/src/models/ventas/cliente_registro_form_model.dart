///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class ClienteRegistroFormModel {
/*
{
  "nombre": "Juan Pablo Rizo Quintero",
  "telefono": "3319747514",
  "direccion": 1
} 
*/

  String? nombre;
  String? telefono;
  int? direccion;

  ClienteRegistroFormModel({
    this.nombre,
    this.telefono,
    this.direccion,
  });
  ClienteRegistroFormModel.fromJson(Map<String, dynamic> json) {
    nombre = json['nombre']?.toString();
    telefono = json['telefono']?.toString();
    direccion = json['direccion']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['nombre'] = nombre;
    data['telefono'] = telefono;
    data['direccion'] = direccion;
    return data;
  }
}