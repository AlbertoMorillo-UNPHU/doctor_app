import 'package:doctor_app/models/cita.dart';

import '../abstract/abstract_citas.dart';

class CitaController {
  final RepositoryCitas _citaRepository;

  CitaController(this._citaRepository);

  Future<List<Cita>> fetchUsuarioList() async {
    return _citaRepository.getAllCitas();
  }

  Future<String> postUsario(Cita cita) async {
    return _citaRepository.postCita(cita);
  }

  Future<String> getUsario(Cita cita) async {
    return _citaRepository.getCita(cita);
  }

  Future<String> putUsuario(Cita cita) async {
    return _citaRepository.putCita(cita);

    
  }

  Future<String> deleteCita(Cita cita) async {
    return _citaRepository.deleteCita(cita);

    
  }
}
