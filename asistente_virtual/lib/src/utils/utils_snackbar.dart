import 'package:asistente_virtual/src/pages/flutter_flow/Theme_Personal.dart';
import 'package:flutter/material.dart';

class UtilsSnackbar {
  static void show(BuildContext context, String text, int duracion) {
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
        style: PersonalTheme.of(context).headlineMedium,
      ),
      //Fondo del snackbar y duración
      backgroundColor: PersonalTheme.of(context).secondary,
      duration: Duration(seconds: duracion),
    ));
  }
}
