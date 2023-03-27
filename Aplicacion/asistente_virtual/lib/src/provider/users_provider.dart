import 'dart:convert';
import 'package:asistente_virtual/src/api/enviroment.dart';
import 'package:asistente_virtual/src/models/response_api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UsersProvider {
  //URL de la api
  final String _url = Enviroment.API;
  final String _api = '/api/users';

  BuildContext? context;

  Future? init(BuildContext context) {
    this.context = context;
  }

  //respuesta de las solicitudes
  Future<ResponseApi> login(String user, String pw) async {
    try {
      //URL para el post
      Uri url = Uri.http(_url, '$_api/login');
      //Parámetros a enviar en cuerpo de datos
      String bodyParams = json.encode({
        'user': user,
        'password': pw,
      });

      //Aplicación JSON
      Map<String, String> headers = {'Content-type': 'application/json'};

      //Petición POST de login
      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);
      print(data);
      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (e) {
      print('Error: $e');
      return null!;
    }
  }
}
