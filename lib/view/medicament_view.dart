import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medify/src/Provider/PeticionesHttpProvider.dart';
import 'package:medify/src/utils/UI/widget/ButtomCustom/boton_home.dart';
import 'package:medify/view/form_medicaments.dart';
import 'package:medify/view/home_view.dart';

class Medicament extends StatefulWidget {
  static String routeName = 'medicamentos';

  const Medicament({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MedicamentState createState() => _MedicamentState();
}

class _MedicamentState extends State<Medicament> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> items = [];
  List<Map<String, dynamic>> filteredItems = [];

  @override
  void initState() {
    super.initState();
    // items = pref.medicamentos;

    // print(pref.medicamentos);

    items = pref.medicamentos;
    filteredItems = List.from(items);

    setState(() {
      
    });
  }

  void filterSearchResults(String query) {
    List<Map<String, dynamic>> searchList = items.where((item) {
      return item['medicamento']
          .toString()
          .toLowerCase()
          .contains(query.toLowerCase());
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
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pushNamed(context, Home.routeName);
              }),
          backgroundColor: Colors.black,
          actions: [
            InkWell(
              child: const CircleAvatar(),
              onTap: () {},
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.reorder),
              iconSize: 50,
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
                child: SizedBox(
                  height: 50,
                  child: TextFormField(
                    textAlignVertical: TextAlignVertical.bottom,
                    controller: _searchController,
                    decoration: InputDecoration(
                      enabled: true,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: BorderSide.none),
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: BorderSide.none,
                          gapPadding: 10),
                      suffix: const Icon(Icons.search),
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
                  itemCount: filteredItems.isEmpty ? 1 : filteredItems.length,
                  itemBuilder: (context, index) {
                  
                  

                    if (filteredItems.isEmpty) {
                      return const ListTile(
                          title: Center(
                              child: Text('No hay medicamentos agregados')));
                    }

                    return ListTile(
                      title: BotonHome(
                        padding: 1,
                        onpresed: () {
                          
                          // print(filteredItems[index]
                          //         ['id']
                          //     .toString());
                        },
                        Text: filteredItems[index]
                            ['medicamento'],
                    
                         imagen: 'assets/logo_medify.png',
                        
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.of(Get.context!)
                        .pushReplacementNamed(FormMedicament.routeName);
                  },
                  child: Icon(Icons.add),
                  backgroundColor: Colors.blue,
                  shape: StadiumBorder(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
