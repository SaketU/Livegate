import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketManager {
  static final SocketManager _instance = SocketManager._internal();
  late IO.Socket socket;

  factory SocketManager() {
    return _instance;
  }

  SocketManager._internal();

  void initialize(String gameId) {
    socket = IO.io('http://localhost:8000', IO.OptionBuilder()
        .setTransports(['websocket'])
        .build());

    socket.onConnect((_) {
      print('Socket connected: ${socket.id}');
      socket.emit('join game', gameId);
    });

    // socket.on('new message', (data) {
    //   print('New message received: $data');
    //   // Additional handling here
    // });

    socket.onDisconnect((_) {
      print('Socket disconnected');
    });
  }

  void disconnect() {
    socket.dispose();
    print('Socket disconnected via logout');
  }
}
