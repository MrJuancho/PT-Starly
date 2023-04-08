import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class UtilsSharedPref {
  void save(String key, value) async {
    //obtener instancia de shared para usar métodos
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  //método para leer la información
  Future<dynamic> read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString(key) == null) return null;
    return json.decode(prefs.getString(key)!);
  }

  //método para leer la información
  Future<dynamic> readtodato(String key, String dato) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString(key) == null) {
      // ignore: null_check_always_fails
      return null!;
    } else {
      final decodificacionJSONAPI = json.decode(prefs.getString(key)!);
      final conversionJSON = json.decode(decodificacionJSONAPI) as Map<String, dynamic>;
      final informacion = conversionJSON[dato];
      return informacion;
    }
  }

  //método para verificar si existe algún dato
  Future<bool> contains(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  //método para eliminar datos de shared preferences
  Future<bool> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

  void logout(BuildContext context) async {
    //borramos el key user para cerrar sesión
    await remove('Alumno');
    //eliminar historial de pantallas
    // ignore: use_build_context_synchronously
    Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
  }
}
