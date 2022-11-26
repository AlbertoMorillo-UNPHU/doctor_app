import 'dart:convert';

import 'package:doctor_app/models/usuarios.dart';
import 'package:http/http.dart' as http;
import '../abstract/abstract_usuarios.dart';
import 'global.dart';

class UsuarioRepository implements RepositoryUsuarios {
  final String dataURL = "${Global.dataURL}Usuarios/";
  @override
  Future<String> deleteUsuario(Usuarios usuarios) {
    // TODO: implement deleteUsuario
    throw UnimplementedError();
  }

  @override
  Future<List<Usuarios>> getAllUsuarios() async {
    List<Usuarios> usuarioList = [];
    var url = Uri.parse(dataURL);
    print("print get: $url");
    var response = await http.get(url);
    print("status code: ${response.statusCode}");
    var body = json.decode(response.body);

    for (var i = 0; i < body.length; i++) {
      usuarioList.add(Usuarios.fromJson(body[i]));
    }
    return usuarioList;
    ;
  }

  @override
  Future<Usuarios> getUsuario(Usuarios usuarios) async {
    var url = Uri.parse('$dataURL${usuarios.uidFire}');
    print("print get: $url");
    var response = await http.get(url);
    print("status code: ${response.statusCode}");
    var body = json.decode(response.body);
    var user = Usuarios.fromJson(body);
    return user;
  }

  @override
  Future<String> postUsuario(Usuarios usuarios) async {
    var url = Uri.parse(dataURL);
    var result = "false";
    print('$url Json armado: ${usuarios.toJson()}');
    var response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(usuarios.toJson()));
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 201) {
      result = "true";
    }
    return result;
  }

  @override
  Future<String> putUsuario(Usuarios usuarios) {
    // TODO: implement putUsuario
    throw UnimplementedError();
  }
}
