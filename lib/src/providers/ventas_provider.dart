import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soal_natura/src/services/ventas_services.dart';

final ventasPoriver = ChangeNotifierProvider<VentasService>((ref) {
  return VentasService();
});
