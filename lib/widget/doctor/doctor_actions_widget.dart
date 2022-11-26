import 'package:doctor_app/controller/doctor_controller.dart';
import 'package:doctor_app/screens/doctors/edit_doctor_page.dart';
import 'package:flutter/material.dart';

import '../../models/doctor.dart';
import '../alert_widget.dart';

class DoctorActionsWidget extends StatelessWidget {
  final List<Doctor> data;
  final DoctorController doctorController;
  final int position;

  const DoctorActionsWidget({
    Key? key,
    required this.data,
    required this.doctorController,
    required this.position,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  EditDoctorPage(selectedDoctor: data[position]),
            )),
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
                          String result = await doctorController
                              .deleteDoctor(data[position]);
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
                                        onPressed: () => Navigator.pop(context),
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
}
