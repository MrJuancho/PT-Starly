// ignore_for_file: file_names

import 'dart:convert';
import 'package:asistente_virtual/src/pages/Provider/CatAV_provider.dart';
import 'package:asistente_virtual/src/pages/Provider/TblAlumnoAV_provider.dart';
import 'package:asistente_virtual/src/pages/Provider/TblSeleccionAV_provider.dart';
import 'package:asistente_virtual/src/pages/provider/TblAlumno_provider.dart';
import 'package:asistente_virtual/src/utils/utils_sharedpref.dart';
import 'package:flutter/material.dart';

class PersonalizacionController {
  BuildContext? context;
  Function? refresh;

  //Controllers
  final CatAVProvider _avProvider = CatAVProvider();
  final TblAlumnoAVProvider _alumnoAVProvider = TblAlumnoAVProvider();
  final UtilsSharedPref _sharedPref = UtilsSharedPref();
  final TblSeleccionAVProvider _seleccionAVProvider = TblSeleccionAVProvider();
  final TblAlumnoProvider _alumnoProvider = TblAlumnoProvider();

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    refresh();
  }

  Future<List> asistentesVXestrella() async {
    List asistentes = [];
    List<dynamic> asistente = await _avProvider.allTipoAVs(2);

    for (var i in asistente) {
      List temp = [i['idAv'], i['costo']];
      asistentes.add(temp);
    }
    return asistentes;
  }

  Future<List> asistentesVXmoneda() async {
    List asistentes = [];
    List<dynamic> asistente = await _avProvider.allTipoAVs(1);

    for (var i in asistente) {
      List temp = [i['idAv'], i['costo']];
      asistentes.add(temp);
    }
    return asistentes;
  }

  Future<List> asistentesComprados() async {
    final idAlumno = await _sharedPref.readtodato('Alumno', 'idAlumno');
    List asistentes = [];
    List<dynamic> asistente = await _alumnoAVProvider.allAVsAdquiered(idAlumno);

    for (var i in asistente) {
      asistentes.add(i['TblAlumnoAv_idAV']);
    }
    return asistentes;
  }

  Future<int> asistenteActual() async {
    final idAlumno = await _sharedPref.readtodato('Alumno', 'idAlumno');
    final datos = await _seleccionAVProvider.selectedAV(idAlumno);
    final idAlumnoAV = datos['TblSeleccionAv_idAlumnoAV'];
    List<dynamic> asistentes = await _alumnoAVProvider.allAVsAdquiered(idAlumno);
    Map<String, dynamic>? objetoEncontrado = asistentes.firstWhere(
      (objeto) => objeto["TblAlumnoAv_idAVAlumno"] == idAlumnoAV,
      orElse: () => null,
    );
    return objetoEncontrado?['TblAlumnoAv_idAV'];
  }

  void putnewAV(int idAV) async {
    final idAlumno = await _sharedPref.readtodato('Alumno', 'idAlumno');
    _seleccionAVProvider.putNewAVselected(idAlumno, idAV);
  }

  void buynewAV(int idAV) async {
    Map<String, dynamic> infoAlumno = json.decode(await _sharedPref.read('Alumno'));
    int idAlumno = infoAlumno['idAlumno'];
    final username = infoAlumno['nombreUsuario'];
    int monedas = infoAlumno['balanceMonedas'];
    _alumnoAVProvider.postNewAVacquired(idAlumno, idAV);
    Map<String, dynamic> datos = await _avProvider.oneAV(idAV);
    final costo = datos['costo'];

    _alumnoProvider.putMonedasEstrellas(username, -costo, 0);
    infoAlumno['balanceMonedas'] = monedas - costo;
    _sharedPref.save('Alumno', json.encode(infoAlumno));
    _sharedPref.printAllSharedPreferences('Alumno');
  }

  void claimNewAVStars(int idAV)async{
    Map<String, dynamic> infoAlumno = json.decode(await _sharedPref.read('Alumno'));
    int idAlumno = infoAlumno['idAlumno'];
    _alumnoAVProvider.postNewAVacquired(idAlumno, idAV);
  }
}
