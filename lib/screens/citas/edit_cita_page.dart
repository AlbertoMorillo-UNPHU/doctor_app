import 'package:doctor_app/screens/Citas/Cita_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../controller/cita_controller.dart';
import '../../models/Cita.dart';
import '../../models/doctor.dart';
import '../../models/paciente.dart';
import '../../repository/Cita_repository.dart';
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
  CitaController citaController = CitaController(CitaRepository());

    Future getPacientes() {
    Future<List<Paciente>> futurePacientes = citaController.getPaciente();
    futurePacientes.then((list) {
      setState(() => apiPacientes = list);
    });
    return futurePacientes;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPacientes();
    cita1Controller.text = widget.selectedCita.cita1!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Editando Cita: ${widget.selectedCita.doctorId} ${widget.selectedCita.pacienteId}'),
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
                      Cita createdCita = await citaController.putCita(Cita(
                          id: widget.selectedCita.id,
                          userId: widget.selectedCita.userId,
                          nacimiento: nacimientoController.text,
                          genero: genero,
                          tipoSangre: tipoSangreController.text,
                          nombre: nombreController.text,
                          apellidos: apellidosController.text));
                      if (createdCita.apellidos!.isNotEmpty) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertWidget(
                                  title: 'Cita modificado con éxito',
                                  content:
                                      'El Cita se ha modificado exitosamente. Puede ir al menú principal y refrescar.',
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
