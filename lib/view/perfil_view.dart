import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medify/src/Provider/PeticionesHttpProvider.dart';
import 'package:medify/src/utils/UI/widget/ButtomCustom/buton_custom.dart';
import 'package:medify/src/utils/UI/widget/LoadImages/LoadProfile.dart';
import 'package:medify/src/utils/UI/widget/global_widgets.dart';
import 'package:medify/view/login_view.dart';
import 'dart:ui' as ui;


class Perfil extends StatefulWidget {
  
  const Perfil({super.key});
  
  static String routeName = 'perfil';

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {

 

  String _estado = 'Bien';
  String _frecuencia = 'Normal';
  String _latidos = 'Lento';
  PeticionesHttpProvider peticion = new PeticionesHttpProvider();
  final List<String> _estados = ['Bien', 'Mal'];
  final List<String> _frecuencias = ['Normal', 'Alta', 'Baja'];
  final List<String> _latidosList = ['Rápido', 'Lento', 'Irregular'];
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  List<String> symptoms = ['fatiga crónica', 'intestino irritable', 'Migrañas'];
  List<TextEditingController> _controllers = [];
  static PickedFile? photo; 
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold( backgroundColor: Colors.black,
        appBar: AppBar( backgroundColor: Colors.black,actions: [IconButton(onPressed: (){}, icon:Icon(Icons.reorder,size: 50,) )],),
      
      body: Column(children: [
          LoadProfile(
                            file: photo,
                            label: "Foto de perfil",
                            onChanged: (PickedFile? file) {
                              photo = file;
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(pref.name),
                          ),
    
      
         Column(   children: [
              SizedBox(height: 20,),
              BuutomCustom( color:Color.fromARGB(255, 58, 59, 60),
                     title: Container( alignment: Alignment.centerLeft ,
                     child: Text('Peso Y estatura', )),
                     width: 300,onpresed: () {
                        alertPesoStatura();
          
                    },), 
                    BuutomCustom(color:Color.fromARGB(255, 58, 59, 60),
                    title: Container(
                                 alignment: Alignment.centerLeft,
                                 child: Text('Informacion del corazon')),
                                 width: 300,onpresed: () {
                                    alertCorazon();
                                },),
                                
                    BuutomCustom(color:Color.fromARGB(255, 58, 59, 60),
                    title: Container(alignment: Alignment.centerLeft,
                    child: Text('Sintomas' )),
                    width: 300,
                    onpresed: () {
                      alertSintomas();
                    }
                    ),

        
        ], ),
        
       
           
      
      ],),
      floatingActionButton: BuutomCustom( onpresed: ()  async{

         load(context);
             pref.islogin = false;
             
         load(context);

            final   Map<String, dynamic>  resp = await peticion.postMethod(table: "api/v1/logout",token: pref.token);

  try{
    if (resp["data"]["success"]) {

            Navigator.pushReplacementNamed(context, LoginView.routeName);
    }

    }catch(e){

      floadMessage(titulo: 'No se pudo cerrar sesion');
      Get.back();
    }
            


            },color: Colors.blue,
            title: Text('Cerrar sesion',
            style: TextStyle(fontSize: 20)),) ,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    
      ),
    );
  }
   Widget _buildTextField(
      TextEditingController controller, String label, String unit) {
    return TextField(
      controller: controller,
      style: TextStyle(color: Colors.white), // Adjust text style to match your design
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white),
        suffixText: unit,
        suffixStyle: TextStyle(color: Colors.blue),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
      ),
      keyboardType: TextInputType.number,
    );
  }
  void alertPesoStatura() {
     showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent, // Hacer el fondo del Dialog transparente
          child: BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[900], // El color del contenido del diálogo
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Luis', style: TextStyle(color: Colors.white, fontSize: 24)),
                  SizedBox(height: 20),
                  _buildTextField(_weightController, 'Peso:', 'Kg'),
                  _buildTextField(_heightController, 'Estatura:', 'cm'),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue, // color del botón
                    ),
                    onPressed: () {
                      // Guardar datos o hacer algo con ellos
                      Navigator.of(context).pop();
                    },
                    child: Text('Guardar'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
     
  }
 Widget _buildDropdown(String title, List<String> options, String currentValue, ValueChanged<String?> onChanged) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: title,
        labelStyle: TextStyle(color: Colors.white70),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
      ),
      value: currentValue,
      style: TextStyle(color: Colors.white),
      dropdownColor: Colors.grey[800],
      items: options.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
  void alertCorazon() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _buildDropdown('Estado:', _estados, _estado, (newValue) {
                    setState(() {
                      _estado = newValue!;
                    });
                  }),
                  _buildDropdown('Frecuencia:', _frecuencias, _frecuencia, (newValue) {
                    setState(() {
                      _frecuencia = newValue!;
                    });
                  }),
                  _buildDropdown('Latidos:', _latidosList, _latidos, (newValue) {
                    setState(() {
                      _latidos = newValue!;
                    });
                  }),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.blue),
                    onPressed: () {
                      // Acciones al guardar
                      Navigator.of(context).pop();
                    },
                    child: Text('Guardar'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
   void _addNewSymptomField() {
     TextEditingController newController = TextEditingController();
    setState(() {
      _controllers.add(newController);
      symptoms.add('');
      
    });
  }

  void _saveData() {
    // Logic to save the data
    Navigator.of(context).pop();
  }
  void alertSintomas() {
     showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900], // Adjust the color to match the design
          title: Text(
            'síntomas',
            style: TextStyle(color: Colors.white),
          ),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _controllers.length,

              itemBuilder: (context, index) {

                return TextField(
                  controller: _controllers[index],
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                );
              },
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add, color: Colors.blue),
              onPressed: _addNewSymptomField,
            ),
            TextButton(
              child: Text('Guardar', style: TextStyle(color: Colors.blue)),
              onPressed: _saveData,
            ),
          ],
        );
      },
    );
  }
  }
