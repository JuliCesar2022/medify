import 'dart:convert';
import 'dart:io';
import 'package:medify/config/config_global.dart';
import 'package:medify/src/Provider/PreferenciasUsuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:medify/view/login_view.dart';

PreferenciasUsuario pref = PreferenciasUsuario();

class PeticionesHttpProvider {
  Future<Map<String, dynamic>> postMethod(
      {BuildContext? context, String? table, Map? body, String? token}) async {
    print("POST");
    print(body);
    Map<String, String> head;

    if (token != null) {
      head = {'Accept': 'application/json', 'Authorization': 'Bearer $token'};
    } else {
      head = {'Accept': 'application/json'};
    }

    try {
      String url = await ConfigGlobal.serverUrlBackEndApp + '/$table';
      print(url);
      dynamic resp = await http
          .post(Uri.parse(url), body: body, headers: head)
          .timeout(Duration(seconds: 20), onTimeout: () {
        throw {
          {
            "error":
                "Se acabo el tiempo de espera, verifica tu conexion a internet"
          }
        };
      });

      print(url);

      Map<String, dynamic> decodeResp = json.decode(resp.body);
      print(resp.body);
      if (resp.statusCode != 200) {
        //  print(resp.body);
        if (decodeResp['message'] == 'Unauthenticated.') {
          Map refreshTokenResp = await refreshToken();

          if (refreshTokenResp['message'] == "true") {
            print("[REPEAT METHOD]");
            return await postMethod(
                context: context, table: table, body: body, token: pref.token);
          }

          return {
            'message': "expiro",
            'data': decodeResp,
            'resp': resp,
            'statusCode': resp.statusCode,
          };
        } else {
          return {
            'message': "false",
            'errors': decodeResp['errors'],
            'data': decodeResp,
            'resp': resp.body,
            'statusCode': resp.statusCode
          };
        }
      } else {
        return {
          'message': "true",
          'data': decodeResp,
          'statusCode': resp.statusCode,
          'resp': resp.body,
        };
      }
    } catch (e) {
      print(e);
      // floadMessage(mensaje: "Error de red.");
      return {"error": "$e"};
    }
  }

  getMethod({BuildContext? context, String? table, String? token}) async {
    print("GET");
    Map<String, String> head;

    if (token != null) {
      head = {'Accept': 'application/json', 'Authorization': 'Bearer $token'};
    } else {
      head = {'Accept': 'application/json'};
    }

    try {
      String url = ConfigGlobal.serverUrlBackEndApp + '/$table';
      print(url);

      dynamic resp = await http.get(
        Uri.parse(url),
        headers: head,
      );

      print(pref.host_name.toString() + '/$table');
      Map<dynamic, dynamic> decodeResp = json.decode(resp.body);

      if (resp.statusCode != 200) {
        print(resp.body);
        // "message": "Unauthenticated."
        if (decodeResp['message'] == 'Unauthenticated.') {
          Map refreshTokenResp = await refreshToken();

          if (refreshTokenResp['message'] == "true") {
            print("[REPEAT METHOD]");
            return await getMethod(
                context: context, table: table, token: pref.token);
          }

          return {
            'message': "expiro",
            'data': decodeResp,
            'resp': resp,
            'statusCode': resp.statusCode,
          };
        }
        return {
          'message': "false",
          'data': decodeResp,
          'resp': resp,
          'statusCode': resp.statusCode,
        };
      } else {
        print(resp.body);
        return {
          'message': "true",
          'data': decodeResp['data'],
          'resp': resp.body,
          'statusCode': resp.statusCode,
        };
      }
    } catch (e) {
      // Navigator.pop(context);
      return {"error": "$e"};
    }
  }

  Future<Map> refreshToken() async {
    String lastRefresh = pref.refresh_token;

    Map resp = await postMethod(table: "api/v1/refresh", body: {
      "refresh_token": pref.refresh_token,
    });

    print("[REFRESH_TOKEN]");
    print(resp);

    if (resp['message'] == "true") {
      Map refreshTokenRespDecode = json.decode(resp['resp']);
      pref.token = refreshTokenRespDecode['access_token'];
      pref.refresh_token = refreshTokenRespDecode['refresh_token'];

      print("[SESSION RENOVADA]");
    } else {
      sleep(const Duration(seconds: 1));
      if (lastRefresh != pref.refresh_token) {
        print("[SESSION RENOVADA]");

        return {"message": "true"};
      }

      print("[ERROR -> SESSION RENOVADA]");
      Navigator.of(Get.context!).pushReplacementNamed(LoginView.routeName);
    }

    return resp;
  }
}
