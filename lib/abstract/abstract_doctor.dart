import 'package:doctor_app/models/doctor.dart';

abstract class RepositoryDoctor {
  Future<List<Doctor>> getDoctorList(String userId);
  Future<String> patchCompleted(Doctor doctor);
  Future<Doctor> putCompleted(Doctor doctor);
  Future<String> deletedDoctor(Doctor doctor);
  Future<Doctor> postDoctor(Doctor doctor);
  Future<Doctor> getDoctor(Doctor doctor);
}
