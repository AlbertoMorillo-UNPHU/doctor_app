import 'doctor.dart';
import 'paciente.dart';

class Cita {
  int? id;
  int? pacienteId;
  int? doctorId;
  String? cita1;
  Paciente? paciente;
  Doctor? doctor;

  Cita(
      {this.id,
      this.pacienteId,
      this.doctorId,
      this.cita1,
      this.paciente,
      this.doctor});

  Cita.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pacienteId = json['pacienteId'];
    doctorId = json['doctorId'];
    cita1 = json['cita1'];
  }

  Cita.fromJsonInclude(Map<String, dynamic> json) {
    id = json['id'];
    pacienteId = json['pacienteId'];
    doctorId = json['doctorId'];
    cita1 = json['cita1'];
    paciente = Paciente.fromJson(json['paciente']);
    doctor = Doctor.fromJson(json["doctor"]);
  }

  Cita.fromJsonCustom(Map<String, dynamic> json) {
    pacienteId = json['pacienteId'];
    doctorId = json['doctorId'];
    cita1 = json['cita1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['pacienteId'] = pacienteId as int;
    data['doctorId'] = doctorId as int;
    data['cita1'] = cita1.toString();
    return data;
  }

  Map<String, dynamic> toJsonCustom() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pacienteId'] = pacienteId as int;
    data['doctorId'] = doctorId as int;
    data['cita1'] = cita1.toString();
    return data;
  }
}
