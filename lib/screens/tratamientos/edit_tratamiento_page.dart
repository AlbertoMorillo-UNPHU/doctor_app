import 'package:doctor_app/widget/text_field_datetime_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../controller/tratamiento_controller.dart';
import '../../models/tratamiento.dart';
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
  TextEditingController pacienteIdController = TextEditingController();
  TextEditingController doctorIdController = TextEditingController();
  TextEditingController fechaFinController = TextEditingController();
  TextEditingController fechaInicioController = TextEditingController();
  TextEditingController tratamientoDescController = TextEditingController();
  TratamientoController tratamientoController =
      TratamientoController(TratamientoRepository());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pacienteIdController.text =
        widget.selectedTratamiento.pacienteId!.toString();
    doctorIdController.text = widget.selectedTratamiento.doctorId!.toString();
    fechaFinController.text = widget.selectedTratamiento.fechaFin!.toString();
    fechaInicioController.text =
        widget.selectedTratamiento.fechaInicio!.toString();
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
                TextFieldWidget(
                  controller: pacienteIdController,
                  hintText: 'Paciente',
                  labelText: 'Paciente',
                  isDense: true,
                  inputBorder: const OutlineInputBorder(),
                  requiredText: 'Seleccione un paciente.',
                ),
                const SizedBox(
                  height: 30.0,
                ),
                TextFieldWidget(
                  controller: doctorIdController,
                  hintText: 'Doctor',
                  labelText: 'Doctor',
                  isDense: true,
                  inputBorder: const OutlineInputBorder(),
                  requiredText: 'Seleccione un doctor.',
                ),
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
                      Tratamiento createdTratamiento =
                          await tratamientoController.postTratamiento(
                              Tratamiento(
                                  pacienteId: pacienteIdController.text as int,
                                  doctorId: doctorIdController.text as int,
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
                                        doctorIdController.clear();
                                        pacienteIdController.clear();
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
