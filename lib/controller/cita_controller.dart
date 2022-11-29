import 'package:doctor_app/models/cita.dart';
import 'package:doctor_app/repository/cita_repository.dart';

class CitaController {
  final CitaRepository _citaRepository;

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
