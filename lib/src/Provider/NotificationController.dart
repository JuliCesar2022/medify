import 'dart:io';
import 'package:medify/src/utils/UI/widget/global_widgets.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

// import 'package:get/get.dart';
// AudioPlayer audioPlayer = AudioPlayer();

class NotificationController {

  background(RemoteMessage message) async {

    print("===| background |===");  
    print(message.notification!.title );
    print(message.notification!.body );

    // File file = File('Assets/audios/new.mp3');
    // print(file);

    //  await audioPlayer.play(UrlSource(file.path), volume: .5);
    floadMessage(titulo:message.notification!.title, mensaje: message.notification!.body,duration: Duration(milliseconds: (2000) + (message.notification!.body!.length * 50)) );
  
  }

  foreground(RemoteMessage message) async {
    
    print("====| foreground |===");
    // print(message.notification!.title );
    // print(message.notification!.body );

      print(message.data);
      // print(message.data['tipo']);
    // File file = File('Assets/audios/new.mp3');

    // print(file);
    //  await audioPlayer.play(UrlSource(file.path), volume: .5);

    
    floadMessage( mensaje: message.notification!.body,duration: Duration(milliseconds: (2000) + (message.notification!.body!.length * 50)), titulo:  message.notification!.title );
  
  }

  opendApp( RemoteMessage message){

    print("====| opendApp |===");
    print(message.notification!.title );
    print(message.notification!.body );

    // floadMessage(titulo:message.notification!.title, mensaje: message.notification!.body, duration: Duration(milliseconds: (2000) + (message.notification!.body!.length * 50)) );

  }

}