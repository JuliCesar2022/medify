import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medify/Register/RegisterPage.dart';
import 'package:medify/src/Provider/PeticionesHttpProvider.dart';
import 'package:medify/src/utils/UI/widget/CustomTextForm/custom_form_field.dart';
import 'package:medify/src/utils/helpers/login.dart';
import 'package:medify/widget/button_box.dart';

bool isCheckBox = false;

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  static String routeName = 'login';

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {




  TextEditingController correoController = TextEditingController();
  TextEditingController contrasenaController = TextEditingController();



  @override
  Widget build(BuildContext context) {

   
    return WillPopScope(
      onWillPop: () async{ 
        {
      // Coloca aquí tu lógica personalizada
      // Devuelve true si quieres que se ejecute la acción de retroceso por defecto
      // Devuelve false si quieres prevenir la acción de retroceso
      await SystemNavigator.pop();
      return false;
    }
       },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: bodyLogin(context),
      ),
    );
  }

  Widget bodyLogin(contexApp) {
    final size = MediaQuery.of(contexApp).size;

    return Container(
      color: Colors.black,
      child: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: loginColunm(size),
        ),
      )),
    );
  }

  Widget loginColunm(size) {
    final chekbox = Checkbox(
        value: isCheckBox,
        onChanged: (value) {
          setState(() {
            isCheckBox = value!;
            // Actualiza el estado cuando cambia el Checkbox
          });
        });

    final row = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const InkWell(
          child: Text(
            'Olvide mi contraseña',
            style: TextStyle(
                decoration: TextDecoration.underline, color: Colors.white),
          ),
        ),
        Row(
          children: [
            const Text(
              'Recordarme',
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
            chekbox
          ],
        )
      ],
    );

    return Column(
      children: [
        const SizedBox(
          height: 50,
        ),
        Image.asset(
          'assets/logo_medify.png',
          // height: size.height * 0.5,
          width: 200,
        ),
        const SizedBox(
          height: 80,
        ),
        CustomFormField(
            textController: correoController,
            hintext: 'Tu correo',
            lavelText: 'Correo',
            icon: const Icon( Icons.alternate_email_outlined)),
        CustomFormField(
          textController: contrasenaController,
          hintext: 'Tu contraseña',
          lavelText: 'Contraseña',
          icon: const Icon(Icons.password_outlined),
          obscureText: true,
        ),
        row,
        const SizedBox(
          height: 20,
        ),
        CustomButton(
          textButton: 'Iniciar sesion',
          onPressed: () {
            final Login login = Login(context,
                username: correoController.text,
                password: contrasenaController.text);

            login.auth(context);
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, Register.routeName);
            },
            child: const Text(
              'Registrarse',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
          ),
        )
      ],
    );
  }
}
