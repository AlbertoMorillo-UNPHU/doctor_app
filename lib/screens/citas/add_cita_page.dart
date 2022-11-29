import 'package:doctor_app/models/doctor.dart';
import 'package:doctor_app/models/paciente.dart';
import 'package:doctor_app/repository/cita_repository.dart';
import 'package:doctor_app/widget/text_field_datetime_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../controller/cita_controller.dart';
import '../../controller/doctor_controller.dart';
import '../../controller/paciente_controller.dart';
import '../../models/cita.dart';
import '../../repository/doctor_repository.dart';
import '../../repository/paciente_repository.dart';
import '../../widget/alert_widget.dart';
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
  CitaController citaController = CitaController(CitaRepository());
  PacienteController pacienteController =
      PacienteController(PacienteRepository());
  List<Paciente> apiPacientes = [];

  DoctorController doctorController = DoctorController(DoctorRepository());
  List<Doctor> apiDoctores = [];

  Future getPacientes() {
    Future<List<Paciente>> futurePacientes =
        pacienteController.fetchPacienteList(widget.userFire!.uid);
    futurePacientes.then((list) {
      setState(() => apiPacientes = list);
    });
    return futurePacientes;
  }

  Future getDoctores() {
    Future<List<Doctor>> futureDoctores =
        doctorController.fetchDoctorList(widget.userFire!.uid);
    futureDoctores.then((list) {
      setState(() => apiDoctores = list);
    });
    return futureDoctores;
  }

  @override
  void initState() {
    // TODO: implement initStated
    super.initState();
    getDoctores();
    getPacientes();
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
                      prefixIcon: Icon(Icons.select_all),
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
                        child: Text("${pac.nombre} ${pac.apellidos}"),
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
                      prefixIcon: Icon(Icons.select_all),
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
                        child: Text("${doc.nombre} ${doc.apellidos}"),
                      );
                    }).toList(),
                    onChanged: (value) => setState(() {
                          doctorId = value!.id;
                        })),
                const SizedBox(
                  height: 20.0,
                ),
                TextFieldDateTimeWidget(
                  controller: cita1Controller,
                  hintText: 'Fecha Cita',
                  labelText: 'Fecha Cita',
                  isDense: true,
                  inputBorder: const OutlineInputBorder(),
                  requiredText: 'Se requiere la fecha de la cita',
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
                      DateTime d1 = DateTime.parse(cita1Controller.text);
                      if (d1.compareTo(DateTime.now()) < 0) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertWidget(
                                title: "Ups! Anteción!",
                                content:
                                    "Fecha de la cita no puede ser menor a la fecha actual.",
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('OK'),
                                  ),
                                ]);
                          },
                        );
                      }
                      Cita createdCita = await citaController.postCita(Cita(
                        pacienteId: pacienteId!,
                        doctorId: doctorId!,
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
