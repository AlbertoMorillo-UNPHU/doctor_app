import 'package:doctor_app/models/doctor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../controller/diagnostico_controller.dart';
import '../../controller/doctor_controller.dart';
import '../../controller/paciente_controller.dart';
import '../../models/diagnostico.dart';
import '../../models/paciente.dart';
import '../../repository/diagnostico_repository.dart';
import '../../repository/doctor_repository.dart';
import '../../repository/paciente_repository.dart';
import '../../widget/alert_widget.dart';
import '../../widget/text_field_widget.dart';

class AddDiagnosticoPage extends StatefulWidget {
  final User? userFire;
  const AddDiagnosticoPage({Key? key, required this.userFire})
      : super(key: key);

  @override
  State<AddDiagnosticoPage> createState() => _AddDiagnosticoPageState();
}

class _AddDiagnosticoPageState extends State<AddDiagnosticoPage> {
  GlobalKey<FormState> editFormKey = GlobalKey<FormState>();
  int? pacienteId;
  int? doctorId;
  Doctor? doctor;
  Paciente? paciente;
  DateTime? fechaDiagnostico;
  TextEditingController diagnosticoDescController = TextEditingController();
  DiagnosticoController diagnosticoController =
      DiagnosticoController(DiagnosticoRepository());

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
    // TODO: implement initState
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
        title: const Text('Creando Diagnostico'),
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
                        child: Text("${pac.nombre!} ${pac.apellidos}"),
                      );
                    }).toList(),
                    onChanged: (value) => setState(() {
                          paciente = value!;
                          pacienteId = value.id;
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
                        child: Text("${doc.nombre!} ${doc.apellidos}"),
                      );
                    }).toList(),
                    onChanged: (value) => setState(() {
                          doctor = value!;
                          doctorId = value.id;
                        })),
                const SizedBox(
                  height: 20.0,
                ),
                TextFieldWidget(
                  controller: diagnosticoDescController,
                  hintText: 'Diagnostico Desc',
                  labelText: 'Diagnostico Desc',
                  isDense: true,
                  inputBorder: const OutlineInputBorder(),
                  requiredText: 'Diagnostico Desc',
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
                      Diagnostico createdDiagnostico =
                          await diagnosticoController
                              .postDiagnostico(Diagnostico(
                                  pacienteId: pacienteId!,
                                  doctorId: doctorId!,
                                  fechaDiagnostico:
                                      DateFormat("yyyy-MM-ddThh:mm:ss")
                                          .format(DateTime.now()),
                                  diagnosticoDesc:
                                      diagnosticoDescController.text,
                                  paciente: paciente,
                                  doctor: doctor));
                      if (createdDiagnostico.diagnosticoDesc!.isNotEmpty) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertWidget(
                                  title: 'Diagnostico creado con éxito',
                                  content:
                                      'El Diagnostico se ha creado exitosamente. Puede ir al menú principal y refrescar.',
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
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
