import 'package:asistente_virtual/src/pages/Screens/Actividades/Misma%20Imagen/act_encuentra_cuidado_medio_ambiente_screen.dart';
import 'package:asistente_virtual/src/pages/Screens/Actividades/Misma%20Imagen/act_encuentra_expresiones_algebraicas_screen.dart';
import 'package:asistente_virtual/src/pages/Screens/Actividades/Misma%20Imagen/act_encuentra_partido_politico_screen.dart';
import 'package:asistente_virtual/src/pages/Screens/Actividades/Misma%20Imagen/act_encuentra_recta_secante_screen.dart';
import 'package:asistente_virtual/src/pages/Screens/Actividades_screen.dart';
import 'package:asistente_virtual/src/pages/Screens/Personalizacion_screen.dart';
import 'package:asistente_virtual/src/pages/Screens/TareasDiarias_screen.dart';
import 'package:asistente_virtual/src/pages/flutter_flow/Theme_Personal.dart';
import 'package:asistente_virtual/src/utils/utils_inicialize.dart';
import 'package:flutter/material.dart';
import 'package:asistente_virtual/src/pages/Screens/Login_screen.dart';
import 'package:asistente_virtual/src/pages/Screens/PaginaInicio_screen.dart';
import 'package:asistente_virtual/src/pages/Screens/PruebasAPI_screen.dart';

void main() {
  runApp(MyApp());
  UtilsInicialize _utilsInicialize = UtilsInicialize();
  _utilsInicialize.initDD('DesafioDiario', 'Expiracion');
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ThemeMode _themeMode = PersonalTheme.themeMode;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //Titulo de la app
      title: 'Asistente Virtual',
      //Quitar bandera de debug
      debugShowCheckedModeBanner: false,
      //Ruta inicial de la aplicación
      initialRoute: 'act_encuentra_cuidado_medio_ambiente',
      //rutas de la aplicacion
      routes: {
        'login': (BuildContext context) => LoginPage(),
        'home': (BuildContext context) => HomePage(),
        'personalizacion': (BuildContext context) => PersonalizacionPage(),
        'actividades': (BuildContext context) => ActividadesPage(),
        'tareasdiarias': (BuildContext context) => TareasDiariasPage(),
        'act_encuentra_recta_secante' : (BuildContext context) => const ActEncuentraRectaSecantePage(),
        'act_encuentra_partidos_politicos':(BuildContext context) => const ActEncuentraPartidosPoliticosPage(),
        'act_encuentra_expresiones_algebraicas':(BuildContext context) => const ActEncuentraExpresionesAlgebraicasPage(),
        'act_encuentra_cuidado_medio_ambiente':(BuildContext context) => const ActEncuentraCuidadoMedioAmbientePage(),
        //'registroDiario':(BuildContext context) => RegistroDiario(),

        'pruebasapi': (BuildContext context) => const MyTextFieldAndButton(),
      },

      theme: ThemeData(brightness: Brightness.dark),
      themeMode: _themeMode,
    );
  }
}
