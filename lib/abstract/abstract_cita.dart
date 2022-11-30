import '../models/cita.dart';

abstract class RepositoryCita {
  Future<List<Cita>> getCitaList(String id);
  Future<String> patchCompleted(Cita cita);
  Future<Cita> putCompleted(Cita cita);
  Future<String> deletedCita(Cita cita);
  Future<Cita> postCita(Cita cita);
  Future<Cita> getCita(Cita cita);
  Future<List<Cita>> getCitaListProximas();
}
