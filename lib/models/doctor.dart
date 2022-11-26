class Doctor {
  int? id;
  String? userId;
  String? espacialidad;
  String? nombre;
  String? apellidos;

  Doctor(
      {this.id,
      required this.userId,
      required this.espacialidad,
      required this.nombre,
      required this.apellidos});

  Doctor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    espacialidad = json['espacialidad'];
    nombre = json['nombre'];
    apellidos = json['apellidos'];
  }

  Doctor.fromJsonCustom(Map<String, dynamic> json) {
    userId = json['userId'];
    espacialidad = json['espacialidad'];
    nombre = json['nombre'];
    apellidos = json['apellidos'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id.toString();
    data['userId'] = userId.toString();
    data['espacialidad'] = espacialidad.toString();
    data['nombre'] = nombre.toString();
    data['apellidos'] = apellidos.toString();
    return data;
  }
}
