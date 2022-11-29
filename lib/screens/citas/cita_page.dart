import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../controller/cita_controller.dart';
import '../../models/cita.dart';
import '../../repository/cita_repository.dart';
import '../../widget/alert_widget.dart';
import '../../widget/delete_bg_item.dart';
import '../../widget/info_widget.dart';
import '../../widget/cita/cita_actions_widget.dart';
import '../../widget/cita/cita_data_widget.dart';
import '../welcome_page.dart';
import 'add_cita_page.dart';

class CitaPage extends StatefulWidget {
  final User userFire;
  const CitaPage({Key? key, required this.userFire}) : super(key: key);

  @override
  State<CitaPage> createState() => _CitaPageState();
}

class _CitaPageState extends State<CitaPage> {
  List<Cita> apiCita = [];
  CitaController citaController = CitaController(CitaRepository());
  late Future<List<Cita>> futureCita;
  TextStyle titleStyle =
      const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0);

  TextStyle propStyle =
      const TextStyle(color: Colors.black, fontWeight: FontWeight.bold);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureCita = citaController.fetchCitaList(widget.userFire.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Citas'),
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
                      builder: (context) => AddCitaPage(
                            userFire: widget.userFire,
                          ))).then((value) => _refreshCita()),
              icon: const Icon(Icons.add)),
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () => setState(() {
              _refreshCita();
            }),
          )
        ],
      ),
      body: FutureBuilder<List<Cita>>(
        future: futureCita,
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
                List<Cita> data = snapshot.data!;

                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: Key(data[index].id.toString()),
                      onDismissed: (direction) {
                        _showSnackBar(context, data[index], index);
                        _removeEntity(data[index]);
                      },
                      background: const DeleteBgItem(),
                      child: Card(
                        margin: const EdgeInsets.all(10),
                        color: Colors.blue[50],
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10, top: 5, bottom: 5),
                          child: Row(
                            children: [
                              CitaDataWidget(
                                data: data,
                                titleStyle: titleStyle,
                                propStyle: propStyle,
                                position: index,
                              ),
                              CitaActionsWidget(
                                data: data,
                                citaController: citaController,
                                position: index,
                                userFire: widget.userFire,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const InfoWidget(
                    info: "No hay Citas disponibles", color: Colors.red);
              }
          }
        },
      ),
    );
  }

  _refreshCita() {
    setState(() {
      futureCita = citaController.fetchCitaList(widget.userFire.uid);
    });
  }

  void _showSnackBar(BuildContext context, Cita data, int index) {
    SnackBar snackBar = SnackBar(
        content: Text(
            "Eliminaste cita de ${data.paciente!.nombre} ${data.paciente!.apellidos}"));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> _removeEntity(Cita cita) async {
    String result = await citaController.deleteCita(cita);
    if (result.isNotEmpty) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertWidget(
              title: 'Cita eliminado con éxito.',
              content: 'El cita se eliminó satisfactoriamente.',
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          CitaPage(userFire: widget.userFire!),
                    ));
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          });
    }
  }
}
