import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../controller/cita_controller.dart';
import '../../models/cita.dart';
import '../../screens/citas/edit_Cita_page.dart';
import '../../screens/citas/cita_page.dart';
import '../alert_widget.dart';

class CitaActionsWidget extends StatefulWidget {
  final List<Cita> data;
  final CitaController citaController;
  final int position;
  final User? userFire;
  const CitaActionsWidget(
      {Key? key,
      required this.data,
      required this.citaController,
      required this.position,
      this.userFire})
      : super(key: key);

  @override
  State<CitaActionsWidget> createState() => _CitaActionsWidgetState();
}

class _CitaActionsWidgetState extends State<CitaActionsWidget> {
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
                    builder: (context) => EditCitaPage(
                        selectedCita: widget.data[widget.position],
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
                    title: 'Esta seguro de borrar este Cita?',
                    content: '',
                    actions: [
                      TextButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          String result = await widget.citaController
                              .deleteCita(widget.data[widget.position]);
                          if (result.isNotEmpty) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertWidget(
                                    title: 'Cita eliminado con éxito.',
                                    content:
                                        'El Cita se eliminó satisfactoriamente.',
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) => CitaPage(
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
      widget.citaController.fetchCitaList(widget.userFire!.uid);
    });
  }
}
