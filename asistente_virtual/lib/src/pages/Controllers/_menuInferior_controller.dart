// ignore_for_file: file_names

import 'package:flutter/material.dart';

class MenuInferiorController {
  BuildContext? context;

  //constructort de clase - puede requerir await si se necesita esperar algo
  Future init(BuildContext context) async {
    this.context = context;
  }

  void actividades(BuildContext context) async {
    //pasar a otra pantalla sin eliminar historial de pantallas
    Navigator.pushNamed(context, 'actividades');
  }

  void registroDiario(BuildContext context) async {
    //pasar a otra pantalla sin eliminar historial de pantallas
    Navigator.pushNamed(context, 'registroDiario');
  }

  void home(BuildContext context){
    Navigator.pushNamed(context, 'home');
  }
}