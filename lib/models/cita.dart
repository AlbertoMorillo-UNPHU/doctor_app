class Cita {
  int? id;
  int? pacienteId;
  int? doctorId;
  String? cita1;

  Cita({this.id, this.pacienteId, this.doctorId, this.cita1});

  Cita.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pacienteId = json['pacienteId'];
    doctorId = json['doctorId'];
    cita1 = json['cita1'];
  }

  Cita.fromJsonCustom(Map<String, dynamic> json) {
    pacienteId = json['pacienteId'];
    doctorId = json['doctorId'];
    cita1 = json['cita1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['pacienteId'] = pacienteId;
    data['doctorId'] = doctorId;
    data['cita1'] = cita1;
    return data;
  }

    Map<String, dynamic> toJsonCustom() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pacienteId'] = pacienteId;
    data['doctorId'] = doctorId;
    data['cita1'] = cita1;
    return data;
  }
}
