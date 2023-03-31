import 'package:flutter/material.dart';
import 'package:asistente_virtual/src/models/user.dart';
import 'package:asistente_virtual/src/provider/users_provider.dart';
import 'package:asistente_virtual/src/utils/utils_sharedpref.dart';
import 'package:asistente_virtual/src/models/response_api.dart';
import 'package:asistente_virtual/src/utils/utils_snackbar.dart';

class LoginController {
  //se agrega un ? indicando que puede ser nula la variable
  BuildContext? context;

  //Controladores para detectar escritos
  TextEditingController usernameCtrller = new TextEditingController();
  TextEditingController passCtrller = new TextEditingController();

  UsersProvider usersProvider = new UsersProvider();
  UtilsSharedPref _sharedpref = new UtilsSharedPref();

  //constructort de clase - puede requerir await si se necesita esperar algo
  Future init(BuildContext context) async {
    this.context = context;
    await usersProvider.init(context);
    //se lee si hay llave user, en await
    //si no hay nada se manda nulo
    User user = User.fromJson(await _sharedpref.read('user') ?? {});
    print(user);

    //Se agrega ? porque user puede ser nulo porque no hay información por parte del sahredpreference
    //el ? evita un null.sessiontoken != null
    /* if (user.sessionToken != null) {
      //verificar si tiene más de un rol el usuario para enviarle a la pantalla roles
      if (user.medidas.length > 0) {
        Navigator.pushNamedAndRemoveUntil(
            context, user.medidas[0].route, (route) => false);
      } else {
        //pushNamedAndRemoveUntil -> quita historial de todas las pantallas y es la principal
        //se redirecciona a la ruta que tenga almacenada en la db si solo es una
        //Navigator.pushNamedAndRemoveUntil(context, 'calculate', (route) => false);
      }
    } */
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
        UtilsSnackbar.show(context!, "Usuario y/o contraseña incorrecta");
      }
    } else {
      print("No hay datos en el JSON");
    }
  }
}
