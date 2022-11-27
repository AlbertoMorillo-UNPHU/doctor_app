import '../models/paciente.dart';

abstract class RepositoryPaciente {
  Future<List<Paciente>> getPacienteList(String userId);
  Future<String> patchCompleted(Paciente paciente);
  Future<Paciente> putCompleted(Paciente paciente);
  Future<String> deletedPaciente(Paciente paciente);
  Future<Paciente> postPaciente(Paciente paciente);
  Future<Paciente> getPaciente(Paciente paciente);
}
