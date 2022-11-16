class Usuarios {
  String? username;
  int? id;
  String? email;
  String? password;

  Usuarios({this.username, this.id, this.email, this.password});

  Usuarios.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    id = json['id'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username.toString();
    data['email'] = email.toString();
    data['password'] = password.toString();
    return data;
  }
}
