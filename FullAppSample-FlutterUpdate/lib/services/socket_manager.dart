import 'package:fullapp/config.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketManager {
  static final SocketManager _instance = SocketManager._internal();
  IO.Socket? _socket; // Make socket nullable

  factory SocketManager() => _instance;
  SocketManager._internal();

  bool get isInitialized => _socket != null;

  IO.Socket get socket {
    if (_socket == null) {
      initialize(); // Auto-initialize if not done
    }
    return _socket!;
  }

  void initialize() {
    if (_socket != null) return; // Don't initialize if already done

    _socket = IO.io(
      kBackendBaseUrl,
      IO.OptionBuilder()
        .setTransports(['websocket'])
        .enableAutoConnect()
        .build(),
    );

    _socket!.onConnect((_) {
      print('Socket connected: ${_socket!.id}');
    });

    _socket!.onDisconnect((_) {
      print('Socket disconnected');
    });
  }

  void joinGame(String gameId) {
    if (!isInitialized) return;
    
    if (_socket!.connected) {
      _socket!.emit('join game', gameId);
      print('Socket ${_socket!.id} joined game $gameId');
    } else {
      _socket!.on('connect', (_) {
        _socket!.emit('join game', gameId);
        print('Socket ${_socket!.id} joined game $gameId after reconnect');
      });
    }
  }

  void leaveGame(String gameId) {
    if (!isInitialized) return;
    
    if (_socket!.connected) {
      _socket!.emit('leave game', gameId);
      print('Socket ${_socket!.id} left game $gameId');
    }
  }

  void disconnect() {
    if (_socket != null) {
      _socket!.dispose();
      _socket = null;
      print('Socket disconnected via logout');
    }
  }
}