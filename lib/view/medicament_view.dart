import 'package:flutter/material.dart';
import 'package:medify/src/utils/UI/widget/ButtomCustom/boton_home.dart';




class Medicament extends StatefulWidget {
  static String routeName = 'medicamentos';

  @override
  _MedicamentState createState() => _MedicamentState();
}

class _MedicamentState extends State<Medicament> {
  TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> items = [
    {'medicamento':'acetaminofen', 'tipo':'pastilla','id':'1'},
    {'medicamento':'baclofeno', 'tipo':'pastilla','id':'2'},
  ];

  List<Map<String, dynamic>> filteredItems = [];

  @override
  void initState() {
    super.initState();
    filteredItems = List.from(items);
  }

  void filterSearchResults(String query) {
    List<Map<String,dynamic>> searchList = items.where((item) {
      return item['medicamento'].toString().toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredItems = searchList;
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          actions: [InkWell(child: CircleAvatar(),onTap: (){},),IconButton(onPressed: (){}, icon: Icon(Icons.reorder),iconSize: 50,)],
          
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 50),
                child: Container(
                  height: 50,
                  child: TextFormField(
                    textAlignVertical: TextAlignVertical.bottom,
                  controller: _searchController,
                  decoration: InputDecoration(
                    enabled: true,
                    
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(40),borderSide: BorderSide.none),
                    filled: true,
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(40),borderSide: BorderSide.none,gapPadding: 10),
                    
                    suffix: Icon(Icons.search),
                    hintText: 'Buscar...',
                  ),
                  onChanged: (value) {
                    filterSearchResults(value);
                  },
                            ),
                ),
              ),
            
              Expanded(
                
                child: ListView.builder(
                 
            
                  itemCount: filteredItems.isEmpty? 1 : filteredItems.length ,
            
                  itemBuilder: (context, index) {
                     if(filteredItems.isEmpty){
                       return const ListTile(title: Center(child: Text('No hay medicamentos agregados')));
                     }
                    
                    return ListTile(
                      
                      title: BotonHome(padding: 1,  onpresed: (){print(filteredItems[index]['id']);},Text: filteredItems[index]['medicamento'],imagen: 'assets/logo_medify.png',),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton(onPressed: (){setState(() {
                 
                  
                });},child: Icon(Icons.add),backgroundColor: Colors.blue, shape: StadiumBorder(),),
              )
            ],
          ),
        ),
        
       
      ),
    );
  }
}
