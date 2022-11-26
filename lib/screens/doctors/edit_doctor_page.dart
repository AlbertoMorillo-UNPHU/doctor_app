import 'package:doctor_app/controller/doctor_controller.dart';
import 'package:doctor_app/repository/doctor_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/doctor.dart';
import '../../widget/alert_widget.dart';
import '../../widget/text_field_widget.dart';

class EditDoctorPage extends StatefulWidget {
  final Doctor selectedDoctor;
  const EditDoctorPage({Key? key, required this.selectedDoctor})
      : super(key: key);

  @override
  State<EditDoctorPage> createState() => _EditDoctorPageState();
}

class _EditDoctorPageState extends State<EditDoctorPage> {
  GlobalKey<FormState> editFormKey = GlobalKey<FormState>();
  TextEditingController especialidadController = TextEditingController();
  TextEditingController nombreController = TextEditingController();
  TextEditingController apellidosController = TextEditingController();
  DoctorController doctorController = DoctorController(DoctorRepository());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    especialidadController.text = widget.selectedDoctor.espacialidad!;
    nombreController.text = widget.selectedDoctor.nombre!;
    apellidosController.text = widget.selectedDoctor.apellidos!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Editando doctor: ${widget.selectedDoctor.nombre} ${widget.selectedDoctor.apellidos}'),
      ),
      body: Form(
        key: editFormKey,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              TextFieldWidget(
                controller: especialidadController,
                hintText: 'Especialidad',
                labelText: 'Especialidad',
                isDense: true,
                inputBorder: const OutlineInputBorder(),
                requiredText: 'Especialidad es requerido',
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextFieldWidget(
                controller: nombreController,
                hintText: 'Nombre',
                labelText: 'Nombre',
                isDense: true,
                inputBorder: const OutlineInputBorder(),
                requiredText: 'Nombre es requerido.',
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextFieldWidget(
                controller: apellidosController,
                hintText: 'Apellidos',
                labelText: 'Apellidos',
                isDense: true,
                inputBorder: const OutlineInputBorder(),
                requiredText: 'Apellidos es requerido',
              ),
              const SizedBox(
                height: 30.0,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 100.0),
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    )),
                onPressed: () async {
                  if (editFormKey.currentState!.validate()) {
                    Doctor updatedDoctor = await doctorController.putDoctor(
                        Doctor(
                            id: widget.selectedDoctor.id,
                            userId: widget.selectedDoctor.userId,
                            espacialidad: especialidadController.text,
                            nombre: nombreController.text,
                            apellidos: apellidosController.text));
                    if (updatedDoctor.espacialidad!.isNotEmpty) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertWidget(
                                title: 'Doctor actualizado con éxito',
                                content:
                                    'El doctor se ha modificado exitosamente. Puede ir al menú principal y refrescar.',
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      editFormKey.currentState!.reset();
                                      nombreController.clear();
                                      especialidadController.clear();
                                      apellidosController.clear();
                                    },
                                    child: const Text('OK'),
                                  ),
                                ]);
                          });
                    }
                  }
                },
                child: const Text('Guardas cambios'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
