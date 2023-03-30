import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());

class User {
  String? idAlumno;
  String? nombre;
  String? apellidoPaterno;
  String? apellidoMaterno;
  String? usuario;
  String? password;
  String? monedas;
  String? estrellas;
  String? idAV;

  User(
      {this.idAlumno,
      this.nombre,
      this.apellidoPaterno,
      this.apellidoMaterno,
      this.usuario,
      this.password,
      this.monedas,
      this.estrellas,
      this.idAV});

  factory User.fromJson(Map<String, dynamic> json) => User(
      idAlumno: json['idAlumno'] is int
          ? json['idAlumno'].toString()
          : json['idAlumno'],
      nombre: json['Nombre'],
      apellidoPaterno: json['apellidoPaterno'],
      apellidoMaterno: json['apellidoMaterno'],
      usuario: json['Usuario'],
      password: json['Contraseña'],
      monedas: json['monedas'],
      estrellas: json['Estrellas'],
      idAV: json['idAV'] is int ? json['idAV'].toString() : json['idAV']);

  Map<String, dynamic> toJson() => {
        "idAlumno": idAlumno,
        "Nombre" : nombre,
        "apellidoPaterno" : apellidoPaterno,
        "apellidoMaterno" : apellidoMaterno,
        "Usuario" : usuario,
        "Contraseña" : password,
        "Monedas" : monedas,
        "Estrellas" : estrellas,
        "idAV" : idAV
      };
}
