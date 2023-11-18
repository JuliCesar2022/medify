import 'package:flutter/material.dart';
import 'package:medify/Register/RegisterPage.dart';
import 'package:medify/chat/comunity_medify.dart';
import 'package:medify/view/dieta_view.dart';
import 'package:medify/view/form_medicaments.dart';
import 'package:medify/view/home_view.dart';
import 'package:medify/view/medicament_view.dart';
import 'package:medify/view/perfil_view.dart';
import 'package:medify/view/login_view.dart';
import 'package:medify/view/sueno_view.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> routes = {
    Register.routeName: (contex) => Register(),
    LoginView.routeName: (context) => const LoginView(),
    Home.routeName: (context) => const Home(),
    Medicament.routeName: (contex) => Medicament(),
    Dieta.routeNmae: (context) => const Dieta(),
    Sueno.routeName: (context) => Sueno(),
    Perfil.routeName: (context) => const Perfil(),
    Chat_medify_comunity.routeName: (context) => const Chat_medify_comunity(),
    FormMedicament.routeName: (context) => const FormMedicament()
  };
}
