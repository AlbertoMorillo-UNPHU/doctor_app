import '../models/usuarios.dart';

abstract class RepositoryUsuarios {
  Future<List<Usuarios>> getAllUsuarios();
  Future<String> postUsuario(Usuarios usuarios);
  Future<String> putUsuario(Usuarios usuarios);
  Future<String> deleteUsuario(Usuarios usuarios);
  Future<Usuarios> getUsuario(Usuarios usuarios);
}
