import 'package:flutter/material.dart';

class ActividadesController {
  BuildContext? context;
  Function? refresh;

  //Controllers

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    //final data = await _sharedPref.readtodato('Alumno', 'nombre');
    refresh();
  }

  void pantallaanterior(BuildContext context) {
    Navigator.pop(context);
  }

  /* Future <String> nombreycosto() async{
    final numero = Arra
  } */
}
