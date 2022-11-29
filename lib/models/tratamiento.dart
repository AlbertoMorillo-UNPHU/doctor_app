import 'doctor.dart';
import 'paciente.dart';

class Tratamiento {
  int? id;
  int? pacienteId;
  int? doctorId;
  String? fechaInicio;
  String? fechaFin;
  String? tratamientoDesc;
  Paciente? paciente;
  Doctor? doctor;

  Tratamiento(
      {this.id,
      this.pacienteId,
      this.doctorId,
      this.fechaInicio,
      this.fechaFin,
      this.tratamientoDesc,
      this.paciente,
      this.doctor});

  Tratamiento.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pacienteId = json['pacienteId'];
    doctorId = json['doctorId'];
    fechaInicio = json['fechaInicio'];
    fechaFin = json['fechaFin'];
    tratamientoDesc = json['tratamientoDesc'];
  }

  Tratamiento.fromJsonInclude(Map<String, dynamic> json) {
    id = json['id'];
    pacienteId = json['pacienteId'];
    doctorId = json['doctorId'];
    fechaInicio = json['fechaInicio'];
    fechaFin = json['fechaFin'];
    tratamientoDesc = json['tratamientoDesc'];
    paciente = Paciente.fromJson(json['paciente']);
    doctor = Doctor.fromJson(json["doctor"]);
  }

  Tratamiento.fromJsonCustom(Map<String, dynamic> json) {
    pacienteId = json['pacienteId'];
    doctorId = json['doctorId'];
    fechaInicio = json['fechaInicio'];
    fechaFin = json['fechaFin'];
    tratamientoDesc = json['tratamientoDesc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id as int;
    data['pacienteId'] = pacienteId as int;
    data['doctorId'] = doctorId as int;
    data['fechaInicio'] = fechaInicio.toString();
    data['fechaFin'] = fechaFin.toString();
    data['tratamientoDesc'] = tratamientoDesc.toString();
    return data;
  }

  Map<String, dynamic> toJsonCustom() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pacienteId'] = pacienteId as int;
    data['doctorId'] = doctorId as int;
    data['fechaInicio'] = fechaInicio.toString();
    data['fechaFin'] = fechaFin.toString();
    data['tratamientoDesc'] = tratamientoDesc.toString();
    return data;
  }
}
