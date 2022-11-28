import '../models/diagnostico.dart';

abstract class RepositoryDiagnostico {

  Future<List<Diagnostico>> getAllDiagnosticos(String id);
  Future<String> patchCompleted(Diagnostico paciente);
  Future<Diagnostico> putDiagnostico(Diagnostico diagnostico);
  Future<String> deletedDiagnostico(Diagnostico diagnostico);
  Future<Diagnostico> postDiagnostico(Diagnostico diagnostico);
  Future<Diagnostico> getDiagnostico(Diagnostico diagnostico);

}
