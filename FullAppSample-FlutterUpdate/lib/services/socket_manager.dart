import 'package:fullapp/config.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketManager {
  static final SocketManager _instance = SocketManager._internal();
  late IO.Socket socket;

  factory SocketManager() => _instance;
  SocketManager._internal();

  void initialize() {
    socket = IO.io(
      kBackendBaseUrl,
      IO.OptionBuilder()
        .setTransports(['websocket'])
        .enableAutoConnect()
        .build(),
    );

    socket.onConnect((_) {
      print('Socket connected: ${socket.id}');
    });

    socket.onDisconnect((_) {
      print('Socket disconnected');
    });
  }

  void joinGame(String gameId) {
    if (socket.connected) {
      socket.emit('join game', gameId);
      print('Socket ${socket.id} joined game $gameId');
    } else {
      socket.on('connect', (_) {
        socket.emit('join game', gameId);
        print('Socket ${socket.id} joined game $gameId after reconnect');
      });
    }
  }

  void leaveGame(String gameId) {
    if (socket.connected) {
      socket.emit('leave game', gameId);
      print('Socket ${socket.id} left game $gameId');
    }
  }

  void disconnect() {
    socket.dispose();
    print('Socket disconnected via logout');
  }
}
