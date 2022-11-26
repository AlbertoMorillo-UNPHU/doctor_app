class Usuarios {
  String? uidFire;
  String? username;

  Usuarios({this.uidFire, this.username});

  Usuarios.fromJson(Map<String, dynamic> json) {
    uidFire = json['uidFire'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uidFire'] = uidFire.toString();
    data['username'] = username.toString();
    return data;
  }
}
