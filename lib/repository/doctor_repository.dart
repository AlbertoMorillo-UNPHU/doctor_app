import 'dart:convert';

import 'package:doctor_app/models/doctor.dart';
import 'package:http/http.dart' as http;
import '../abstract/abstract_doctor.dart';
import 'global.dart';

String dataURL = "${Global.dataURL}Doctors/";

class DoctorRepository implements RepositoryDoctor {
  http.Client client = http.Client();
  @override
  Future<String> deletedDoctor(Doctor doctor) async {
    http.Response deleteResponse = await client.delete(
      Uri.parse('$dataURL${doctor.id}'),
    );
    print(
        "Estatus code resp ${deleteResponse.statusCode} con user id: ${doctor.userId} en la url $dataURL${doctor.id}");
    if (deleteResponse.statusCode == 200) {
      return "Doctor eliminado exitosamente.";
    } else {
      throw "Error al eliminar al doctor";
    }
  }

  @override
  Future<List<Doctor>> getDoctorList(String userId) async {
    List<Doctor> parsedDoctor = [];
    http.Response doctorResponse =
        await client.get(Uri.parse("$dataURL$userId"));

    if (doctorResponse.statusCode == 200) {
      String jsonStringDoctor = doctorResponse.body;
      parsedDoctor = List<Doctor>.from(
          json.decode(jsonStringDoctor).map((b) => Doctor.fromJson(b)));
      return parsedDoctor;
    } else {
      throw "Error al cargar doctores del usuario";
    }
  }

  @override
  Future<Doctor> getDoctor(Doctor doctor) {
    // TODO: implement patchCompleted
    throw UnimplementedError();
  }

  @override
  Future<String> patchCompleted(Doctor doctor) {
    // TODO: implement patchCompleted
    throw UnimplementedError();
  }

  @override
  Future<Doctor> postDoctor(Doctor doctor) async {
    Doctor? doctorCreado;
    Map doctorData = {
      'userId': doctor.userId,
      'espacialidad': doctor.espacialidad,
      'nombre': doctor.nombre,
      'apellidos': doctor.apellidos
    };
    http.Response postResponse = await client.post(Uri.parse(dataURL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(doctorData));
    if (postResponse.statusCode == 201) {
      doctorCreado = Doctor.fromJsonCustom(jsonDecode(postResponse.body));
      return doctorCreado;
    } else {
      throw "Error creando el doctor";
    }
  }

  @override
  Future<Doctor> putCompleted(Doctor doctor) async {
    Doctor? doctorCreado;
    Map doctorData = {
      'id': doctor.id,
      'userId': doctor.userId,
      'espacialidad': doctor.espacialidad,
      'nombre': doctor.nombre,
      'apellidos': doctor.apellidos
    };

    http.Response putResponse = await client.put(
        Uri.parse('$dataURL${doctor.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(doctorData));

    if (putResponse.statusCode == 201) {
      doctorCreado = Doctor.fromJson(jsonDecode(putResponse.body));
      return doctorCreado;
    } else {
      throw "Error modificando el doctor";
    }
  }
}
