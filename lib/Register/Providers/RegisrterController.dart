import 'dart:convert';
import 'package:medify/config/config_global.dart';
import 'package:medify/src/Models/ResponseVo.dart';
import 'package:medify/src/Models/Roles.dart';
import 'package:medify/src/Provider/PreferenciasUsuario.dart';
import 'package:medify/src/utils/UI/widget/Select/models/select_item.dart';
import 'package:medify/src/utils/UI/widget/global_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime_type/mime_type.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class RegisterController {
  PreferenciasUsuario pref = PreferenciasUsuario();
  PageController pageController = new PageController();
  int curentPage = 0;

  bool terminos_y_condicicones = false;

  GlobalKey<FormState> formKeyPage1 = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyPage4 = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController last_name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController document_number = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController password_confirmation = TextEditingController();
  TextEditingController code = TextEditingController();

  SelectItem type_document_id = SelectItem();
  // SelectItem? typeDocumentController =  SelectItem();
  // SelectItem? municipalyController =  SelectItem();

  //fotos
  DateTime selectedDate = DateTime.now();

  PickedFile? Perfilfile;
  PickedFile? fileDocument1;
  PickedFile? fileDocument2;
  // PickedFile? PensionDocument;

  Future<ResponseVo> sendFrom() async {
    var headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${pref.token}",
    };

    var request = http.MultipartRequest(
        'POST', Uri.parse(await ConfigGlobal.serverUrlBackEndApp + '/api/v1/user'));

    request.fields.addAll({
      'nombre': name.text.trim(),
      'apellido': last_name.text.trim(),
      'email': email.text.trim(),
      'type_document_id': type_document_id.value!.toString(),
      'number_document': document_number.text.trim(),
      'password': password.text,
      'code': code.text.trim(),
    });

    final profile_url_picture = mime(Perfilfile!.path)!.split('/');

    final profile = await http.MultipartFile.fromPath(
        'photo_profile_url', Perfilfile!.path,
        contentType: MediaType(profile_url_picture[0], profile_url_picture[1]));

    request.files.add(profile);

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    Get.back();
    print(response.statusCode);
    print(response.request);

    String resp = await response.stream.transform(utf8.decoder).join();

    if (response.statusCode == 200) {
      return ResponseVo(
          success: true,
          data: resp,
          message: "Ok",
          statusCode: response.statusCode);
    } else {
      return ResponseVo(
          success: false,
          data: resp,
          message: "Error",
          statusCode: response.statusCode);
    }

    // return {};
  }

  nextPage() {
    print(curentPage);
    if (curentPage == 2 || curentPage == 1) {
      submit();
      return;
    }
    pageController.nextPage(
        duration: Duration(milliseconds: 500), curve: Curves.easeInOutQuart);

    print(curentPage);
  }

  backPage() {
    pageController.previousPage(
        duration: Duration(milliseconds: 500), curve: Curves.easeInOutQuart);
  }

  _to(int page) {
    pageController.animateToPage(page,
        duration: Duration(milliseconds: 500), curve: Curves.easeInOutQuart);
  }

  bool validateForm(int page, BuildContext context) {
    print('$page Holaaaa este es el page');
    if (page == 2) {
      if (code.text.trim() == '') {
        floadMessage(
            titulo: "Error", mensaje: "Ingresa el codigo de verificacion");
        return false;
      }
    }

    if (page == 0) {
      if (type_document_id.value == null) {
        _to(page);
        floadMessage(
            titulo: "Error", mensaje: "El tipo de documento es requerido");
        return false;
      }

      if (Perfilfile == null &&
          (pref.photo_profile == "null" || pref.photo_profile == "")) {
        _to(page);
        floadMessage(
            titulo: "Error", mensaje: "La foto de perfil es necesaria");
        return false;
      }

      try {
        if (formKeyPage1.currentState!.validate() == false) {
          _to(page);
          floadMessage(
              titulo: "Error", mensaje: "Rellene el formulario correctamente.");
          return false;
        }
      } catch (e) {
        // _to(page);
        return false;
      }
    }

    if (page == 1) {
      try {
        if (!formKeyPage4.currentState!.validate()) {
          _to(page);

          floadMessage(
              titulo: "Error", mensaje: "Rellene el formulario correctamente.");
          return false;
        }

        if (!terminos_y_condicicones) {
          _to(page);

          floadMessage(
              titulo: "Error",
              mensaje:
                  "Debe aceptar los terminos y condiciones para continuar.");
          return false;
        }
      } catch (e) {}
    }

    return true;
  }

  submit() async {
    if (!validateForm(1, Get.context!)) {
      return;
    }
    load(Get.context!);

    try {
      ResponseVo response = await sendFrom();
      Map<dynamic, dynamic> decodeResp = json.decode(response.data);
      print(decodeResp);
      floadMessage(
          titulo: "Alerta", mensaje: "Success: " + response.success.toString());

      if (decodeResp["success"]) {
        floadMessage(mensaje: "Su solicitud se envio correctamente.");
        if (decodeResp["message"] != "code generado") {
          Get.back();
          Get.delete<RegisterController>();
          return;
        }
        _to(2);
      } else {
        return mensajeNegativo(Get.context!, respuesta: decodeResp);
      }
    } catch (e) {
      print(e.toString());
      floadMessage(titulo: "Error", mensaje: e.toString());
    }
  }
}
