import 'package:doctor_app/controller/doctor_controller.dart';
import 'package:doctor_app/controller/paciente_controller.dart';
import 'package:doctor_app/models/doctor.dart';
import 'package:doctor_app/models/paciente.dart';
import 'package:doctor_app/repository/doctor_repository.dart';
import 'package:doctor_app/repository/paciente_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../controller/tratamiento_controller.dart';
import '../../models/tratamiento.dart';
import '../../repository/tratamiento_repository.dart';
import '../../widget/alert_widget.dart';
import '../../widget/text_field_date_widget.dart';
import '../../widget/text_field_datetime_widget.dart';
import '../../widget/text_field_widget.dart';

class AddTratamientoPage extends StatefulWidget {
  final User? userFire;
  const AddTratamientoPage({Key? key, this.userFire}) : super(key: key);

  @override
  State<AddTratamientoPage> createState() => _AddTratamientoPageState();
}

class _AddTratamientoPageState extends State<AddTratamientoPage> {
  GlobalKey<FormState> editFormKey = GlobalKey<FormState>();
  bool? genero = true;
  int? pacienteId;
  int? doctorId;
  TextEditingController fechaFinController = TextEditingController();
  TextEditingController fechaInicioController = TextEditingController();
  TextEditingController tratamientoDescController = TextEditingController();
  TratamientoController tratamientoController =
      TratamientoController(TratamientoRepository());

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
        title: const Text('Creando Tratamiento'),
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
                    hint: const Text('Seleccione Paciente'),
                    validator: (value) {
                      if (value == null) {
                        return "Debe seleccionar un doctor";
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
                  height: 30.0,
                ),
                DropdownButtonFormField<Doctor>(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.select_all),
                    ),
                    hint: const Text('Seleccione Doctor'),
                    validator: (value) {
                      if (value == null) {
                        return "Debe seleccionar un paciente";
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
                  height: 30.0,
                ),
                TextFieldDateTimeWidget(
                  controller: fechaInicioController,
                  hintText: 'Fecha inicio',
                  labelText: 'Fecha inicio',
                  isDense: true,
                  inputBorder: const OutlineInputBorder(),
                  requiredText: 'Fecha inicio es requerido',
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextFieldDateTimeWidget(
                  controller: fechaFinController,
                  hintText: 'Fecha fin',
                  labelText: 'Fecha fin',
                  isDense: true,
                  inputBorder: const OutlineInputBorder(),
                  requiredText: 'Fecha fin es requerido',
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextFieldWidget(
                  controller: tratamientoDescController,
                  hintText: 'Tratamiento Descripción',
                  labelText: 'Tratamiento',
                  isDense: true,
                  inputBorder: const OutlineInputBorder(),
                  requiredText: 'La descripcion del tratamiento es requerida.',
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
                      DateTime d1 = DateTime.parse(fechaInicioController.text);
                      DateTime d2 = DateTime.parse(fechaFinController.text);
                      if (d1.compareTo(d2) > 0) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertWidget(
                                title: "Ups! Anteción!",
                                content:
                                    "Fecha inicio no puede ser mayor a fecha fin.",
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
                      Tratamiento createdTratamiento =
                          await tratamientoController.postTratamiento(
                              Tratamiento(
                                  pacienteId: pacienteId,
                                  doctorId: doctorId,
                                  fechaInicio: fechaInicioController.text,
                                  fechaFin: fechaFinController.text,
                                  tratamientoDesc:
                                      tratamientoDescController.text));
                      if (createdTratamiento.tratamientoDesc!.isNotEmpty) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertWidget(
                                  title: 'Tratamiento creado con éxito',
                                  content:
                                      'El tratamiento se ha creado exitosamente. Puede ir al menú principal y refrescar.',
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        editFormKey.currentState!.reset();
                                        tratamientoDescController.clear();
                                        fechaInicioController.clear();
                                        fechaFinController.clear();
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
