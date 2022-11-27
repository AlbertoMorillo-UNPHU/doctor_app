class Paciente {
  int? id;
  String? userId;
  String? nacimiento;
  bool? genero;
  String? tipoSangre;
  String? nombre;
  String? apellidos;

  Paciente(
      {this.id,
      this.userId,
      this.nacimiento,
      this.genero,
      this.tipoSangre,
      this.nombre,
      this.apellidos});

  Paciente.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    nacimiento = json['nacimiento'];
    genero = json['genero'];
    tipoSangre = json['tipoSangre'];
    nombre = json['nombre'];
    apellidos = json['apellidos'];
  }

  Paciente.fromJsonCustom(Map<String, dynamic> json) {
    userId = json['userId'];
    nacimiento = json['nacimiento'];
    genero = json['genero'];
    tipoSangre = json['tipoSangre'];
    nombre = json['nombre'];
    apellidos = json['apellidos'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id!.toInt();
    data['userId'] = userId.toString();
    data['nacimiento'] = nacimiento.toString();
    data['genero'] = genero as bool;
    data['tipoSangre'] = tipoSangre.toString();
    data['nombre'] = nombre.toString();
    data['apellidos'] = apellidos.toString();
    return data;
  }

  Map<String, dynamic> toJsonCustom() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId.toString();
    data['nacimiento'] = nacimiento.toString();
    data['genero'] = genero as bool;
    data['tipoSangre'] = tipoSangre.toString();
    data['nombre'] = nombre.toString();
    data['apellidos'] = apellidos.toString();
    return data;
  }
}
