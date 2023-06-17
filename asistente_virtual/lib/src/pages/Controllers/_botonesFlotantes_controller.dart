// ignore_for_file: file_names

import 'package:flutter/material.dart';

class BotonesFlotantesController {
  BuildContext? context;

  //constructort de clase - puede requerir await si se necesita esperar algo
  Future init(BuildContext context) async {
    this.context = context;
  }

  void personalizacion(BuildContext context) async {
    //pasar a otra pantalla sin eliminar historial de pantallas
    Navigator.pushNamed(context, 'personalizacion');
  }

  void actividades(BuildContext context) async {
    //pasar a otra pantalla sin eliminar historial de pantallas
    Navigator.pushNamed(context, 'actividades');
  }
}