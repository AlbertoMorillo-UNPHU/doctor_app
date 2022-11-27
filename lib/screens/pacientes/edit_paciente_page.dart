import 'package:doctor_app/screens/pacientes/paciente_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../controller/paciente_controller.dart';
import '../../models/paciente.dart';
import '../../repository/paciente_repository.dart';
import '../../widget/alert_widget.dart';
import '../../widget/radio_button_widget.dart';
import '../../widget/text_field_date_widget.dart';
import '../../widget/text_field_widget.dart';

class EditPacientePage extends StatefulWidget {
  final Paciente selectedPaciente;
  final User? userFire;
  const EditPacientePage(
      {Key? key, required this.selectedPaciente, this.userFire})
      : super(key: key);

  @override
  State<EditPacientePage> createState() => _EditPacientePageState();
}

class _EditPacientePageState extends State<EditPacientePage> {
  GlobalKey<FormState> editFormKey = GlobalKey<FormState>();
  TextEditingController nacimientoController = TextEditingController();
  TextEditingController tipoSangreController = TextEditingController();
  TextEditingController nombreController = TextEditingController();
  TextEditingController apellidosController = TextEditingController();
  bool? genero;
  PacienteController pacienteController =
      PacienteController(PacienteRepository());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tipoSangreController.text = widget.selectedPaciente.tipoSangre!;
    nombreController.text = widget.selectedPaciente.nombre!;
    apellidosController.text = widget.selectedPaciente.apellidos!;
    nacimientoController.text = widget.selectedPaciente.nacimiento!;
    genero = widget.selectedPaciente.genero;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Editando paciente: ${widget.selectedPaciente.nombre} ${widget.selectedPaciente.apellidos}'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: editFormKey,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
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
                  generoSelected: genero,
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
                          await pacienteController.putPaciente(Paciente(
                              id: widget.selectedPaciente.id,
                              userId: widget.selectedPaciente.userId,
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
                                  title: 'Paciente modificado con éxito',
                                  content:
                                      'El paciente se ha modificado exitosamente. Puede ir al menú principal y refrescar.',
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) => PacientePage(
                                              userFire: widget.userFire!),
                                        ));
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
