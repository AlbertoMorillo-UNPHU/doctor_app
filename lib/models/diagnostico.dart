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
    fechaDiagnostico = json['fechaDiagnostico'];
    diagnosticoDesc = json['diagnosticoDesc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['pacienteId'] = pacienteId;
    data['doctorId'] = doctorId;
    data['fechaDiagnostico'] = fechaDiagnostico;
    data['diagnosticoDesc'] = diagnosticoDesc;
    return data;
  }
}
