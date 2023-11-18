import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/config/config.dart';
import 'package:medify/chat/comunity_medify.dart';
import 'package:medify/config/config_global.dart';
import 'package:medify/src/Provider/PeticionesHttpProvider.dart';
import 'package:medify/src/utils/UI/widget/ButtomCustom/boton_home.dart';
import 'package:medify/view/dieta_view.dart';
import 'package:medify/view/event-day_view.dart';
import 'package:medify/view/login_view.dart';
import 'package:medify/view/medicament_view.dart';
import 'package:medify/view/perfil_view.dart';
import 'package:medify/view/sueno_view.dart';
import 'package:table_calendar/table_calendar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  static String routeName = 'home';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    initState(){
      if(!pref.islogin){
        Navigator.pushReplacementNamed(context, LoginView.routeName);
      }
    }
    // ,dynamic>> eventos= [{'repeticiones': 5,'horaInicial':30,'nombre':'acetaminofen','fechaIni': '','fechaFin':'' }];
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
            leading: Container(),
            leadingWidth: 0,
            backgroundColor: Colors.black,
            centerTitle: false,
            title: Text('Bienvenido ${pref.name}'),
            actions: [
              InkWell(
                
                  radius: 10,
                  onTap: () {
                    Navigator.pushNamed(
                        context, Chat_medify_comunity.routeName);
                  },
                  borderRadius: BorderRadius.circular(20),
                  child:const Image(image: AssetImage('assets/chat_1041916.png'),width: 40 ,)),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: InkWell(
                    radius: 10,
                    onTap: () {
                      Navigator.pushNamed(context, Perfil.routeName);
                    },
                    borderRadius: BorderRadius.circular(20),
                    child:  CircleAvatar(backgroundImage: NetworkImage('${ConfigGlobal.serverUrlBackEndApp}/uploads/fotos/${pref.photo_profile}'))),
              ),
              IconButton(onPressed: () {}, icon: const Icon(Icons.reorder))
            ]),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(children: [
              TableCalendar(
                headerStyle: const HeaderStyle(titleCentered: true),
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: DateTime.now(),
                availableCalendarFormats:const {CalendarFormat.month: 'Month'},
                calendarStyle:const CalendarStyle(
                    outsideDaysVisible: false), // Añade esta línea
                onDaySelected: (
                  selectedDay,
                  focusedDay,
                ) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              EventDayView(fechaSeleccionada: selectedDay)));
                },
              ),
           
              BotonHome(
                Text: 'Medicamentos',
                imagen: 'assets/medicamentos.png',
                onpresed: () {
                  Navigator.pushNamed(context, Medicament.routeName);
                },
              ),
            
             
            ]),
          ),
        ),
      ),
    );
  }
}
