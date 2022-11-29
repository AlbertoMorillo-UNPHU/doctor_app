import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../controller/tratamiento_controller.dart';
import '../../models/tratamiento.dart';
import '../../repository/tratamiento_repository.dart';
import '../../widget/info_widget.dart';
import '../../widget/tratamiento/tratamiento_actions_widget.dart';
import '../../widget/tratamiento/tratamiento_data_widget.dart';
import '../welcome_page.dart';
import 'add_tratamiento_page.dart';

class TratamientoPage extends StatefulWidget {
  final User userFire;

  const TratamientoPage({Key? key, required this.userFire}) : super(key: key);

  @override
  State<TratamientoPage> createState() => _TratamientoPageState();
}

class _TratamientoPageState extends State<TratamientoPage> {
  List<Tratamiento> apiTratamiento = [];
  TratamientoController tratamientoController =
      TratamientoController(TratamientoRepository());
  late Future<List<Tratamiento>> futureTratamiento;
  TextStyle titleStyle =
      const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0);

  TextStyle propStyle =
      const TextStyle(color: Colors.black, fontWeight: FontWeight.bold);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureTratamiento = tratamientoController.fetchTratamientoList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tratamientos'),
        backgroundColor: Colors.blue[500],
        centerTitle: true,
        leading: IconButton(
            onPressed: () => Navigator.pop(
                context,
                MaterialPageRoute(
                    builder: (context) => WelcomePage(
                          userFire: widget.userFire,
                        ))),
            icon: const Icon(Icons.arrow_back)),
        actions: [
          IconButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddTratamientoPage(
                            userFire: widget.userFire,
                          ))).then((value) => _refreshTratamiento()),
              icon: const Icon(Icons.add)),
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () => setState(() {
              _refreshTratamiento();
            }),
          )
        ],
      ),
      body: FutureBuilder<List<Tratamiento>>(
        future: futureTratamiento,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.done:
            default:
              if (snapshot.hasError) {
                final error = "${snapshot.error}";
                return InfoWidget(info: error, color: Colors.red);
              } else if (snapshot.data!.isNotEmpty) {
                List<Tratamiento> data = snapshot.data!;

                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.all(10),
                      color: Colors.blue[50],
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 10, top: 5, bottom: 5),
                        child: Row(
                          children: [
                            TratamientoDataWidget(
                              data: data,
                              titleStyle: titleStyle,
                              propStyle: propStyle,
                              position: index,
                            ),
                            TratamientoActionsWidget(
                              data: data,
                              tratamientoController: tratamientoController,
                              position: index,
                              userFire: widget.userFire,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const InfoWidget(
                    info: "No hay tratamientoes disponibles",
                    color: Colors.red);
              }
          }
        },
      ),
    );
  }

  _refreshTratamiento() {
    setState(() {
      futureTratamiento = tratamientoController.fetchTratamientoList();
    });
  }
}
