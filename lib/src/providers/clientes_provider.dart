import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soal_natura/src/services/clientes_service.dart';

final clientesProvider = ChangeNotifierProvider<ClientesService>(
  (ref) {
    return ClientesService();
  },
);
