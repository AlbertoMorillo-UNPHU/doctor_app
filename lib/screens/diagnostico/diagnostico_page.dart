// import 'package:doctor_app/controller/doctor_controller.dart';
// import 'package:doctor_app/models/cita.dart';
// import 'package:doctor_app/repository/doctor_repository.dart';
// import 'package:doctor_app/screens/welcome_page.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// import '../../controller/citas_controller.dart';
// import '../../controller/citas_controller.dart';
// import '../../models/doctor.dart';
// import '../../widget/doctor/doctor_actions_widget.dart';
// import '../../widget/doctor/doctor_data_widget.dart';
// import '../../widget/info_widget.dart';
// import 'add_cita_page.dart';

// class CitaPage extends StatefulWidget {
//   final User userFire;
//   const CitaPage({Key? key, required this.userFire}) : super(key: key);

//   @override
//   State<CitaPage> createState() => _CitaPageState();
// }

// class _CitaPageState extends State<CitaPage> {
//   List<Cita> apiCita = [];
//   CitaController CitaController = CitaController(CitaRepository());
//   late Future<List<Cita>> futureCita;
//   TextStyle titleStyle =
//       const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0);

//   TextStyle propStyle =
//       const TextStyle(color: Colors.black, fontWeight: FontWeight.bold);

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     futureCita = CitaController.fetchCitaList(widget.userFire.uid);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Doctores'),
//         backgroundColor: Colors.blue[500],
//         centerTitle: true,
//         leading: IconButton(
//             onPressed: () => Navigator.pop(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => WelcomePage(
//                           userFire: widget.userFire,
//                         ))),
//             icon: const Icon(Icons.arrow_back)),
//         actions: [
//           IconButton(
//               onPressed: () => Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => AddCitaPage(
//                             userFire: widget.userFire,
//                           ))).then((value) => _refreshDoctor()),
//               icon: const Icon(Icons.add)),
//           IconButton(
//             icon: const Icon(Icons.refresh_rounded),
//             onPressed: () => setState(() {
//               _refreshDoctor();
//             }),
//           )
//         ],
//       ),
//       body: FutureBuilder<List<Cita>>(
//         future: futureCita,
//         builder: (context, snapshot) {
//           switch (snapshot.connectionState) {
//             case ConnectionState.waiting:
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             case ConnectionState.done:
//             default:
//               if (snapshot.hasError) {
//                 final error = "${snapshot.error}";
//                 return InfoWidget(info: error, color: Colors.red);
//               } else if (snapshot.data!.isNotEmpty) {
//                 List<Doctor> data = snapshot.data!;

//                 return ListView.builder(
//                   itemCount: data.length,
//                   itemBuilder: (context, index) {
//                     return Card(
//                       margin: const EdgeInsets.all(10),
//                       color: Colors.blue[50],
//                       child: Padding(
//                         padding:
//                             const EdgeInsets.only(left: 10, top: 5, bottom: 5),
//                         child: Row(
//                           children: [
//                             DoctorDataWidget(
//                               data: data,
//                               titleStyle: titleStyle,
//                               propStyle: propStyle,
//                               position: index,
//                             ),
//                             CitaActionsWidget(
//                               data: data,
//                               CitaController: CitaController,
//                               position: index,
//                               userFire: widget.userFire,
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               } else {
//                 return const InfoWidget(
//                     info: "No hay citas disponibles", color: Colors.red);
//               }
//           }
//         },
//       ),
//     );
//   }

//   _refreshDoctor() {
//     setState(() {
//       futureCita = CitaController.fetchCitaList(widget.userFire.uid);
//     });
//   }
// }
