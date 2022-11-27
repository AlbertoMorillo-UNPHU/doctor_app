// import 'package:doctor_app/models/cita.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// import '../../controller/doctor_controller.dart';
// import '../../models/cita.dart';
// import '../../repository/doctor_repository.dart';
// import '../../widget/alert_widget.dart';
// import '../../widget/text_field_widget.dart';

// class AddCitaPage extends StatefulWidget {
//   final User? userFire;
//   const AddCitaPage({Key? key, required this.userFire}) : super(key: key);

//   @override
//   State<AddCitaPage> createState() => _AddCitaPageState();
// }

// class _AddCitaPageState extends State<AddCitaPage> {
//   GlobalKey<FormState> editFormKey = GlobalKey<FormState>();
//   TextEditingController pacienteIdController = TextEditingController();
//   TextEditingController doctorIdController = TextEditingController();
//   TextEditingController cita1Controller = TextEditingController();
//   CitaController citaController = CitaController(DoctorRepository());

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.grey[500],
//         title: const Text('Creando cita'),
//       ),
//       body: Form(
//         key: editFormKey,
//         child: Padding(
//           padding: const EdgeInsets.all(30.0),
//           child: Column(
//             children: [
//               TextFieldWidget(
//                 controller: pacienteIdController,
//                 hintText: 'Especialidad',
//                 labelText: 'Especialidad',
//                 isDense: true,
//                 inputBorder: const OutlineInputBorder(),
//                 requiredText: 'Especialidad es requerido',
//               ),
//               const SizedBox(
//                 height: 20.0,
//               ),
//               TextFieldWidget(
//                 controller: doctorIdController,
//                 hintText: 'Nombre',
//                 labelText: 'Nombre',
//                 isDense: true,
//                 inputBorder: const OutlineInputBorder(),
//                 requiredText: 'Nombre es requerido.',
//               ),
//               const SizedBox(
//                 height: 20.0,
//               ),
//               TextFieldWidget(
//                 controller: cita1Controller,
//                 hintText: 'Apellidos',
//                 labelText: 'Apellidos',
//                 isDense: true,
//                 inputBorder: const OutlineInputBorder(),
//                 requiredText: 'Apellidos es requerido',
//               ),
//               const SizedBox(
//                 height: 30.0,
//               ),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(
//                         vertical: 15.0, horizontal: 100.0),
//                     textStyle: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 15.0,
//                     )),
//                 onPressed: () async {
//                   if (editFormKey.currentState!.validate()) {
//                     Cita createdCita = await citaController.postCita(
//                         Cita(
//                             id: widget.userFire!.uid,
//                             pacienteId: pacienteIdController.text,
//                             doctorId: doctorIdController.text,
//                             cita1: apellidosController.text));
//                     if (createdCita.pacienteId!.isNegative) {
//                       showDialog(
//                           context: context,
//                           builder: (context) {
//                             return AlertWidget(
//                                 title: 'Cita creado con éxito',
//                                 content:
//                                     'La cita se ha creado exitosamente. Puede ir al menú principal y refrescar.',
//                                 actions: [
//                                   TextButton(
//                                     onPressed: () {
//                                       Navigator.of(context).pop();
//                                       editFormKey.currentState!.reset();
//                                       pacienteIdController.clear();
//                                       doctorIdController.clear();
//                                       cita1Controller.clear();
//                                     },
//                                     child: const Text('OK'),
//                                   ),
//                                 ]);
//                           });
//                     }
//                   }
//                 },
//                 child: const Text('Guardas cambios'),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
