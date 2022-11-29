import 'package:doctor_app/models/doctor.dart';
import 'package:doctor_app/models/paciente.dart';

class Diagnostico {
  int? id;
  int? pacienteId;
  int? doctorId;
  String? fechaDiagnostico;
  String? diagnosticoDesc;
  Paciente? paciente;
  Doctor? doctor;

  Diagnostico(
      {this.id,
      this.pacienteId,
      this.doctorId,
      this.fechaDiagnostico,
      this.diagnosticoDesc,
      this.paciente,
      this.doctor});

  Diagnostico.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pacienteId = json['pacienteId'];
    doctorId = json['doctorId'];
    fechaDiagnostico = json['fechaDiagnostico'];
    diagnosticoDesc = json['diagnosticoDesc'];
  }

  Diagnostico.fromJsonInclude(Map<String, dynamic> json) {
    id = json['id'];
    pacienteId = json['pacienteId'];
    doctorId = json['doctorId'];
    fechaDiagnostico = json['fechaDiagnostico'];
    diagnosticoDesc = json['diagnosticoDesc'];
    paciente = Paciente.fromJson(json['paciente']);
    doctor = Doctor.fromJson(json['doctor']);
  }

  Diagnostico.fromJsonCustom(Map<String, dynamic> json) {
    pacienteId = json['pacienteId'];
    doctorId = json['doctorId'];
    fechaDiagnostico = json['fechaDiagnostico'];
    diagnosticoDesc = json['diagnosticoDesc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id as int;
    data['pacienteId'] = pacienteId as int;
    data['doctorId'] = doctorId as int;
    data['fechaDiagnostico'] = fechaDiagnostico.toString();
    data['diagnosticoDesc'] = diagnosticoDesc.toString();
    return data;
  }

  Map<String, dynamic> toJsonCustom() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pacienteId'] = pacienteId as int;
    data['doctorId'] = doctorId as int;
    data['fechaDiagnostico'] = fechaDiagnostico.toString();
    data['diagnosticoDesc'] = diagnosticoDesc.toString();
    return data;
  }
}
