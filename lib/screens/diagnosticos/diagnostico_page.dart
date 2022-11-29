import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../controller/diagnostico_controller.dart';
import '../../models/diagnostico.dart';
import '../../repository/diagnostico_repository.dart';
import '../../widget/info_widget.dart';
import '../../widget/diagnostico/diagnostico_actions_widget.dart';
import '../../widget/diagnostico/diagnostico_data_widget.dart';
import '../welcome_page.dart';
import 'add_diagnostico_page.dart';

class DiagnosticoPage extends StatefulWidget {
  final User userFire;
  const DiagnosticoPage({Key? key, required this.userFire}) : super(key: key);

  @override
  State<DiagnosticoPage> createState() => _DiagnosticoPageState();
}

class _DiagnosticoPageState extends State<DiagnosticoPage> {
  List<Diagnostico> apiDiagnostico = [];
  DiagnosticoController diagnosticoController =
      DiagnosticoController(DiagnosticoRepository());
  late Future<List<Diagnostico>> futureDiagnostico;
  TextStyle titleStyle =
      const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0);

  TextStyle propStyle =
      const TextStyle(color: Colors.black, fontWeight: FontWeight.bold);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureDiagnostico = diagnosticoController.fetchDiagnosticoList(widget.userFire.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diagnosticos'),
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
                      builder: (context) => AddDiagnosticoPage(
                            userFire: widget.userFire,
                          ))).then((value) => _refreshDiagnostico()),
              icon: const Icon(Icons.add)),
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () => setState(() {
              _refreshDiagnostico();
            }),
          )
        ],
      ),
      body: FutureBuilder<List<Diagnostico>>(
        future: futureDiagnostico,
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
                List<Diagnostico> data = snapshot.data!;

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
                            DiagnosticoDataWidget(
                              data: data,
                              titleStyle: titleStyle,
                              propStyle: propStyle,
                              position: index,
                            ),
                            DiagnosticoActionsWidget(
                              data: data,
                              diagnosticoController: diagnosticoController,
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
                    info: "No hay Diagnosticoes disponibles", color: Colors.red);
              }
          }
        },
      ),
    );
  }

  _refreshDiagnostico() {
    setState(() {
      futureDiagnostico =
          diagnosticoController.fetchDiagnosticoList(widget.userFire.uid);
    });
  }
}
