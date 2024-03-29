// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:asistente_virtual/src/pages/provider/TblAlumno_provider.dart';
import 'package:asistente_virtual/src/utils/utils_sharedpref.dart';
import 'package:asistente_virtual/src/utils/utils_snackbar.dart';
import 'dart:convert';

class LoginController {
  //se agrega un ? indicando que puede ser nula la variable
  BuildContext? context;

  //Controladores para detectar escritos
  final TextEditingController usernameCtrller =  TextEditingController();
  final TextEditingController passCtrller =  TextEditingController();

  final TblAlumnoProvider usersProvider =  TblAlumnoProvider();
  final UtilsSharedPref _sharedpref =  UtilsSharedPref();

  //constructort de clase - puede requerir await si se necesita esperar algo
  Future init(BuildContext context) async {
    this.context = context;
    await usersProvider.init(context);
  }

  void login() async {
    //trim para eliminar espacios en blanco
    String username = usernameCtrller.text.trim();
    String pw = passCtrller.text.trim();
    //debug de variables
    //print('Email:  $username');
    //print('PW:  $pw');
    var data = await usersProvider.login(username);

    //Validacion de que el password sea el mismo al que inserto el usuario
    if (data.isNotEmpty) {
      var claveAcceso = data["claveAcceso"];
      var usuario = data["nombreUsuario"];
      if (pw == claveAcceso && usuario == username) {
        //salvar la sesion del usuario y quien es el que esta logueado
        _sharedpref.save('Alumno', json.encode(data));
        Navigator.pushNamedAndRemoveUntil(context!, 'home', (route) => false);
        UtilsSnackbar.show(context!, "Bienvenido $usuario",3);
      } else {
        //Inicio de sesion fallido
        
        UtilsSnackbar.show(context!, "Usuario y/o contraseña incorrecta",4);
      }
    } else {
      if (kDebugMode) {
        print("No hay datos en el JSON");
      }
    }
  }
}
