import 'package:doctor_app/abstract/abstract_doctor.dart';

import '../models/doctor.dart';

class DoctorController {
  final RepositoryDoctor _repositoryDoctor;

  DoctorController(this._repositoryDoctor);

  Future<List<Doctor>> fetchDoctorList(String userID) async {
    return _repositoryDoctor.getDoctorList(userID);
  }

  Future<Doctor> postDoctor(Doctor doctor) async {
    return _repositoryDoctor.postDoctor(doctor);
  }

  Future<Doctor> getDoctor(Doctor doctor) async {
    return _repositoryDoctor.getDoctor(doctor);
  }

  Future<Doctor> putDoctor(Doctor doctor) async {
    return _repositoryDoctor.putCompleted(doctor);
  }

  Future<String> deleteDoctor(Doctor doctor) async {
    return _repositoryDoctor.deletedDoctor(doctor);
  }
}
