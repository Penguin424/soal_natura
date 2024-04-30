import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soal_natura/src/services/almacen_service.dart';

final almacenProvider = ChangeNotifierProvider<AlmacenService>(
  (ref) {
    return AlmacenService();
  },
);
