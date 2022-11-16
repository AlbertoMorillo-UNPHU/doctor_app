import 'package:doctor_app/models/usuarios.dart';

import '../abstract/abstract_usuarios.dart';

class UsuarioController {
  final RepositoryUsuarios _usuariosRepository;

  UsuarioController(this._usuariosRepository);

  Future<List<Usuarios>> fetchUsuarioList() async {
    return _usuariosRepository.getAllUsuarios();
  }

  Future<String> postUsario(Usuarios usuarios) async {
    return _usuariosRepository.postUsuario(usuarios);
  }

  Future<Usuarios> getUsario(Usuarios usuarios) async {
    return _usuariosRepository.getUsuario(usuarios);
  }

  Future<String> putUsuario(Usuarios usuarios) async {
    return _usuariosRepository.putUsuario(usuarios);
  }
}
