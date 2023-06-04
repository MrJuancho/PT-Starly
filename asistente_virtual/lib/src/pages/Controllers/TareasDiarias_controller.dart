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
    print(desafio);
    _sharedPref.save('DesafioDiario', json.encode(desafio));
  }

  Future<String> estrellasDD() async {
    final estrellas = await _sharedPref.readtodato('DesafioDiario', 'estrellas');
    return estrellas.toString();
  }

  Future<String> monedasDD() async {
    final monedas = await _sharedPref.readtodato('DesafioDiario', 'monedas');
    return monedas.toString();
  }

  Future<String> tareaDD() async {
    final tareaDD = await _sharedPref.readtodato('DesafioDiario', 'descripcionDesafio');
    return tareaDD;
  }

  Future<String> tarea(int idTareaDiaria) async {
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

  Future<Map<String, dynamic>> getTareas() async {
    Map<String, dynamic> actCompletadas = json.decode(await _sharedPref.read('Tareas'));
    print(actCompletadas);
    int interacciones = 0;
    if (actCompletadas['Interacciones'] >= 3) {
      interacciones = 1;
    }

    if (actCompletadas['Actividades'] == 3) {
      actCompletadas['TareasCom'] = 1 + interacciones;
    } else if (actCompletadas['Actividades'] == 5) {
      actCompletadas['TareasCom'] = 2 + interacciones;
    }
    _sharedPref.save('Tareas', json.encode(actCompletadas));
    print(actCompletadas);
    return actCompletadas;
  }

  Future<int> conteoDD()async{
    final conteoDD = await _sharedPref.readtodato('DesafioDiario', 'Conteo');
    return conteoDD;
  }
}
