import 'package:doctor_app/screens/Diagnosticos/Diagnostico_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controller/diagnostico_controller.dart';
import '../../controller/doctor_controller.dart';
import '../../controller/paciente_controller.dart';
import '../../models/diagnostico.dart';
import '../../models/doctor.dart';
import '../../models/paciente.dart';
import '../../repository/diagnostico_repository.dart';
import '../../repository/doctor_repository.dart';
import '../../repository/paciente_repository.dart';
import '../../widget/alert_widget.dart';
import '../../widget/text_field_widget.dart';

class EditDiagnosticoPage extends StatefulWidget {
  final Diagnostico selectedDiagnostico;
  final User? userFire;
  const EditDiagnosticoPage(
      {Key? key, required this.selectedDiagnostico, this.userFire})
      : super(key: key);

  @override
  State<EditDiagnosticoPage> createState() => _EditDiagnosticoPageState();
}

class _EditDiagnosticoPageState extends State<EditDiagnosticoPage> {
  GlobalKey<FormState> editFormKey = GlobalKey<FormState>();
  int? pacienteId;
  int? doctorId;
  Doctor? doctorSelected;
  Paciente? pacienteSelected;
  DateTime? fechaDiagnostico;
  TextEditingController diagnosticoDescController = TextEditingController();
  List<Doctor> apiDoctores = [];
  List<Paciente> apiPacientes = [];
  //Doctor citaDoctor = Doctor();
  //campos de doctor son requeridos
  PacienteController pacienteController =
      PacienteController(PacienteRepository());
  DoctorController doctorController = DoctorController(DoctorRepository());
  DiagnosticoController diagnosticoController =
      DiagnosticoController(DiagnosticoRepository());

  Future getPacientes() {
    Future<List<Paciente>> futurePacientes =
        pacienteController.fetchPacienteList(widget.userFire!.uid);
    futurePacientes.then((list) {
      setState(() => apiPacientes = list);
      pacienteSelected = apiPacientes.firstWhereOrNull(
          (element) => element.id == widget.selectedDiagnostico.pacienteId);
    });
    return futurePacientes;
  }

  Future getDoctores() {
    Future<List<Doctor>> futureDoctores =
        doctorController.fetchDoctorList(widget.userFire!.uid);
    futureDoctores.then((list) {
      setState(() => apiDoctores = list);
      doctorSelected = apiDoctores.firstWhereOrNull(
          (element) => element.id == widget.selectedDiagnostico.doctorId);
    });
    return futureDoctores;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPacientes();
    getDoctores();
    diagnosticoDescController.text =
        widget.selectedDiagnostico.diagnosticoDesc!;
    doctorId = widget.selectedDiagnostico.doctorId!;
    pacienteId = widget.selectedDiagnostico.pacienteId!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Editando Diagnostico: ${widget.selectedDiagnostico.diagnosticoDesc}'),
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
                    value: pacienteSelected,
                    validator: (value) {
                      if (value == null) {
                        return "Debe seleccionar un paciente";
                      }
                      return null;
                    },
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
                    hint: const Text('Doctor'),
                    value: doctorSelected,
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
                TextFieldWidget(
                  controller: diagnosticoDescController,
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
                      Diagnostico createdDiagnostico =
                          await diagnosticoController.putDiagnostico(
                              Diagnostico(
                                  id: widget.selectedDiagnostico.id,
                                  pacienteId: pacienteId!,
                                  doctorId: doctorId!,
                                  fechaDiagnostico:
                                      DateFormat("yyyy-MM-ddThh:mm:ss")
                                          .format(DateTime.now()),
                                  diagnosticoDesc:
                                      diagnosticoDescController.text));
                      if (createdDiagnostico.diagnosticoDesc!.isNotEmpty) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertWidget(
                                  title: 'Diagnostico modificado con éxito',
                                  content:
                                      'El Diagnostico se ha modificado exitosamente. Puede ir al menú principal y refrescar.',
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) => DiagnosticoPage(
                                              userFire: widget.userFire!),
                                        ));
                                        editFormKey.currentState!.reset();
                                        diagnosticoDescController.clear();
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
