import 'dart:math';
import 'package:asistente_virtual/src/pages/Provider/CatDatoCurioso_provider.dart';
import 'package:flutter/material.dart';

class HomeController {
  BuildContext? context;
  Function? refresh;

  //Controladores
  final CatDatoCuriosoProvider _catDatoCuriosoProvider =
      CatDatoCuriosoProvider();

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    refresh();
  }

  Future<String> fraseRandom() async {
    final numero = Random().nextInt(435) + 1;
    final frase = await _catDatoCuriosoProvider.oneDatoCurioso(numero);
    final fraseString = frase.toString();
    return fraseString;
  }
}
