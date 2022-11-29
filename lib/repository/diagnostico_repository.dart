import 'dart:convert';
import 'package:http/http.dart' as http;

import '../abstract/abstract_diagnostico.dart';
import '../models/diagnostico.dart';
import 'global.dart';

String dataURL = "${Global.dataURL}Diagnosticos/";

class DiagnosticoRepository implements RepositoryDiagnostico {
  http.Client client = http.Client();
  @override
  Future<String> deletedDiagnostico(Diagnostico diagnostico) async {
    http.Response deleteResponse = await client.delete(
      Uri.parse('$dataURL${diagnostico.id}'),
    );

    if (deleteResponse.statusCode == 200) {
      return "Diagnostico eliminado exitosamente.";
    } else {
      throw "Error al eliminar el diagnostico";
    }
  }

  @override
  Future<Diagnostico> getDiagnostico(Diagnostico diagnostico) {
    // TODO: implement getDiagnostico
    throw UnimplementedError();
  }

  @override
  Future<List<Diagnostico>> getDiagnosticoList(String id) async {
    List<Diagnostico> parsedDiagnostico = [];
    http.Response diagnosticoResponse =
        await client.get(Uri.parse("$dataURL$id"));

    if (diagnosticoResponse.statusCode == 200) {
      String jsonStringDiagnostico = diagnosticoResponse.body;
      parsedDiagnostico = List<Diagnostico>.from(
          json.decode(jsonStringDiagnostico).map((b) => Diagnostico.fromJson(b)));
      return parsedDiagnostico;
    } else {
      throw "Error al cargar Diagnosticos del usuario";
    }
  }

  @override
  Future<String> patchCompleted(Diagnostico diagnostico) {
    // TODO: implement patchCompleted
    throw UnimplementedError();
  }

  @override
  Future<Diagnostico> postDiagnostico(Diagnostico diagnostico) async {
    Diagnostico? diagnosticoCreado;

    http.Response postResponse = await client.post(Uri.parse(dataURL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(diagnostico.toJsonCustom()));

    if (postResponse.statusCode == 201) {
      diagnosticoCreado = Diagnostico.fromJson(jsonDecode(postResponse.body));
      return diagnosticoCreado;
    } else {
      throw "Error creando el Diagnostico.";
    }
  }

  @override
  Future<Diagnostico> putCompleted(Diagnostico diagnostico) async {
    Diagnostico? diagnosticoCreado;
    print(
        "${diagnostico.id} ${diagnostico.pacienteId} ${diagnostico.doctorId} ${diagnostico.fechaDiagnostico} ${diagnostico.diagnosticoDesc}");
    http.Response putResponse = await client.put(
        Uri.parse('$dataURL${diagnostico.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(diagnostico.toJson()));
    print(
        "Logger status code: ${putResponse.statusCode} con URL: $dataURL y json: ${jsonEncode(diagnostico.toJsonCustom())}");
    if (putResponse.statusCode == 201) {
      diagnosticoCreado = Diagnostico.fromJson(jsonDecode(putResponse.body));
      return diagnosticoCreado;
    } else {
      throw "Error modificando el Diagnostico";
    }
  }
}
