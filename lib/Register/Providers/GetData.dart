import 'package:medify/Register/Models/Departamento.dart';
import 'package:medify/Register/Models/Municipios.dart';
import 'package:medify/Register/Models/Professions.dart';
import 'package:medify/Register/Models/TiposDocumentos.dart';
import 'package:medify/config/config_global.dart';
import 'package:medify/src/Provider/PeticionesHttpProvider.dart';
import 'package:medify/src/utils/UI/widget/global_widgets.dart';
import 'package:flutter/material.dart';

class GetData {

  PeticionesHttpProvider http = PeticionesHttpProvider();

  final String _departament_host = "api/v1/departments";
  final String _municipio_host = "api/v1/cities";
  final String _professions_host = "api/v1/professions";
  final String _medicamento_host = "api/v1/medicamento";

  Future<TiposDocumentos?> getTypeDocuments(BuildContext context) async {

    Map<String,dynamic> data = await http.getMethod(context: context, table: _medicamento_host );

    print(data['resp']);
    if(data["message"] == 'true'){

      TiposDocumentos departamentos = tiposDocumentosFromJson(data['resp']);
      
      return departamentos;

    }else{

      alerta(context, code:false,contenido: "Error del servidor");
      return null;
      
    }


  }

  Future<Departamento?> getDepartamentos(BuildContext context) async {

    Map<String,dynamic> data = await http.getMethod(context: context, table: _departament_host );

    print(data['resp']);
    if(data["message"] == 'true'){

      Departamento departamentos = departamentoFromJson(data['resp']);
      return departamentos;

    }else{
      alerta(context, code:false,contenido: "Error del servidor");
      return null;
    }


    // return [];
  }
  Future<Map<String, dynamic>> getMedicamento(BuildContext context) async {
    Map<String,dynamic> data = await http.getMethod(context: context, table: _medicamento_host ,token:pref.token );

    print(data['data']);
    
    if(data["message"] == 'true'){


      return data;

    }else{
      alerta(context, code:false,contenido: "Error del servidor");
      return {};
    }


    // return [];
  }

  Future<Professions?> getProfession(BuildContext context) async {

    print("PROFESSIONES");

    Map<String,dynamic> data = await http.getMethod(context: context, table: _professions_host );

    print(data['resp']);
    if(data["message"] == 'true'){

      Professions departamentos = professionsFromJson(data['resp']);

      return departamentos;

    }else{

      alerta(context, code:false,contenido: "Error del servidor");
      return null;

    }


  }

  Future<Municipios?>  getMunicipiosById(BuildContext context, String id) async {

    Map<String,dynamic> data = await http.getMethod(context: context, table: _municipio_host+"/"+id );
     
    if(data["message"] == 'true'){

      Municipios departamentos = municipiosFromJson(data['resp']);
      return departamentos;

    }else{
     
      alerta( context, code:false, contenido: "Error del servidor" );
      return null;
      
    }
    
  }







}