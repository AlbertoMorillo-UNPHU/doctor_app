import '../abstract/abstract_paciente.dart';
import '../models/paciente.dart';

class PacienteController {
  final RepositoryPaciente _repositoryPaciente;

  PacienteController(this._repositoryPaciente);

  Future<List<Paciente>> fetchPacienteList(String userID) async {
    return _repositoryPaciente.getPacienteList(userID);
  }

  Future<Paciente> postPaciente(Paciente paciente) async {
    return _repositoryPaciente.postPaciente(paciente);
  }

  Future<Paciente> getPaciente(Paciente paciente) async {
    return _repositoryPaciente.getPaciente(paciente);
  }

  Future<Paciente> putPaciente(Paciente paciente) async {
    return _repositoryPaciente.putCompleted(paciente);
  }

  Future<String> deletePaciente(Paciente paciente) async {
    return _repositoryPaciente.deletedPaciente(paciente);
  }
}
