import 'package:flutter/material.dart';


class Dieta extends StatefulWidget {
  const Dieta({super.key});
  static String routeNmae= 'dietas';

  @override
  State<Dieta> createState() => DietaState();
}

class DietaState extends State<Dieta> {
  List<Map<String, dynamic>> comidas =[
    {'tipe': 'desayuno',"img":"str","nombre":"leche,arepa"},
    {'tipe': 'almuerzo',"img":"str",'nombre':"Pechuha de pollo, Arroz, aji"},
    {'tipe': 'cena',"img":"str",'nombre':"Pechuha de pollo, gaseosa, "},
    
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(actions: [const CircleAvatar(),Padding(
      padding: const EdgeInsets.only(left: 10),
      child: InkWell(onTap: () {},child:const CircleAvatar()),
    ),IconButton(onPressed: (){}, icon:const Icon(Icons.reorder))],),
    body: Center(child: Column(
        children: [const Text('Dietas'),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(20)),
                    width: 300,
                    height: 200,
                    child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [const Column(),
                      RotatedBox(quarterTurns: 15,child: IconButton(onPressed: (){},
                       icon: Icon(Icons.arrow_back_ios,size: 30,)))]),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(20)),
                    width: 300,
                    height: 200,
                    child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [const Column(),
                      RotatedBox(quarterTurns: 15,child: IconButton(onPressed: (){},
                       icon: Icon(Icons.arrow_back_ios,size: 30,)))]),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(20)),
                    width: 300,
                    height: 200,
                    child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [const Column(),
                      RotatedBox(quarterTurns: 15,child: IconButton(onPressed: (){},
                       icon:const Icon(  Icons.arrow_back_ios,size: 30,)))]),),
                  ),

    
    
    ])),
    );
  }
}