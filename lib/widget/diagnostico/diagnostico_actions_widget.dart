import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../controller/diagnostico_controller.dart';
import '../../models/diagnostico.dart';
import '../../screens/diagnosticos/edit_diagnostico_page.dart';
import '../../screens/diagnosticos/diagnostico_page.dart';
import '../alert_widget.dart';

class DiagnosticoActionsWidget extends StatefulWidget {
  final List<Diagnostico> data;
  final DiagnosticoController diagnosticoController;
  final int position;
  final User? userFire;
  const DiagnosticoActionsWidget(
      {Key? key,
      required this.data,
      required this.diagnosticoController,
      required this.position,
      this.userFire})
      : super(key: key);

  @override
  State<DiagnosticoActionsWidget> createState() => _DiagnosticoActionsWidgetState();
}

class _DiagnosticoActionsWidgetState extends State<DiagnosticoActionsWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                    builder: (context) => EditDiagnosticoPage(
                        selectedDiagnostico: widget.data[widget.position],
                        userFire: widget.userFire!),
                  ))
                  .then((value) => _refreshPage());
            },
            child: const Icon(Icons.edit),
          ),
          TextButton(
            onPressed: () => showDialog(
                context: context,
                builder: (context) {
                  return AlertWidget(
                    title: 'Esta seguro de borrar este Diagnostico?',
                    content: '',
                    actions: [
                      TextButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          String result = await widget.diagnosticoController
                              .deleteDiagnostico(widget.data[widget.position]);
                          if (result.isNotEmpty) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertWidget(
                                    title: 'Diagnostico eliminado con éxito.',
                                    content:
                                        'El Diagnostico se eliminó satisfactoriamente.',
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) => DiagnosticoPage(
                                                userFire: widget.userFire!),
                                          ));
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  );
                                });
                          }
                        },
                        child: const Text('YES'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('CANCEL'),
                      ),
                    ],
                  );
                }),
            child: Icon(Icons.delete, color: Colors.blue.shade500),
          ),
        ],
      ),
    );
  }

  _refreshPage() {
    setState(() {
      widget.diagnosticoController.fetchDiagnosticoList(widget.userFire!.uid);
    });
  }
}
