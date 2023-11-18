import 'dart:ui';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medify/chat/provider/socket_io.dart';
import 'package:medify/chat/widgets/message_person_group.dart';
import 'package:medify/chat/widgets/my_messages.dart';
import 'package:medify/config/config_global.dart';
import 'package:medify/src/Provider/PeticionesHttpProvider.dart';
import 'package:medify/src/Provider/PreferenciasUsuario.dart';
import 'package:medify/src/utils/UI/widget/global_widgets.dart';

class Chat_medify_comunity extends StatefulWidget {
  static String routeName = 'comunityChat';
  const Chat_medify_comunity({super.key});

  @override
  State<Chat_medify_comunity> createState() => _Chat_medify_comunityState();
}

class _Chat_medify_comunityState extends State<Chat_medify_comunity> {
  final TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();
  bool init = true;

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  @override
  void afterFirstLayout(BuildContext context) async {
    print("afterFirstLayout");
    await Future.delayed(Duration(milliseconds: init ? 100 : 100));

    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: init ? 100 : 100),
      curve: Curves.fastOutSlowIn,
    );
  }

  final socketService = Get.put(SocketService());
  List<dynamic> mensajes = [];

  void submitMessage(String message) {
    if (messageController.text.trim().isEmpty) {
      // floadMessage();
      return;
    }

    final String urlPhotoServer = ConfigGlobal.serverUrlBackEndApp +
        '/uploads/fotos/' +
        pref.photo_profile;

    socketService.socket!.emit('client:send:message',
        {"mensaje": message, "nombre": pref.name, "foto": urlPhotoServer});
  }

  @override
  void initState() {
    Map<String, String> userData = {
      "userId": pref.my_id,
      "FirebaseToken": PreferenciasUsuario().firebase_token,
      "nombre": pref.name
    };

    socketService.socket!.connect();
    socketService.socket!.emit('client:iniEmit:conection', userData);
    socketService.socket!.on('server:refresh:mensajes', (data) {
      mensajes = data;

      if (mounted) {
        print(mensajes);

        afterFirstLayout(Get.context!);

        init = false;

        setState(() {});
      }
    });

    // socketService.socket!.on('server:refresh:tu vaina', (data) {});
  }

  @override
  void dispose() {
    super.dispose();

    socketService.socket!.disconnect();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(37, 104, 135, 0.498),
        appBar: AppBar(
            toolbarHeight: 80,
            backgroundColor: Color.fromARGB(255, 23, 83, 113),
            title: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Image.asset(
                      'assets/icono_medify.png',
                      width: 35,
                    ),
                  ),
                ),
                Text('Comunidad')
              ],
            ),
            actions: [
              IconButton(onPressed: () {}, icon: Icon(Icons.search)),
              IconButton(onPressed: () {}, icon: Icon(Icons.settings))
            ],
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(Icons.arrow_back_ios_new_outlined))),
        body: Stack(
          children: [
            Opacity(
                opacity: .3,
                child: Image.asset(
                  "assets/back.jpeg",
                  height: MediaQuery.of(context).size.height,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                )),
            Column(children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(10),
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: mensajes.length,
                  itemBuilder: (context, index) {
                    if (mensajes[index]['userId'] != pref.my_id) {
                      return MessagePersonGroup(
                          imagen: mensajes[index]['foto'],
                          message: Text(mensajes[index]['mensaje']),
                          hora: Text(
                            mensajes[index]['hora'] ?? '',
                            style: TextStyle(fontSize: 11),
                          ));
                    }
                    return MyMessage(
                      message: Text(mensajes[index]['mensaje']),
                      hora: Text(
                        mensajes[index]['hora'],
                        textAlign: TextAlign.end,
                        style: TextStyle(fontSize: 11),
                      ),
                    );
                  },
                ),
              )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Container(
                  height: 60,
                  child: TextFormField(
                      onFieldSubmitted: (value) {
                        submitMessage(messageController.text);
                        messageController.clear();
                      },
                      controller: messageController,
                      scrollPadding: EdgeInsets.all(1),
                      decoration: InputDecoration(
                          fillColor: Color.fromRGBO(0, 0, 0, .4),
                          hintText: 'Escribe un mensaje...',
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none),
                          filled: true,
                          prefixIcon: IconButton(
                            icon: Icon(
                              Icons.add,
                              size: 40,
                              color: Colors.blue,
                            ),
                            onPressed: () {},
                          ),
                          suffix: IconButton(
                            icon: Icon(
                              Ionicons.paper_plane_outline,
                              size: 30,
                            ),
                            onPressed: () {
                              submitMessage(messageController.text);
                              messageController.clear();
                            },
                          ))),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
