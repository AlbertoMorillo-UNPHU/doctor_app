import 'package:doctor_app/models/doctor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../controller/diagnostico_controller.dart';
import '../../models/diagnostico.dart';
import '../../repository/diagnostico_repository.dart';
import '../../widget/alert_widget.dart';
import '../../widget/radio_button_widget.dart';
import '../../widget/text_field_date_widget.dart';
import '../../widget/text_field_widget.dart';

class AddDiagnosticoPage extends StatefulWidget {
  final User? userFire;
  const AddDiagnosticoPage({Key? key, required this.userFire}) : super(key: key);

  @override
  State<AddDiagnosticoPage> createState() => _AddDiagnosticoPageState();
}

class _AddDiagnosticoPageState extends State<AddDiagnosticoPage> {
  GlobalKey<FormState> editFormKey = GlobalKey<FormState>();
  TextEditingController tipoSangreController = TextEditingController();
  TextEditingController nacimientoController = TextEditingController();
  TextEditingController nombreController = TextEditingController();
  TextEditingController apellidosController = TextEditingController();
  DiagnosticoController diagnosticoController =
      DiagnosticoController(DiagnosticoRepository());

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
        title: const Text('Creando Diagnostico'),
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
                // RadioButtonWidget(
                //   onChanged: (),
                //   labelText1: 'Hombre',
                //   labelText2: 'Mujer',
                // ),
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
                      Diagnostico createdDiagnostico =
                          await diagnosticoController.postDiagnostico(Diagnostico(
                              userId: widget.userFire!.uid,
                              nacimiento: nacimientoController.text,
                              genero: genero,
                              tipoSangre: tipoSangreController.text,
                              nombre: nombreController.text,
                              apellidos: apellidosController.text));
                      if (createdDiagnostico.apellidos!.isNotEmpty) {
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
