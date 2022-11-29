import 'dart:convert';
import 'package:http/http.dart' as http;

import '../abstract/abstract_paciente.dart';
import '../models/paciente.dart';
import 'global.dart';

String dataURL = "${Global.dataURL}Pacientes/";
String dataURLGet = "${Global.dataURL}Pacientes";

class PacienteRepository implements RepositoryPaciente {
  http.Client client = http.Client();
  @override
  Future<String> deletedPaciente(Paciente paciente) async {
    http.Response deleteResponse = await client.delete(
      Uri.parse('$dataURL${paciente.id}'),
    );

    if (deleteResponse.statusCode == 200) {
      return "Paciente eliminado exitosamente.";
    } else {
      throw "Error al eliminar al paciente";
    }
  }

  @override
  Future<Paciente> getPaciente(int id) async {
    Paciente parsedPaciente;
    print("URLAAAAAAAAA");
    print("$dataURL/Paciente/$id");
    http.Response pacienteResponse =
        await client.get(Uri.parse("$dataURLGet/Paciente/$id"));
    print(pacienteResponse.statusCode);
    if (pacienteResponse.statusCode == 200) {
      parsedPaciente = Paciente.fromJson(jsonDecode(pacienteResponse.body));
      return parsedPaciente;
    } else {
      throw "Error al cargar Pacientes del usuario";
    }
  }

  @override
  Future<List<Paciente>> getPacienteList(String userId) async {
    List<Paciente> parsedPaciente = [];
    http.Response pacienteResponse =
        await client.get(Uri.parse("$dataURL$userId"));

    if (pacienteResponse.statusCode == 200) {
      String jsonStringPaciente = pacienteResponse.body;
      parsedPaciente = List<Paciente>.from(
          json.decode(jsonStringPaciente).map((b) => Paciente.fromJson(b)));
      return parsedPaciente;
    } else {
      throw "Error al cargar Pacientees del usuario";
    }
  }

  @override
  Future<String> patchCompleted(Paciente paciente) {
    // TODO: implement patchCompleted
    throw UnimplementedError();
  }

  @override
  Future<Paciente> postPaciente(Paciente paciente) async {
    Paciente? pacienteCreado;

    http.Response postResponse = await client.post(Uri.parse(dataURL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(paciente.toJsonCustom()));

    if (postResponse.statusCode == 201) {
      pacienteCreado = Paciente.fromJson(jsonDecode(postResponse.body));
      return pacienteCreado;
    } else {
      throw "Error creando el paciente.";
    }
  }

  @override
  Future<Paciente> putCompleted(Paciente paciente) async {
    Paciente? pacienteCreado;
    print(
        "${paciente.id} ${paciente.apellidos} ${paciente.genero} ${paciente.nacimiento} ${paciente.nombre} ${paciente.tipoSangre} ${paciente.userId}");
    http.Response putResponse = await client.put(
        Uri.parse('$dataURL${paciente.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(paciente.toJson()));
    print(
        "Logger status code: ${putResponse.statusCode} con URL: $dataURL y json: ${jsonEncode(paciente.toJsonCustom())}");
    if (putResponse.statusCode == 201) {
      pacienteCreado = Paciente.fromJson(jsonDecode(putResponse.body));
      return pacienteCreado;
    } else {
      throw "Error modificando el paciente";
    }
  }
}
