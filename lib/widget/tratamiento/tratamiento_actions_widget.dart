import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../controller/tratamiento_controller.dart';
import '../../models/tratamiento.dart';
import '../../screens/tratamientos/edit_tratamiento_page.dart';
import '../../screens/tratamientos/tratamiento_page.dart';
import '../alert_widget.dart';

class TratamientoActionsWidget extends StatefulWidget {
  final List<Tratamiento> data;
  final TratamientoController tratamientoController;
  final int position;
  final User? userFire;
  const TratamientoActionsWidget(
      {Key? key,
      required this.data,
      required this.tratamientoController,
      required this.position,
      this.userFire})
      : super(key: key);

  @override
  State<TratamientoActionsWidget> createState() =>
      _TratamientoActionsWidgetState();
}

class _TratamientoActionsWidgetState extends State<TratamientoActionsWidget> {
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
                    builder: (context) => EditTratamientoPage(
                        selectedTratamiento: widget.data[widget.position],
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
                    title: 'Esta seguro de borrar este tratamiento?',
                    content: '',
                    actions: [
                      TextButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          String result = await widget.tratamientoController
                              .deleteTratamiento(widget.data[widget.position]);
                          if (result.isNotEmpty) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertWidget(
                                    title: 'Tratamiento eliminado con éxito.',
                                    content:
                                        'El tratamiento se eliminó satisfactoriamente.',
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) =>
                                                TratamientoPage(
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
      widget.tratamientoController.fetchTratamientoList(widget.userFire!.uid);
    });
  }
}
