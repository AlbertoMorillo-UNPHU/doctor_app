//import 'package:doctor_app/controller/paciente_controller.dart';
import 'package:doctor_app/controller/doctor_controller.dart';
import 'package:doctor_app/controller/paciente_controller.dart';
import 'package:doctor_app/screens/Citas/Cita_page.dart';
import 'package:doctor_app/widget/text_field_datetime_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/cita_controller.dart';
import '../../models/cita.dart';
import '../../models/doctor.dart';
import '../../models/paciente.dart';
import '../../repository/cita_repository.dart';
//import '../../repository/paciente_repository.dart';
import '../../repository/doctor_repository.dart';
import '../../repository/paciente_repository.dart';
import '../../widget/alert_widget.dart';
import '../../widget/text_field_widget.dart';

class EditCitaPage extends StatefulWidget {
  final Cita selectedCita;
  final User? userFire;
  const EditCitaPage({Key? key, required this.selectedCita, this.userFire})
      : super(key: key);

  @override
  State<EditCitaPage> createState() => _EditCitaPageState();
}

class _EditCitaPageState extends State<EditCitaPage> {
  GlobalKey<FormState> editFormKey = GlobalKey<FormState>();
  int? pacienteId;
  int? doctorId;
  Paciente? selectedPaciente;
  Doctor? selectedDoctor;
  TextEditingController cita1Controller = TextEditingController();
  List<Doctor> apiDoctores = [];
  List<Paciente> apiPacientes = [];
  //Doctor citaDoctor = Doctor();
  //campos de doctor son requeridos
  CitaController citaController = CitaController(CitaRepository());
  PacienteController pacienteController =
      PacienteController(PacienteRepository());
  DoctorController doctorController = DoctorController(DoctorRepository());

  Future getPacientes() {
    Future<List<Paciente>> futurePacientes =
        pacienteController.fetchPacienteList(widget.userFire!.uid);
    futurePacientes.then((list) {
      setState(() => apiPacientes = list);
      selectedPaciente = apiPacientes.firstWhereOrNull(
          (element) => element.id == widget.selectedCita.pacienteId);
    });
    return futurePacientes;
  }

  Future getDoctores() {
    Future<List<Doctor>> futureDoctores =
        doctorController.fetchDoctorList(widget.userFire!.uid);
    futureDoctores.then((list) {
      setState(() => apiDoctores = list);
      selectedDoctor = apiDoctores.firstWhereOrNull(
          (element) => element.id == widget.selectedCita.doctorId);
    });
    return futureDoctores;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPacientes();
    getDoctores();
    cita1Controller.text = widget.selectedCita.cita1!;
    pacienteId = widget.selectedCita.pacienteId;
    doctorId = widget.selectedCita.doctorId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editando Cita: ${widget.selectedCita.cita1}'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: editFormKey,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                DropdownButtonFormField<Paciente>(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.category_outlined),
                    ),
                    hint: const Text('Seleccione Paciente'),
                    validator: (value) {
                      if (value == null) {
                        return "Debe seleccionar un paciente";
                      }
                      return null;
                    },
                    value: selectedPaciente,
                    items: apiPacientes.map((pac) {
                      return DropdownMenuItem(
                        value: pac,
                        child: Text("${pac.nombre!} ${pac.apellidos}"),
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
                    hint: const Text('Seleccione Doctor'),
                    value: selectedDoctor,
                    validator: (value) {
                      if (value == null) {
                        return "Debe seleccionar un doctor";
                      }
                      return null;
                    },
                    items: apiDoctores.map((doc) {
                      return DropdownMenuItem(
                        value: doc,
                        child: Text("${doc.nombre!} ${doc.apellidos}"),
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
                  requiredText: 'Debe seleccionar la fecha de la cita.',
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
                      } else {
                        Cita createdCita = await citaController.putCita(Cita(
                          id: widget.selectedCita.id,
                          pacienteId: pacienteId!,
                          doctorId: doctorId!,
                          cita1: cita1Controller.text,
                        ));
                        if (createdCita.cita1!.isNotEmpty) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertWidget(
                                    title: 'Cita modificado con éxito',
                                    content:
                                        'La Cita se ha modificado exitosamente. Puede ir al menú principal y refrescar.',
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) => CitaPage(
                                                userFire: widget.userFire!),
                                          ));
                                          editFormKey.currentState!.reset();
                                          cita1Controller.clear();
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ]);
                              });
                        }
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
