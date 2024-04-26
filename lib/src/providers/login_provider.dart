import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soal_natura/src/services/login_service.dart';

final loginProvider = ChangeNotifierProvider<LoginService>((ref) {
  return LoginService();
});
