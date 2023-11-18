import 'package:medify/Register/Providers/RegisrterController.dart';
// import 'package:medify/src/Provider/PreferenciasUsuario.dart';
import 'package:medify/src/utils/UI/widget/CustomTextForm/custom_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medify/src/utils/UI/widget/LoadImages/LoadProfile.dart';
import 'package:medify/src/utils/UI/widget/Select/models/select_item.dart';
import 'package:medify/src/utils/UI/widget/Select/select_widget.dart';

class RegisterPage1 extends StatefulWidget {
  const RegisterPage1({super.key});

  @override
  State<RegisterPage1> createState() => _RegisterPage1State();
}

class _RegisterPage1State extends State<RegisterPage1> {
  @override
  void dispose() {
    if (mounted) {
      super.dispose();
    }
  }

  Size? size;

  final registerProvider = Get.put(RegisterController());

  FocusNode nameFocus = FocusNode();
  FocusNode lastNameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode phoneFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
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
              key: registerProvider.formKeyPage1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 0),
                        child: LoadProfile(
                          file: registerProvider.Perfilfile,
                          label: "Foto de perfil",
                          onChanged: (PickedFile? file) {
                            registerProvider.Perfilfile = file;
                          },
                        ),
                      ),
                    ),
                  ),

                  CustomFormField(
                      focusNode: nameFocus,
                      validator: (val) {
                        if (!val!.isNotEmpty) return 'El nombre es requerido.';
                        return null;
                      },
                      hintext: "Tu nombre",
                      icon: const Icon(Icons.person),
                      lavelText: "Nombre",
                      textController: registerProvider.name,
                      onFieldSubmitted: (v) {
                        lastNameFocus.requestFocus();
                        return v;
                      }),

                  CustomFormField(
                      focusNode: lastNameFocus,
                      onFieldSubmitted: (v) {
                        emailFocus.requestFocus();
                        return;
                      },
                      validator: (val) {
                        if (!val!.isNotEmpty)
                          return 'El apellido es requerido.';
                        return null;
                      },
                      hintext: "Tu apellido",
                      icon: const Icon(Icons.person),
                      lavelText: "Apellido",
                      textController: registerProvider.last_name),

                  Padding(
                      // key: UniqueKey(),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 0),
                      child: Select(
                        icon: Icons.category_rounded,
                        onChangue: () {
                          if (this.mounted) setState(() {});
                        },
                        description: "Seleccione una opción",
                        label: "Tipo documento",
                        curretValue: registerProvider.type_document_id,
                        listValues: [
                          SelectItem(
                              value: "1", key: "CC - Cédula de ciudadanía."),
                          SelectItem(
                              value: "2", key: "CE - Cédula de extranjería."),
                        ],
                        width: size!.width,
                      )),
                  CustomFormField(
                      textInputType: TextInputType.number,
                      validator: (val) {
                        if (!val!.isNotEmpty)
                          return 'El numero del domucmento es requerido.';
                        return null;
                      },
                      hintext: "######",
                      icon: const Icon(Icons.person),
                      lavelText: "numero de documento",
                      textController: registerProvider.document_number,
                      onFieldSubmitted: (v) {
                        return v;
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
