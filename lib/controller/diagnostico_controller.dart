import 'package:doctor_app/models/diagnostico.dart';

import '../abstract/abstract_diagnosticos.dart';

class DiagnosticoController {
  final RepositoryDiagnostico _diagnosticoRepository;

  DiagnosticoController(this._diagnosticoRepository);

  Future<List<Diagnostico>> fetchDiagnosticoList() async {
    return _diagnosticoRepository.getAllDiagnosticos();
  }

  Future<String> postDiagnostico(Diagnostico diagnostico) async {
    return _diagnosticoRepository.postDiagnostico(diagnostico);
  }

  Future<String> getDiagnostico(Diagnostico diagnostico) async {
    return _diagnosticoRepository.getDiagnostico(diagnostico);
  }

  Future<String> putDiagnostico(Diagnostico diagnostico) async {
    return _diagnosticoRepository.putDiagnostico(diagnostico);
  }

  Future<String> deleteDiagnostico(Diagnostico diagnostico) async {
    return _diagnosticoRepository.deleteDiagnostico(diagnostico);

    
  }
}
