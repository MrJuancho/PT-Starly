import 'package:asistente_virtual/src/utils/utils_colors.dart';
import 'package:flutter/material.dart';
import 'package:asistente_virtual/src/pages/Screens/Login_screen.dart';
import 'package:asistente_virtual/src/pages/Screens/PaginaInicio_screen.dart';
import 'package:asistente_virtual/src/pages/Screens/PruebasAPI_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //Titulo de la app
      title: 'Asistente Virtual',
      //Quitar bandera de debug
      debugShowCheckedModeBanner: false,
      //Ruta inicial de la aplicación 
      initialRoute: 'login',
      //rutas de la aplicacion
      routes: {
        //pagina de login
        
        'login':(BuildContext context) => LoginPage(),
        'home':(BuildContext context) => HomePage(),
        //'actividades':(BuildContext context) => Actividades(),
        //'registroDiario':(BuildContext context) => RegistroDiario(),
        //'personalizacion':(BuildContext context) => Personalizacion(),
        'pruebasapi':(BuildContext context) => const MyTextFieldAndButton(),
      },

      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        colorScheme: ColorScheme.dark(primary: UtilsColors.primaryBackgroundColor),
      ),
    );
  }
}

