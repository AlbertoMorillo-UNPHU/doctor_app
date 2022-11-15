import '../models/cita.dart';

abstract class RepositoryCitas {
  Future<List<Cita>> getAllCitas();
  Future<String> postCita(Cita cita);
  Future<String> putCita(Cita cita);
  Future<String> deleteCita(Cita cita);
  Future<String> getCita(Cita cita);
}
