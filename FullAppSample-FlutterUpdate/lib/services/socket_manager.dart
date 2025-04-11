import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketManager {
  static final SocketManager _instance = SocketManager._internal();
  late IO.Socket socket;

  factory SocketManager() {
    return _instance;
  }

  SocketManager._internal();

  // Initialize without a game id so that it can be called on login.
  void initialize() {
    socket = IO.io('http://localhost:8000', IO.OptionBuilder()
        .setTransports(['websocket'])
        .build());

    socket.onConnect((_) {
      print('Socket connected: ${socket.id}');
      // No join yet.
    });

    socket.onDisconnect((_) {
      print('Socket disconnected');
    });
  }

  // Call to join a specific game room.
  void joinGame(String gameId) {
    if (socket.connected) {
      socket.emit('join game', gameId);
      print('Socket ${socket.id} joined game $gameId');
    } else {
      // Optionally, attach a one-time listener so that when the socket connects it joins the room.
      socket.on('connect', (_) {
        socket.emit('join game', gameId);
        print('Socket ${socket.id} joined game $gameId after reconnect');
      });
    }
  }

  // Call this method to leave a specific game room.
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
