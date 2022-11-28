import 'package:doctor_app/models/diagnostico.dart';

import '../abstract/abstract_diagnosticos.dart';

class DiagnosticoController {
  final RepositoryDiagnostico _diagnosticoRepository;

  DiagnosticoController(this._diagnosticoRepository);

  Future<List<Diagnostico>> fetchDiagnosticoList(String id) async {
    return _diagnosticoRepository.getAllDiagnosticos(id);
  }

  Future<Diagnostico> postDiagnostico(Diagnostico diagnostico) async {
    return _diagnosticoRepository.postDiagnostico(diagnostico);
  }

  Future<Diagnostico> getDiagnostico(Diagnostico diagnostico) async {
    return _diagnosticoRepository.getDiagnostico(diagnostico);
  }

  Future<Diagnostico> putDiagnostico(Diagnostico diagnostico) async {
    return _diagnosticoRepository.putDiagnostico(diagnostico);
  }

  Future<String> deleteDiagnostico(Diagnostico diagnostico) async {
    return _diagnosticoRepository.deletedDiagnostico(diagnostico);

    
  }
}
