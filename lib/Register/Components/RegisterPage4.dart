import 'package:medify/Register/Models/TiposDocumentos.dart';
import 'package:medify/Register/Providers/GetData.dart';
import 'package:medify/Register/Providers/RegisrterController.dart';
import 'package:medify/src/utils/UI/widget/CustomTextForm/custom_form_field.dart';
import 'package:medify/src/utils/UI/widget/Select/models/select_item.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:url_launcher/url_launcher.dart';



class RegisterPage4 extends StatefulWidget {
  const RegisterPage4({super.key});

  @override
  State<RegisterPage4> createState() => _RegisterPage4State();
}

class _RegisterPage4State extends State<RegisterPage4> {
  Size? size;
  final TiposDocumentos? typosDocuments = null;

  List<SelectItem> listTypeDocuments = [];
  FocusNode password = FocusNode();
  FocusNode passwordConfirm = FocusNode();
  FocusNode emailFocus = FocusNode();

  GetData getData = GetData();

  @override
  void dispose() {
    if (mounted) {
      super.dispose();
    }
  }

  final registerProvider = Get.put(RegisterController());

  @override
  void initState() {
    super.initState();
    // getInitData();
  }

  @override
  Widget build(BuildContext context) {
    // print(registerProvider.Perfilfile.toString());
    size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
            color: const Color.fromRGBO(0, 0, 0, 0),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Form(
              key: registerProvider.formKeyPage4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: Text(
                      "Crea una contraseña segura para finalizar.",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  CustomFormField(
                      onFieldSubmitted: (v) {
                        return;
                      },
                      focusNode: emailFocus,
                      validator: (val) {
                        if (!val!.isEmail) return 'Email no valido';
                        return null;
                      },
                      hintext: "tu-correo@gmail.com",
                      icon: Icon(Icons.alternate_email_outlined),
                      lavelText: "Correo",
                      textController: registerProvider.email,
                      textInputType: TextInputType.emailAddress),
                  CustomFormField(
                    focusNode: password,
                    icon: const Icon(Icons.lock_outline_rounded),
                    textController: registerProvider.password,
                    lavelText: "Contraseña",
                    hintext: "********",
                    validator: (val) {
                      if (!val!.isNotEmpty) return 'Contraseña no valida';
                      if (val.length <= 7) {
                        return "Minimo 8 caracteres.";
                      }
                      return null;
                    },
                    obscureText: true,
                    onFieldSubmitted: (v) {
                      passwordConfirm.requestFocus();
                      return;
                    },
                  ),
                  CustomFormField(
                    focusNode: passwordConfirm,
                    icon: const Icon(Icons.lock_outline_rounded),
                    textController: registerProvider.password_confirmation,
                    lavelText: "Confirmar contraseña",
                    hintext: "********",
                    validator: (val) {
                      if (!val!.isNotEmpty) return 'Contraseña no valida';
                      if (registerProvider.password_confirmation.text !=
                          registerProvider.password.text) {
                        return "Las contraseñas no coinciden. ";
                      }
                      return null;
                    },
                    obscureText: true,
                    onFieldSubmitted: (v) {
                      registerProvider.submit();
                      return;
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          child: const Text(
                            "Aceptar terminos y condiciones",
                          ),
                          onPressed: () async{
                          _launchInBrowser('https://andr3sr0driguez.github.io/Politica_privacidad/pp.html');
                          }),
                      Checkbox(
                          value: registerProvider.terminos_y_condicicones,
                          onChanged: (bool? v) {
                            registerProvider.terminos_y_condicicones =
                                v ?? false;
                            if (mounted) {
                              setState(() {});
                            }
                          }),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


 Future<void> _launchInBrowser(String url) async {
  if (!await launch(url)) {
    throw 'No se pudo lanzar $url';
  }
}

}
