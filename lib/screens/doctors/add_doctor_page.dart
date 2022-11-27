import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../controller/doctor_controller.dart';
import '../../models/doctor.dart';
import '../../repository/doctor_repository.dart';
import '../../widget/alert_widget.dart';
import '../../widget/text_field_widget.dart';

class AddDoctorPage extends StatefulWidget {
  final User? userFire;
  const AddDoctorPage({Key? key, required this.userFire}) : super(key: key);

  @override
  State<AddDoctorPage> createState() => _AddDoctorPageState();
}

class _AddDoctorPageState extends State<AddDoctorPage> {
  GlobalKey<FormState> editFormKey = GlobalKey<FormState>();
  TextEditingController especialidadController = TextEditingController();
  TextEditingController nombreController = TextEditingController();
  TextEditingController apellidosController = TextEditingController();
  DoctorController doctorController = DoctorController(DoctorRepository());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[500],
        title: const Text('Creando doctor'),
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
                    Doctor createdDoctor = await doctorController.postDoctor(
                        Doctor(
                            userId: widget.userFire!.uid,
                            espacialidad: especialidadController.text,
                            nombre: nombreController.text,
                            apellidos: apellidosController.text));
                    if (createdDoctor.espacialidad!.isNotEmpty) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertWidget(
                                title: 'Doctor creado con éxito',
                                content:
                                    'El doctor se ha creado exitosamente. Puede ir al menú principal y refrescar.',
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
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
