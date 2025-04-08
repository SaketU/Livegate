import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketManager {
  static final SocketManager _instance = SocketManager._internal();
  late IO.Socket socket;

  factory SocketManager() {
    return _instance;
  }

  SocketManager._internal();

  void initialize(String gameId) {
    if (socket != null && (socket.connected || !socket.disconnected)) {
      print('Socket already initialized.');
      return;
    }

    socket = IO.io('http://localhost:8000', IO.OptionBuilder()
        .setTransports(['websocket'])
        .enableReconnection()
        .build());

    socket.connect();

    socket.on('connect', (_) {
      print('Socket connected: ${socket.id}');
      socket.emit('join game', gameId);
    });

    socket.on('disconnect', (_) {
      print('Socket disconnected');
    });

    socket.on('connect_error', (err) {
      print('Connection error: $err');
    });
  }

  void disconnect() {
    socket.dispose();
    print(' Socket disconnected via logout');
  }
}
