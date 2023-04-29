import 'dart:convert';
import 'dart:math';
import 'package:asistente_virtual/src/pages/Provider/CatDesafioDiario_provider.dart';
import 'package:flutter/material.dart';
import 'package:asistente_virtual/src/pages/Provider/CatTareaDiaria_provider.dart';
import 'package:asistente_virtual/src/utils/utils_sharedpref.dart';

class TareasDiariasController {
  BuildContext? context;
  CatTareaDiariaProvider tareadiariaProvider = CatTareaDiariaProvider();
  CatDesafioDiarioProvider _catDesafioDiarioProvider = CatDesafioDiarioProvider();
  final UtilsSharedPref _sharedPref = UtilsSharedPref();

  //constructort de clase - puede requerir await si se necesita esperar algo
  Future init(BuildContext context) async {
    this.context = context;
    await tareadiariaProvider.init(context);
  }

  void desafioRandom() async {
    final numero = Random().nextInt(2) + 1;
    final desafio = await _catDesafioDiarioProvider.oneDesafioDiario(numero);
    _sharedPref.save('DesafioDiario', desafio);
  }

  Future<String> estrellasDD(int idTareaDiaria) async {
    final estrellas = await _catDesafioDiarioProvider.oneDesafioDiario(idTareaDiaria);
    final estrellasString = estrellas["estrellas"].toString();
    return estrellasString;
  }

  Future<String> monedasDD(int idTareaDiaria) async {
    final monedas = await _catDesafioDiarioProvider.oneDesafioDiario(idTareaDiaria);
    final monedasString = monedas["monedas"].toString();
    return monedasString;
  }

  Future<String> tarea(int idTareaDiaria) async{
    final tarea = await tareadiariaProvider.oneTareaDiaria(idTareaDiaria);
    final tareaString = tarea["descripcionTarea"].toString();
    return tareaString;
  }

  Future<String> estrellas(int idTareaDiaria) async {
    final estrellas = await tareadiariaProvider.oneTareaDiaria(idTareaDiaria);
    final estrellasString = estrellas["estrellas"].toString();
    return estrellasString;
  }

  Future<String> monedas(int idTareaDiaria) async {
    final monedas = await tareadiariaProvider.oneTareaDiaria(idTareaDiaria);
    final monedasString = monedas["monedas"].toString();
    return monedasString;
  }
}
