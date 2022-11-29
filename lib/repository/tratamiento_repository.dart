import 'dart:convert';

import 'package:doctor_app/abstract/abstract_tratamiento.dart';
import 'package:doctor_app/models/tratamiento.dart';
import 'package:http/http.dart' as http;

import 'global.dart';

String dataURL = "${Global.dataURL}Tratamientos/";

class TratamientoRepository implements RepositoryTratamiento {
  http.Client client = http.Client();
  @override
  Future<String> deletedTratamiento(Tratamiento tratamiento) async {
    http.Response deleteResponse = await client.delete(
      Uri.parse('$dataURL${tratamiento.id}'),
    );

    if (deleteResponse.statusCode == 200) {
      return "Tratamiento eliminado exitosamente.";
    } else {
      throw "Error al eliminar al tratamiento";
    }
  }

  @override
  Future<Tratamiento> getTratamiento(Tratamiento tratamiento) {
    // TODO: implement getTratamiento
    throw UnimplementedError();
  }

  @override
  Future<List<Tratamiento>> getTratamientoList() async {
    List<Tratamiento> parsedTratamiento = [];
    http.Response tratamientoResponse = await client.get(Uri.parse(dataURL));

    if (tratamientoResponse.statusCode == 200) {
      String jsonStringTratamiento = tratamientoResponse.body;
      parsedTratamiento = List<Tratamiento>.from(json
          .decode(jsonStringTratamiento)
          .map((b) => Tratamiento.fromJson(b)));
      return parsedTratamiento;
    } else {
      throw "Error al cargar Tratamientoes del usuario";
    }
  }

  @override
  Future<String> patchCompleted(Tratamiento tratamiento) {
    // TODO: implement patchCompleted
    throw UnimplementedError();
  }

  @override
  Future<Tratamiento> postTratamiento(Tratamiento tratamiento) async {
    Tratamiento? tratamientoCreado;

    http.Response postResponse = await client.post(Uri.parse(dataURL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(tratamiento.toJsonCustom()));

    if (postResponse.statusCode == 201) {
      tratamientoCreado = Tratamiento.fromJson(jsonDecode(postResponse.body));
      return tratamientoCreado;
    } else {
      throw "Error creando el tratamiento.";
    }
  }

  @override
  Future<Tratamiento> putCompleted(Tratamiento tratamiento) async {
    Tratamiento? tratamientoCreado;

    http.Response putResponse = await client.put(
        Uri.parse('$dataURL${tratamiento.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(tratamiento.toJson()));

    if (putResponse.statusCode == 201) {
      tratamientoCreado = Tratamiento.fromJson(jsonDecode(putResponse.body));
      return tratamientoCreado;
    } else {
      throw "Error modificando el tratamiento";
    }
  }
}
