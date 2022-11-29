class Diagnostico {
  int? id;
  int? pacienteId;
  int? doctorId;
  DateTime? fechaDiagnostico;
  String? diagnosticoDesc;

  Diagnostico(
      {this.id,
      this.pacienteId,
      this.doctorId,
      this.fechaDiagnostico,
      this.diagnosticoDesc});

  Diagnostico.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pacienteId = json['pacienteId'];
    doctorId = json['doctorId'];
    fechaDiagnostico = json['fechaCreacion'];
    diagnosticoDesc = json['diagnosticoDesc'];
  }

  Diagnostico.fromJsonCustom(Map<String, dynamic> json) {
    pacienteId = json['pacienteId'];
    doctorId = json['doctorId'];
    fechaDiagnostico = json['fechaCreacion'];
    diagnosticoDesc = json['diagnosticoDesc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['pacienteId'] = pacienteId;
    data['doctorId'] = doctorId;
    data['fechaCreacion'] = fechaDiagnostico;
    data['diagnosticoDesc'] = diagnosticoDesc;
    return data;
  }

  Map<String, dynamic> toJsonCustom() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pacienteId'] = pacienteId;
    data['doctorId'] = doctorId;
    data['fechaCreacion'] = fechaDiagnostico;
    data['diagnosticoDesc'] = diagnosticoDesc;
    return data;
  }
}
