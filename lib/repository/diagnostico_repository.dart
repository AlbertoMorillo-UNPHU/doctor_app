// import 'dart:convert';

// import 'package:http/http.dart' as http;
// import '../abstract/abstract_citas.dart';
// import 'global.dart';

// String dataURL = "${Global.dataURL}Citas/";

// class CitaRepository implements RepositoryCitas {
//   http.Client client = http.Client();
//   @override
//   Future<String> deletedCita(Cita cita) async {
//     http.Response deleteResponse = await client.delete(
//       Uri.parse('$dataURL${cita.id}'),
//     );
//     print(
//         "Estatus code resp ${deleteResponse.statusCode} con user id: ${cita.id} en la url $dataURL${cita.id}");
//     if (deleteResponse.statusCode == 200) {
//       return "Cita eliminado exitosamente.";
//     } else {
//       throw "Error al eliminar la cita";
//     }
//   }

//   @override
//   Future<List<Cita>> getCitaList(String userId) async {
//     List<Cita> parsedCita = [];
//     http.Response citaResponse =
//         await client.get(Uri.parse("$dataURL$userId"));

//     if (citaResponse.statusCode == 200) {
//       String jsonStringCita = citaResponse.body;
//       parsedCita = List<Cita>.from(
//           json.decode(jsonStringCita).map((b) => Cita.fromJson(b)));
//       return parsedCita;
//     } else {
//       throw "Error al cargar citas del usuario";
//     }
//   }

//   @override
//   Future<Doctor> getDoctor(Cita cita){
//     // TODO: implement patchCompleted
//     throw UnimplementedError();
//   }

//   @override
//   Future<String> patchCompleted(Cita cita){
//     // TODO: implement patchCompleted
//     throw UnimplementedError();
//   }

//   @override
//   Future<Cita> postCita(Cita cita) async {
//     Doctor? doctorCreado;
//     Map citaData = {
//       'userId': cita.id,
//       'espacialidad': cita.pacienteId,
//       'nombre': cita.doctorId,
//       'apellidos': cita.cita1
//     };
//     http.Response postResponse = await client.post(Uri.parse(dataURL),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8'
//         },
//         body: jsonEncode(citaData));
//     if (postResponse.statusCode == 201) {
//       citaCreado = Cita.fromJsonCustom(jsonDecode(postResponse.body));
//       return citaCreado;
//     } else {
//       throw "Error creando la cita";
//     }
//   }

//   @override
//   Future<Cita> putCompleted(Cita cita) async {
//     Cita? citaCreado;
//     Map citaData = {
//       'id': cita.id,
//       'userId': cita.pacienteId,
//       'espacialidad': cita.doctorId,
//       'nombre': cita.cita1,

//     };

//     http.Response putResponse = await client.put(
//         Uri.parse('$dataURL${cita.id}'),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8'
//         },
//         body: jsonEncode(citaData));

//     if (putResponse.statusCode == 201) {
//       citaCreado = Cita.fromJson(jsonDecode(putResponse.body));
//       return citaCreado;
//     } else {
//       throw "Error modificando la cita";
//     }
//   }
// }