import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soal_natura/src/services/direcciones_service.dart';

final direccionesProvider = ChangeNotifierProvider<DireccionesService>(
  (ref) {
    return DireccionesService();
  },
);
