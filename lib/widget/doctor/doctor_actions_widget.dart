import 'package:doctor_app/controller/doctor_controller.dart';
import 'package:doctor_app/screens/doctors/edit_doctor_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/doctor.dart';
import '../../screens/doctors/doctor_page.dart';
import '../alert_widget.dart';

class DoctorActionsWidget extends StatefulWidget {
  final List<Doctor> data;
  final DoctorController doctorController;
  final int position;
  final User? userFire;

  const DoctorActionsWidget(
      {Key? key,
      required this.data,
      required this.doctorController,
      required this.position,
      required this.userFire})
      : super(key: key);

  @override
  State<DoctorActionsWidget> createState() => _DoctorActionsWidgetState();
}

class _DoctorActionsWidgetState extends State<DoctorActionsWidget> {
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
                    builder: (context) => EditDoctorPage(
                        selectedDoctor: widget.data[widget.position],
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
                    title: 'Esta seguro de borrar este doctor?',
                    content: '',
                    actions: [
                      TextButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          String result = await widget.doctorController
                              .deleteDoctor(widget.data[widget.position]);
                          if (result.isNotEmpty) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertWidget(
                                    title: 'Doctor eliminado con éxito.',
                                    content:
                                        'El doctor se eliminó satisfactoriamente.',
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) => DoctorPage(
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
            child: Icon(Icons.delete, color: Colors.red[900]),
          ),
        ],
      ),
    );
  }

  _refreshPage() {
    setState(() {
      widget.doctorController.fetchDoctorList(widget.userFire!.uid);
    });
  }
}
