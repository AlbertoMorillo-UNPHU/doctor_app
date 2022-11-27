import '../models/diagnostico.dart';

abstract class RepositoryDiagnostico {

  Future<List<Diagnostico>> getAllDiagnosticos();
  Future<String> postDiagnostico(Diagnostico diagnostico);
  Future<String> putDiagnostico(Diagnostico diagnostico);
  Future<String> deleteDiagnostico(Diagnostico diagnostico);
  Future<String> getDiagnostico(Diagnostico diagnostico);

}
