//import 'package:doctor_app/controller/paciente_controller.dart';
import 'package:doctor_app/controller/doctor_controller.dart';
import 'package:doctor_app/controller/paciente_controller.dart';
import 'package:doctor_app/screens/Citas/Cita_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../controller/cita_controller.dart';
import '../../models/cita.dart';
import '../../models/doctor.dart';
import '../../models/paciente.dart';
import '../../repository/cita_repository.dart';
//import '../../repository/paciente_repository.dart';
import '../../repository/doctor_repository.dart';
import '../../repository/paciente_repository.dart';
import '../../widget/alert_widget.dart';
import '../../widget/radio_button_widget.dart';
import '../../widget/text_field_date_widget.dart';
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
  TextEditingController cita1Controller = TextEditingController();
  List<Doctor> apiDoctores = [];
  List<Paciente> apiPacientes = [];
  Paciente citaPaciente = Paciente();
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
    // TODO: implement initState
    super.initState();
    getPacientes();
    getDoctores();
    cita1Controller.text = widget.selectedCita.cita1!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Editando Cita: ${widget.selectedCita.cita1}'),
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
                    hint: const Text('Paciente'),
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
                      Cita createdCita = await citaController.putCita(Cita(
                        id: widget.selectedCita.id,
                        pacienteId: pacienteId!,
                        doctorId: pacienteId!,
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
