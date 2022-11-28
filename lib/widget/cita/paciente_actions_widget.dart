import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../controller/paciente_controller.dart';
import '../../models/paciente.dart';
import '../../screens/pacientes/edit_paciente_page.dart';
import '../../screens/pacientes/paciente_page.dart';
import '../alert_widget.dart';

class PacienteActionsWidget extends StatefulWidget {
  final List<Paciente> data;
  final PacienteController pacienteController;
  final int position;
  final User? userFire;
  const PacienteActionsWidget(
      {Key? key,
      required this.data,
      required this.pacienteController,
      required this.position,
      this.userFire})
      : super(key: key);

  @override
  State<PacienteActionsWidget> createState() => _PacienteActionsWidgetState();
}

class _PacienteActionsWidgetState extends State<PacienteActionsWidget> {
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
                    builder: (context) => EditPacientePage(
                        selectedPaciente: widget.data[widget.position],
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
                    title: 'Esta seguro de borrar este paciente?',
                    content: '',
                    actions: [
                      TextButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          String result = await widget.pacienteController
                              .deletePaciente(widget.data[widget.position]);
                          if (result.isNotEmpty) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertWidget(
                                    title: 'Paciente eliminado con éxito.',
                                    content:
                                        'El paciente se eliminó satisfactoriamente.',
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) => PacientePage(
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
      widget.pacienteController.fetchPacienteList(widget.userFire!.uid);
    });
  }
}
