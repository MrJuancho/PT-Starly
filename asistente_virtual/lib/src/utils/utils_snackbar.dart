import 'package:flutter/material.dart';

class UtilsSnackbar {
  static void show(BuildContext context, String text) {
    //se verifica que haya conetxto de la aplicación
    // ignore: unnecessary_null_comparison
    if (context == null) return;

    FocusScope.of(context).requestFocus(FocusNode());
    //se remueve cualquier snackbar anterior o que se esté mostrando
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    //se establece un snackbar
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content:
          //Se establece el texto como text quee se recive
          Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white, fontSize: 14),
      ),
      //fondo del snackbar negro y duración 3s
      backgroundColor: Colors.black,
      duration: const Duration(seconds: 3),
    ));
  }
}