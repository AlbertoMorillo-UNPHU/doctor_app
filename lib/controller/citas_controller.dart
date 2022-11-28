import 'package:doctor_app/models/cita.dart';

import '../abstract/abstract_cita.dart';

class CitaController {
  final RepositoryCita _citaRepository;

  CitaController(this._citaRepository);

  Future<List<Cita>> fetchCitaList(String id) async {
    return _citaRepository.getCitaList(id);
  }

  Future<Cita> postCita(Cita cita) async {
    return _citaRepository.postCita(cita);
  }

  Future<Cita> getCita(Cita cita) async {
    return _citaRepository.getCita(cita);
  }

  Future<Cita> putCita(Cita cita) async {
    return _citaRepository.putCompleted(cita);

    
  }

  Future<String> deleteCita(Cita cita) async {
    return _citaRepository.deletedCita(cita);

    
  }
}
