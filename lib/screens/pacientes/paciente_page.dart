import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../controller/paciente_controller.dart';
import '../../models/paciente.dart';
import '../../repository/paciente_repository.dart';
import '../../widget/alert_widget.dart';
import '../../widget/delete_bg_item.dart';
import '../../widget/info_widget.dart';
import '../../widget/paciente/paciente_actions_widget.dart';
import '../../widget/paciente/paciente_data_widget.dart';
import '../welcome_page.dart';
import 'add_paciente_page.dart';

class PacientePage extends StatefulWidget {
  final User userFire;
  const PacientePage({Key? key, required this.userFire}) : super(key: key);

  @override
  State<PacientePage> createState() => _PacientePageState();
}

class _PacientePageState extends State<PacientePage> {
  List<Paciente> apiPaciente = [];
  PacienteController pacienteController =
      PacienteController(PacienteRepository());
  late Future<List<Paciente>> futurePaciente;
  TextStyle titleStyle =
      const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0);

  TextStyle propStyle =
      const TextStyle(color: Colors.black, fontWeight: FontWeight.bold);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futurePaciente = pacienteController.fetchPacienteList(widget.userFire.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pacientes'),
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
                      builder: (context) => AddPacientePage(
                            userFire: widget.userFire,
                          ))).then((value) => _refreshPaciente()),
              icon: const Icon(Icons.add)),
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () => setState(() {
              _refreshPaciente();
            }),
          )
        ],
      ),
      body: FutureBuilder<List<Paciente>>(
        future: futurePaciente,
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
                List<Paciente> data = snapshot.data!;

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
                              PacienteDataWidget(
                                data: data,
                                titleStyle: titleStyle,
                                propStyle: propStyle,
                                position: index,
                              ),
                              PacienteActionsWidget(
                                data: data,
                                pacienteController: pacienteController,
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
                    info: "No hay pacientees disponibles", color: Colors.red);
              }
          }
        },
      ),
    );
  }

  _refreshPaciente() {
    setState(() {
      futurePaciente =
          pacienteController.fetchPacienteList(widget.userFire.uid);
    });
  }

  void _showSnackBar(BuildContext context, Paciente data, int index) {
    SnackBar snackBar = SnackBar(
        content:
            Text("Eliminaste paciente de ${data.nombre} ${data.apellidos}"));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> _removeEntity(Paciente paciente) async {
    String result = await pacienteController.deletePaciente(paciente);
    if (result.isNotEmpty) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertWidget(
              title: 'Paciente eliminado con éxito.',
              content: 'El paciente se eliminó satisfactoriamente.',
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          PacientePage(userFire: widget.userFire),
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
