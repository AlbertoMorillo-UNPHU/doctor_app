import '../models/tratamiento.dart';

abstract class RepositoryTratamiento {
  Future<List<Tratamiento>> getTratamientoList();
  Future<String> patchCompleted(Tratamiento tratamiento);
  Future<Tratamiento> putCompleted(Tratamiento tratamiento);
  Future<String> deletedTratamiento(Tratamiento tratamiento);
  Future<Tratamiento> postTratamiento(Tratamiento tratamiento);
  Future<Tratamiento> getTratamiento(Tratamiento tratamiento);
}
