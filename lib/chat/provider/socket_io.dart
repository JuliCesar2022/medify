
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService extends GetxService {

  SocketService(){
    // initSocket('https://medify-app-backend-node.onrender.com');
    initSocket('https://medify-app-backend-node.onrender.com');
  }
  IO.Socket? socket;

  void initSocket(String url) {
    socket = IO.io(url, <String, dynamic>{
      "transports": ['websocket'],
      "autoConnect": false
    });
    print("Try connect to "+url);
    socket!.connect();
    socket!.onConnect((_) {
      print('connect');
    });
  }

 void closeSocket() {
  if (socket != null) {
    socket!.disconnect();
          print('disconnect');

    // socket= null;
  }
}

}