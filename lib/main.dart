import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:medify/firebase_options.dart';
import 'package:medify/routes/routes_app.dart';
import 'package:medify/src/Provider/NotificationController.dart';
import 'package:medify/src/Provider/PeticionesHttpProvider.dart';
import 'package:medify/src/Provider/PreferenciasUsuario.dart';
import 'package:medify/view/home_view.dart';
import 'package:medify/view/login_view.dart';
import 'package:oktoast/oktoast.dart';

FirebaseMessaging messaging = FirebaseMessaging.instance;
NotificationController notificationController = NotificationController();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenciasUsuario().initPrefs();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    notificationController.foreground(message);
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    notificationController.opendApp(message);
  });

 const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');


  runApp(const Medify());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  notificationController.background(message);
}

getToken() async {
  String? token = await messaging.getToken();
  PreferenciasUsuario().firebase_token = token ?? "";
}

class FirebaseRemoteConfig {}

class Medify extends StatelessWidget {
  const Medify({super.key});

  @override
  Widget build(BuildContext context) {
    getToken();
    return OKToast(
      child: GetMaterialApp(
        theme: ThemeData(useMaterial3: true, brightness: Brightness.dark),
        routes: Routes.routes,
        initialRoute: pref.islogin ? Home.routeName : LoginView.routeName,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
