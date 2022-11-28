import 'package:doctor_app/models/cita.dart';

import '../abstract/abstract_citas.dart';

class CitaController {
  final RepositoryCita _citaRepository;

  CitaController(this._citaRepository);

  Future<List<Cita>> fetchCitaList(String id) async {
    return _citaRepository.getAllCitas(id);
  }

  Future<Cita> postUsario(Cita cita) async {
    return _citaRepository.postCita(cita);
  }

  Future<Cita> getUsario(Cita cita) async {
    return _citaRepository.getCita(cita);
  }

  Future<Cita> putUsuario(Cita cita) async {
    return _citaRepository.putCompleted(cita);

    
  }

  Future<String> deleteCita(Cita cita) async {
    return _citaRepository.deletedCita(cita);

    
  }
}
