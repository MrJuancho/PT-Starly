import 'package:flutter/material.dart';
import 'package:asistente_virtual/src/pages/provider/TblAlumno_provider.dart';
import 'package:asistente_virtual/src/utils/utils_sharedpref.dart';
import 'package:asistente_virtual/src/utils/utils_snackbar.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginController {
  //se agrega un ? indicando que puede ser nula la variable
  BuildContext? context;

  //Controladores para detectar escritos
  TextEditingController usernameCtrller = new TextEditingController();
  TextEditingController passCtrller = new TextEditingController();

  TblAlumnoProvider usersProvider = new TblAlumnoProvider();
  UtilsSharedPref _sharedpref = new UtilsSharedPref();

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
        UtilsSnackbar.show(context!, "Bienvenido $username");
      } else {
        //Inicio de sesion fallido
        Fluttertoast.showToast(
            msg:
                "Si olvidaste tu contraseña contacta a tu administrador",
            backgroundColor: 
              Colors.red,
            textColor: 
              Colors.white,
            gravity: ToastGravity.TOP,
        );
        UtilsSnackbar.show(context!, "Usuario y/o contraseña incorrecta");
      }
    } else {
      print("No hay datos en el JSON");
    }
  }
}
