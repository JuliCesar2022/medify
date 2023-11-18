import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:medify/Register/Providers/GetData.dart';
import 'package:medify/src/Provider/PeticionesHttpProvider.dart';
import 'package:medify/src/utils/UI/widget/Select/models/select_item.dart';
import 'package:medify/src/utils/UI/widget/Select/select_widget.dart';
import 'package:medify/src/utils/UI/widget/global_widgets.dart';
import 'package:medify/view/medicament_view.dart';
import 'package:medify/widget/input_text_form.dart';
import 'package:intl/intl.dart';

class FormMedicament extends StatefulWidget {
  static String routeName = 'form_medicamentos';
  const FormMedicament({super.key});

  @override
  State<FormMedicament> createState() => _FormMedicamentState();
}

class _FormMedicamentState extends State<FormMedicament> {


  SelectItem medicamentosSelect = SelectItem(key: '', value: '');
  String horastrin = '';
  TimeOfDay hora = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: hora, // Hora inicial
    );

    setState(() {
      horastrin = '${selectedTime?.format(context)}';
    });
    if (selectedTime != null) {
      print('Hora seleccionada: ${selectedTime.format(context)}');
      // Puedes realizar acciones con la hora seleccionada aquí
    }
  }

  TextEditingController medicamentoController = TextEditingController();
  TextEditingController dosisoController = TextEditingController();
  TextEditingController frecuenciaController = TextEditingController();

  SelectItem type_medicaments = SelectItem(key: '', value: '');

  DateTime selectedDate = DateTime.now();
  DateTime selectedDateFin = DateTime.now();

  Future<void> _selectDate(BuildContext context, DateTime controller) async {
    final DateTime? pickedHoraInicio = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (pickedHoraInicio != null && pickedHoraInicio != selectedDate) {
      setState(() {
        selectedDate = pickedHoraInicio;
      });
    }
  }

  Future<void> _selectDateFin(BuildContext context, DateTime controller) async {
    final DateTime? pickedHoraFin = await showDatePicker(
      context: context,
      initialDate: selectedDateFin,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (pickedHoraFin != null && pickedHoraFin != selectedDate) {
      setState(() {
        selectedDateFin = pickedHoraFin;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final decorationInputSelect = BoxDecoration(
        color: const Color.fromARGB(255, 58, 59, 60),
        borderRadius: BorderRadius.circular(15));

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pushNamed(context, Medicament.routeName);
          },
        ),
        title: const Text('Nuevo medicamento'),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(children: [
            InputTextForm(
                placeholder: 'medicamentos',
                textController: medicamentoController),
            Padding(
                // key: UniqueKey(),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                child: Select(
                  icon: Icons.category_rounded,
                  onChangue: () {
                    if (mounted) setState(() {});
                  },
                  description: "Seleccione una opción",
                  label: "Tipo de medicamento",
                  curretValue: type_medicaments,
                  listValues: [
                    SelectItem(value: "pastilla", key: "Pastilla"),
                    SelectItem(value: "inyeccion", key: "Inyeccion"),
                  ],
                  width: size.width,
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: decorationInputSelect,
                child: Row(
                  children: [
                    const Text('Dosis'),
                    SizedBox(
                        width: 50,
                        child: TextFormField(
                          controller: dosisoController,
                        )),
                    MaterialButton(
                      onPressed: () {},
                      child: const Text('mg'),
                    ),
                    MaterialButton(
                      onPressed: () {},
                      child: const Text('mcg'),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: decorationInputSelect,
                child: Row(
                  children: [
                    const Text('Frecuencia'),
                    SizedBox(
                        width: 80,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                            controller: frecuenciaController,
                            decoration: InputDecoration(
                              filled: true,
                              hintText: '##',
                              counterText: '',
                            ),
                            keyboardType: TextInputType.numberWithOptions(),
                            maxLength: 2,
                              // maxLengthEnforcement: MaxLengthEnforcement.none,
                          ),
                        )),
                    MaterialButton(
        
                      color: Colors.blue,
                      onPressed: () {},
                      child: const Text('Horas'),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: decorationInputSelect,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: const Text('inicio de tratamiento'),
                    ),
                    MaterialButton(
                      color: Colors.blue,
                      shape: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      onPressed: () => _selectDate(context, selectedDate),
                      child: Text(DateFormat('yyyy-MM-dd').format(selectedDate)),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: decorationInputSelect,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 25),
                      child: const Text('Fin de tratamiento'),
                    ),
                    MaterialButton(
                      color: Colors.blue,
                      shape: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      onPressed: () => _selectDateFin(context, selectedDateFin),
                      child:
                          Text(DateFormat('yyyy-MM-dd').format(selectedDateFin)),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: decorationInputSelect,
                child: Row(
                  children: [
                    const Text('hora inicial'),
                    MaterialButton(
                      color: Colors.blue,
                      onPressed: (){_selectTime(context);},child: Text('${horastrin}'), )
                  
                  ],
                ),
              ),
            ),
            MaterialButton(
              color: Colors.blue,
              onPressed: () async {
                load(context);
                PeticionesHttpProvider peticion = PeticionesHttpProvider();
                String formattedDate =
                    DateFormat('yyyy-MM-dd').format(selectedDate);
                String formattedDateFin =
                    DateFormat('yyyy-MM-dd').format(selectedDateFin);
        
                Map<String, String> credenciales = {
                  'medicamento': medicamentoController.text,
                  'tipomedicaemnto': type_medicaments.value!,
                  'dosis': dosisoController.text,
                  'frecuencia': frecuenciaController.text,
                  'iniciotratamiento': formattedDate,
                  'fintratamiento': formattedDateFin,
                  'recordar': "1",
                  'horaInicial': horastrin,
                  'usuario_id': pref.my_id
                };
        
                Map<String, dynamic> resp = await peticion.postMethod(
                    context: context,
                    body: credenciales,
                    table: 'api/v1/medicamento',
                    token: pref.token);
        
                GetData obtenerData = GetData();
        
                // ignore: use_build_context_synchronously
                final respuesta = await obtenerData.getMedicamento(context);
        
                List<dynamic> listaDinamica =
                    respuesta['data']; // Tu List<dynamic> existente
                List<Map<String, dynamic>> listaDeMapas =
                    List<Map<String, dynamic>>.from(listaDinamica);
        
                if (resp['data']['success'])
                  floadMessage(
                      titulo: 'Agregado correctamente', mensaje: 'exitoso');
                pref.medicamentos = listaDeMapas;
        
                Get.back();
        
                // ignore: use_build_context_synchronously
                Navigator.pushNamed(context, Medicament.routeName);
              },
              child: const Text('Guardar'),
            )
          ]),
        ),
      )),
    );
  }
}
