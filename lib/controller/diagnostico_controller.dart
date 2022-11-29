import 'package:doctor_app/models/diagnostico.dart';

import '../abstract/abstract_diagnostico.dart';

class DiagnosticoController {
  final RepositoryDiagnostico _diagnosticoRepository;

  DiagnosticoController(this._diagnosticoRepository);

  Future<List<Diagnostico>> fetchDiagnosticoList(String id) async {
    return _diagnosticoRepository.getDiagnosticoList(id);
  }

  Future<Diagnostico> postDiagnostico(Diagnostico diagnostico) async {
    return _diagnosticoRepository.postDiagnostico(diagnostico);
  }

  Future<Diagnostico> getDiagnostico(Diagnostico diagnostico) async {
    return _diagnosticoRepository.getDiagnostico(diagnostico);
  }

  Future<Diagnostico> putDiagnostico(Diagnostico diagnostico) async {
    return _diagnosticoRepository.putCompleted(diagnostico);
  }

  Future<String> deleteDiagnostico(Diagnostico diagnostico) async {
    return _diagnosticoRepository.deletedDiagnostico(diagnostico);

    
  }
}
