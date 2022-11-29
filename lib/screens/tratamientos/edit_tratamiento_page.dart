import 'package:doctor_app/widget/text_field_datetime_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/doctor_controller.dart';
import '../../controller/paciente_controller.dart';
import '../../controller/tratamiento_controller.dart';
import '../../models/doctor.dart';
import '../../models/paciente.dart';
import '../../models/tratamiento.dart';
import '../../repository/doctor_repository.dart';
import '../../repository/paciente_repository.dart';
import '../../repository/tratamiento_repository.dart';
import '../../widget/alert_widget.dart';
import '../../widget/text_field_date_widget.dart';
import '../../widget/text_field_widget.dart';

class EditTratamientoPage extends StatefulWidget {
  final Tratamiento selectedTratamiento;
  final User? userFire;
  const EditTratamientoPage(
      {Key? key, required this.selectedTratamiento, this.userFire})
      : super(key: key);

  @override
  State<EditTratamientoPage> createState() => _EditTratamientoState();
}

class _EditTratamientoState extends State<EditTratamientoPage> {
  GlobalKey<FormState> editFormKey = GlobalKey<FormState>();
  TextEditingController fechaFinController = TextEditingController();
  TextEditingController fechaInicioController = TextEditingController();
  TextEditingController tratamientoDescController = TextEditingController();
  TratamientoController tratamientoController =
      TratamientoController(TratamientoRepository());
  int? pacienteId;
  int? doctorId;
  Doctor? doctorSelected;
  Paciente? pacienteSelected;

  PacienteController pacienteController =
      PacienteController(PacienteRepository());
  List<Paciente> apiPacientes = [];

  DoctorController doctorController = DoctorController(DoctorRepository());
  List<Doctor> apiDoctores = [];

  Future getPacientes() {
    Future<List<Paciente>> futurePacientes =
        pacienteController.fetchPacienteList(widget.userFire!.uid);
    futurePacientes.then((list) {
      setState(() {
        apiPacientes = list;
        pacienteSelected = apiPacientes.firstWhereOrNull(
            (element) => element.id == widget.selectedTratamiento.pacienteId);
      });
    });
    return futurePacientes;
  }

  Future getDoctores() {
    Future<List<Doctor>> futureDoctores =
        doctorController.fetchDoctorList(widget.userFire!.uid);
    futureDoctores.then((list) {
      setState(() {
        apiDoctores = list;
        doctorSelected = apiDoctores.firstWhereOrNull(
            (element) => element.id == widget.selectedTratamiento.doctorId);
      });
    });

    return futureDoctores;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDoctores();
    getPacientes();

    doctorId = widget.selectedTratamiento.doctorId!;
    pacienteId = widget.selectedTratamiento.pacienteId!;

    fechaInicioController.text =
        widget.selectedTratamiento.fechaInicio!.toString();
    fechaFinController.text = widget.selectedTratamiento.fechaFin!.toString();
    tratamientoDescController.text =
        widget.selectedTratamiento.tratamientoDesc!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Editando tratamiento de: ${widget.selectedTratamiento.pacienteId} del doctor ${widget.selectedTratamiento.doctorId}'),
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
                      prefixIcon: Icon(Icons.select_all),
                    ),
                    validator: (value) {
                      if (value == null) {
                        return "Debe seleccionar un paciente";
                      }
                      return null;
                    },
                    hint: const Text('Seleccione Paciente'),
                    value: pacienteSelected,
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
                          await tratamientoController.putTratamiento(
                              Tratamiento(
                                  id: widget.selectedTratamiento.id,
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
                                  title: 'Tratamiento modificado con éxito',
                                  content:
                                      'El tratamiento se ha modificado exitosamente. Puede ir al menú principal y refrescar.',
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
