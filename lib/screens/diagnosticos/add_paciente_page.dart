import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../controller/paciente_controller.dart';
import '../../models/paciente.dart';
import '../../repository/paciente_repository.dart';
import '../../widget/alert_widget.dart';
import '../../widget/radio_button_widget.dart';
import '../../widget/text_field_date_widget.dart';
import '../../widget/text_field_widget.dart';

class AddPacientePage extends StatefulWidget {
  final User? userFire;
  const AddPacientePage({Key? key, required this.userFire}) : super(key: key);

  @override
  State<AddPacientePage> createState() => _AddPacientePageState();
}

class _AddPacientePageState extends State<AddPacientePage> {
  GlobalKey<FormState> editFormKey = GlobalKey<FormState>();
  bool? genero = true;
  TextEditingController tipoSangreController = TextEditingController();
  TextEditingController nacimientoController = TextEditingController();
  TextEditingController nombreController = TextEditingController();
  TextEditingController apellidosController = TextEditingController();
  PacienteController pacienteController =
      PacienteController(PacienteRepository());

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
        title: const Text('Creando paciente'),
      ),
      body: Form(
        key: editFormKey,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFieldDateWidget(
                  controller: nacimientoController,
                  hintText: 'Nacimiento',
                  labelText: 'Nacimiento',
                  isDense: true,
                  inputBorder: const OutlineInputBorder(),
                  requiredText: 'Fecha Nacimiento es requerido',
                ),
                const SizedBox(
                  height: 20.0,
                ),
                RadioButtonWidget(
                  onChanged: (val) => genero = val,
                  labelText1: 'Hombre',
                  labelText2: 'Mujer',
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextFieldWidget(
                  controller: tipoSangreController,
                  hintText: 'Tipo de Sangre',
                  labelText: 'Tipo de Sangre',
                  isDense: true,
                  inputBorder: const OutlineInputBorder(),
                  requiredText: 'Tipo de Sangre es requerido',
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
                      Paciente createdPaciente =
                          await pacienteController.postPaciente(Paciente(
                              userId: widget.userFire!.uid,
                              nacimiento: nacimientoController.text,
                              genero: genero,
                              tipoSangre: tipoSangreController.text,
                              nombre: nombreController.text,
                              apellidos: apellidosController.text));
                      if (createdPaciente.apellidos!.isNotEmpty) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertWidget(
                                  title: 'Paciente creado con éxito',
                                  content:
                                      'El paciente se ha creado exitosamente. Puede ir al menú principal y refrescar.',
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        editFormKey.currentState!.reset();
                                        nombreController.clear();
                                        nacimientoController.clear();
                                        tipoSangreController.clear();
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
      ),
    );
  }
}
