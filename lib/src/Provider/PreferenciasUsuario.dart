import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia = PreferenciasUsuario._internal();

  factory PreferenciasUsuario() => _instancia;

  PreferenciasUsuario._internal();

  late SharedPreferences _prefs;

  Future<void> initPrefs() async {
  _prefs = await SharedPreferences.getInstance();
  }

  String get storage_host_name => _prefs.getString('storage_host_name')??"";

  set storage_host_name(String value) {
    _prefs.setString('storage_host_name', value);
  }

  String get host_name => _prefs.getString('host_name')??"";

  set host_name(String value) {
    _prefs.setString('host_name', value);
  }

  String get sockt_host => _prefs.getString('sockt_host')??"";

  set sockt_host(String value) {
    _prefs.setString('sockt_host', value);
  }

  String get playstoreUrl => _prefs.getString('playstoreUrl')??"";

  set playstoreUrl(String value) {
    _prefs.setString('playstoreUrl', value);
  }

  String get appVersion => _prefs.getString('appVersion')??"";

  set appVersion(String value) {
    _prefs.setString('appVersion', value);
  }



String get por_subir => _prefs.getString('por_subir')??"";

set por_subir(String value) {
_prefs.setString('por_subir', value);
}


  List<Map<String, dynamic>> get medicamentos {

    List<String> medicamentosString = _prefs.getStringList('medicamentos') ?? [];


    return medicamentosString.map((medicamentoString) {
      var decoded = json.decode(medicamentoString);
      // Asegurarse de que el tipo de dato sea Map<String, dynamic>
      return decoded is Map<String, dynamic> ? decoded : <String, dynamic>{};
    }).toList();

  }

  // Guardar la lista de mapas
  set medicamentos(List<Map<String, dynamic>> value) {
    List<String> medicamentosString = value.map((medicamentoMap) => json.encode(medicamentoMap)).toList();
    print(medicamentosString);
    _prefs.setStringList('medicamentos', medicamentosString);
  }

  String get my_id => _prefs.getString('my_id')??"";

  set my_id(String value) {
    _prefs.setString('my_id', value);
  }

  String get name => _prefs.getString('name')??"";

  set name(String value) {
    _prefs.setString('name', value);
  }

  String get last_name => _prefs.getString('last_name')??"";

  set last_name(String value) {
    _prefs.setString('last_name', value);
  }

  String get email => _prefs.getString('email')??"";

  set email(String value) {
    _prefs.setString('email', value);
  }

  String get aux_email => _prefs.getString('aux_email')??"";

  set aux_email(String value) {
    _prefs.setString('aux_email', value);
  }

  String get document => _prefs.getString('document')??"";

  set document(String value) {
    _prefs.setString('document', value);
  }

  String get phone => _prefs.getString('phone')??"";

  set phone(String value) {
    _prefs.setString('phone', value);
  }

  String get phone_code => _prefs.getString('phone_code')??"";

  set phone_code(String value) {
    _prefs.setString('phone_code', value);
  }

  String get address => _prefs.getString('address')??"";

  set address(String value) {
    _prefs.setString('address', value);
  }

  String get photo_profile => _prefs.getString('photo_profile')??"";

  set photo_profile(String value) {
    _prefs.setString('photo_profile', value);
  }

  String get photo_card_one => _prefs.getString('photo_card_one')??"";

  set photo_card_one(String value) {
    _prefs.setString('photo_card_one', value);
  }

  String get photo_card_two => _prefs.getString('photo_card_two')??"";

  set photo_card_two(String value) {
    _prefs.setString('photo_card_two', value);
  }

  String get firebase_token => _prefs.getString('firebase_token')??"";

  set firebase_token(String value) {
    _prefs.setString('firebase_token', value);
  }
 
  String get type_blood => _prefs.getString('type_blood')??"";

  set type_blood(String value) {
    _prefs.setString('type_blood', value);
  }
  
  String get token => _prefs.getString('token')??"";

  set token(String value) {
    _prefs.setString('token', value);
  }
  
  String get refresh_token => _prefs.getString('refresh_token')??"";

  set refresh_token(String value) {
    _prefs.setString('refresh_token', value);
  }

  bool get islogin => _prefs.getBool('islogin')??false;

  set islogin(bool value) {
    _prefs.setBool('islogin', value);
  }

  String get current_role => _prefs.getString('current_role')??"";

  set current_role(String value) {
    _prefs.setString('current_role', value);
  }

  bool get complete_form_tenico => _prefs.getBool('complete_form_tenico')??false;

  set complete_form_tenico(bool value) {
    _prefs.setBool('complete_form_tenico', value);
  }
  
}