import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medify/Register/Providers/GetData.dart';
import 'package:medify/src/Provider/PeticionesHttpProvider.dart';

import 'package:medify/src/utils/UI/widget/global_widgets.dart';
import 'package:medify/view/home_view.dart';

class Login {
  final String _username;
  final String _password;
  final BuildContext contex;
  final peticion = PeticionesHttpProvider();

  Login(this.contex, {required String username, required String password})
      : _username = username,
        _password = password;

  void auth(BuildContext? context) async {
    Map<String, String> credenciales = {
      'username': _username,
      'password': _password,
      'firebase_token' : pref.firebase_token,
    };


load(context!);
    Map<String, dynamic> resp = await peticion.postMethod(
        context: context, body: credenciales, table: 'api/v1/login');
   
  try{
    if (resp["data"]["success"]) {
      final user = resp["data"]["user"];
      pref.islogin = true;
      pref.my_id =  user["id"].toString();
      pref.photo_profile = user["photo_profile_url"];
      pref.name= user["nombre"];
   

      pref.token = resp['data']['data']['access_token'];
       

        GetData obtenerData = GetData();

        

         // ignore: use_build_context_synchronously
         final  respuesta = await obtenerData.getMedicamento(context);
             


         List<dynamic> listaDinamica = respuesta['data']; // Tu List<dynamic> existente
List<Map<String, dynamic>> listaDeMapas = List<Map<String, dynamic>>.from(listaDinamica);


     if(resp['data']['success']) floadMessage(titulo: 'Agregado correctamente',mensaje: 'exitoso');
         pref.medicamentos = listaDeMapas;


      navigatorToHome();
    }else{
       floadMessage(mensaje: resp["data"]["error"]);
       Get.back();
    }}catch(e){
      Get.back();
    }
  }

  void navigatorToHome() {
    Get.back();
    Navigator.pushReplacementNamed(contex, Home.routeName);
  }


}

