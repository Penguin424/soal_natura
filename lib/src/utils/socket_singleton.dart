import 'package:soal_natura/src/utils/preferences_utils.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  static SocketService? _instance;
  IO.Socket? _socket;

  // Constructor privado para evitar que se creen instancias directamente.
  SocketService._();

  // Método estático para obtener la instancia Singleton.
  static SocketService getInstance() {
    _instance ??= SocketService._();
    return _instance!;
  }

  static const IS_DEV = true;

  // Método para conectar con el servidor Socket.IO.
  void connect() {
    _socket ??= IO.io(
      IS_DEV
          ? 'http://192.168.1.80:1337/'
          : 'https://movimiento-ciudadano-backend-0a72600137cb.herokuapp.com/',
      <String, dynamic>{
        'transports': ['websocket'],
        "auth": {
          "token": PreferencesUtils.getString("token"),
        }
      },
    );
  }

  // Método para obtener la instancia del socket.
  IO.Socket? getSocket() {
    return _socket;
  }

  // Método para desconectar del servidor Socket.IO.
  void disconnect() {
    _socket?.disconnect();
  }
}
