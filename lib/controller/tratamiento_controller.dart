import '../models/tratamiento.dart';
import '../repository/tratamiento_repository.dart';

class TratamientoController {
  final TratamientoRepository _repositoryTratamiento;

  TratamientoController(this._repositoryTratamiento);

  Future<List<Tratamiento>> fetchTratamientoList() async {
    return _repositoryTratamiento.getTratamientoList();
  }

  Future<Tratamiento> postTratamiento(Tratamiento tratamiento) async {
    return _repositoryTratamiento.postTratamiento(tratamiento);
  }

  Future<Tratamiento> getTratamiento(Tratamiento tratamiento) async {
    return _repositoryTratamiento.getTratamiento(tratamiento);
  }

  Future<Tratamiento> putTratamiento(Tratamiento tratamiento) async {
    return _repositoryTratamiento.putCompleted(tratamiento);
  }

  Future<String> deleteTratamiento(Tratamiento tratamiento) async {
    return _repositoryTratamiento.deletedTratamiento(tratamiento);
  }
}
