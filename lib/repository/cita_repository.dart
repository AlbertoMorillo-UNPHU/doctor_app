import 'dart:convert';
import 'package:http/http.dart' as http;

import '../abstract/abstract_cita.dart';
import '../models/cita.dart';
import 'global.dart';

String dataURL = "${Global.dataURL}Citas/";
String dataURLCustom = "${Global.dataURL}Citas";

class CitaRepository implements RepositoryCita {
  http.Client client = http.Client();
  @override
  Future<String> deletedCita(Cita cita) async {
    http.Response deleteResponse = await client.delete(
      Uri.parse('$dataURL${cita.id}'),
    );

    if (deleteResponse.statusCode == 200) {
      return "cita eliminada exitosamente.";
    } else {
      throw "Error al eliminar la cita";
    }
  }

  @override
  Future<Cita> getCita(Cita cita) {
    // TODO: implement getcita
    throw UnimplementedError();
  }

  @override
  Future<List<Cita>> getCitaList(String id) async {
    List<Cita> parsedCita = [];
    http.Response citaResponse = await client.get(Uri.parse(dataURL));

    if (citaResponse.statusCode == 200) {
      String jsonStringCita = citaResponse.body;
      parsedCita = List<Cita>.from(
          json.decode(jsonStringCita).map((b) => Cita.fromJsonInclude(b)));
      return parsedCita;
    } else {
      throw "Error al cargar la cita del usuario";
    }
  }

  @override
  Future<List<Cita>> getCitaListProximas() async {
    List<Cita> parsedCita = [];
    http.Response citaResponse =
        await client.get(Uri.parse("$dataURLCustom/Proximas"));

    if (citaResponse.statusCode == 200) {
      String jsonStringCita = citaResponse.body;
      parsedCita = List<Cita>.from(
          json.decode(jsonStringCita).map((b) => Cita.fromJsonInclude(b)));
      return parsedCita;
    } else {
      throw "Error al cargar la cita del usuario";
    }
  }

  @override
  Future<String> patchCompleted(Cita cita) {
    // TODO: implement patchCompleted
    throw UnimplementedError();
  }

  @override
  Future<Cita> postCita(Cita cita) async {
    Cita? citaCreada;
    print(jsonEncode(cita.toJsonCustom()));
    http.Response postResponse = await client.post(Uri.parse(dataURL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(cita.toJsonCustom()));
    print(postResponse.statusCode);
    if (postResponse.statusCode == 201) {
      citaCreada = Cita.fromJson(jsonDecode(postResponse.body));
      return citaCreada;
    } else {
      throw "Error creando el cita.";
    }
  }

  @override
  Future<Cita> putCompleted(Cita cita) async {
    Cita? citaCreado;
    print("${cita.id} ${cita.pacienteId} ${cita.doctorId} ${cita.cita1}");
    http.Response putResponse = await client.put(
        Uri.parse('$dataURL${cita.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(cita.toJson()));
    print(
        "Logger status code: ${putResponse.statusCode} con URL: $dataURL y json: ${jsonEncode(cita.toJsonCustom())}");
    if (putResponse.statusCode == 201) {
      citaCreado = Cita.fromJson(jsonDecode(putResponse.body));
      return citaCreado;
    } else {
      throw "Error modificando la cita";
    }
  }
}
