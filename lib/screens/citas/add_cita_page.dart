import 'package:doctor_app/models/doctor.dart';
import 'package:doctor_app/models/paciente.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../controller/cita_controller.dart';
import '../../models/cita.dart';
import '../../repository/Cita_repository.dart';
import '../../widget/alert_widget.dart';
import '../../widget/radio_button_widget.dart';
import '../../widget/text_field_date_widget.dart';
import '../../widget/text_field_widget.dart';

class AddCitaPage extends StatefulWidget {
  final User? userFire;
  const AddCitaPage({Key? key, required this.userFire}) : super(key: key);

  @override
  State<AddCitaPage> createState() => _AddCitaPageState();
}

class _AddCitaPageState extends State<AddCitaPage> {
  GlobalKey<FormState> editFormKey = GlobalKey<FormState>();
  int? pacienteId;
  int? doctorId;
  TextEditingController cita1Controller = TextEditingController();
  List<Doctor> apiDoctores = [];
  List<Paciente> apiPacientes = [];
  CitaController citaController = CitaController(CitaRepository());

  @override
  void initState() {
    // TODO: implement initStated
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
        title: const Text('Creando Cita'),
      ),
      body: Form(
        key: editFormKey,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                DropdownButtonFormField<Paciente>(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.category_outlined),
                    ),
                    hint: const Text('Paciente'),
                    validator: (value) {
                      if (value == null) {
                        return "Debe seleccionar un paciente";
                      }
                      return null;
                    },
                    items: apiPacientes.map((pac) {
                      return DropdownMenuItem(
                        value: pac,
                        child: Text(pac.nombre!),
                      );
                    }).toList(),
                    onChanged: (value) => setState(() {
                          pacienteId = value!.id;
                        })),
                const SizedBox(
                  height: 20.0,
                ),
                DropdownButtonFormField<Doctor>(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.category_outlined),
                    ),
                    hint: const Text('Doctor'),
                    validator: (value) {
                      if (value == null) {
                        return "Debe seleccionar un doctor";
                      }
                      return null;
                    },
                    items: apiDoctores.map((doc) {
                      return DropdownMenuItem(
                        value: doc,
                        child: Text(doc.nombre!),
                      );
                    }).toList(),
                    onChanged: (value) => setState(() {
                          doctorId = value!.id;
                        })),
                const SizedBox(
                  height: 20.0,
                ),
                TextFieldWidget(
                  controller: cita1Controller,
                  hintText: 'Cita 1',
                  labelText: 'Cita 1',
                  isDense: true,
                  inputBorder: const OutlineInputBorder(),
                  requiredText: 'Cita 1',
                ),
                const SizedBox(
                  height: 20.0,
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
                      Cita createdCita = await citaController.postCita(Cita(
                        pacienteId: pacienteId!,
                        doctorId: pacienteId!,
                        cita1: cita1Controller.text,
                      ));
                      if (createdCita.cita1!.isNotEmpty) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertWidget(
                                  title: 'Cita creado con éxito',
                                  content:
                                      'El Cita se ha creado exitosamente. Puede ir al menú principal y refrescar.',
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        editFormKey.currentState!.reset();
                                        cita1Controller.clear();
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
      ),
    );
  }
}
