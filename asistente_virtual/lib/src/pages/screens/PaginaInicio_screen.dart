// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:asistente_virtual/src/pages/Controllers/Home_controller.dart';
import 'package:asistente_virtual/src/pages/Controllers/Personalizacion_controller.dart';
import 'package:asistente_virtual/src/pages/Widgets/_botonesFlotantes_widget.dart';
import 'package:asistente_virtual/src/pages/Widgets/_menuInferior_widget.dart';
import 'package:asistente_virtual/src/pages/Widgets/_menuSuperior_widget.dart';
import 'package:asistente_virtual/src/pages/flutter_flow/Theme_Personal.dart';
import 'package:asistente_virtual/src/utils/utils_inicialize.dart';
//import 'package:asistente_virtual/src/utils/utils_sharedpref.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Controler
  final HomeController _homeController = HomeController();
  final PersonalizacionController _personalizacionController = PersonalizacionController();
  //final UtilsSharedPref _sharedPref = UtilsSharedPref();

  bool _isPress = false;
  int idAV = 0;

  @override
  void initState() {
    super.initState();
    init();
    _homeController.init(context, refresh);
  }

  void init() async {
    UtilsInicialize utilsInicialize = UtilsInicialize();
    await utilsInicialize.initTareasyDesafio();
    int avactualtemp = await _personalizacionController.asistenteActual();
    setState(() {
      idAV = avactualtemp;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    const reducedwindowWidth = 500.00;
    const reducedwindowHeight = 810.00;

    if (screenWidth >= 450) {
      double wpart = reducedwindowWidth / 1.5;
      double hpart = reducedwindowHeight / 1.5;
      return SizedBox(
        height: reducedwindowHeight,
        width: reducedwindowWidth,
        child: Center(child: asistente(screenWidth, screenHeight, wpart, hpart)),
      );
    } else {
      double wpart = screenWidth / 1.5;
      double hpart = screenHeight / 1.5;
      return asistente(screenWidth, screenHeight, wpart, hpart);
    }
  }

  void refresh() {
    setState(() {});
  }

  void changeState() {
    setState(() {
      _isPress = !_isPress;
    });
  }

  Widget asistente(double screenWidth, double screenHeight, double wpart, double hpart) {
    return Scaffold(
      appBar: MenuSuperior(),
      bottomNavigationBar: MenuInferior(),
      floatingActionButton: BotonesFlotantes(),
      body: Stack(
        children: [
          Container(
            width: screenWidth * 1,
            height: screenHeight * 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [PersonalTheme.of(context).primary, PersonalTheme.of(context).tertiary],
                stops: const [0.0, 1.0],
                begin: const AlignmentDirectional(0.0, -1.0),
                end: const AlignmentDirectional(0, 1.0),
              ),
            ),
          ),
          Center(
            child: Column(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  width: _isPress ? screenWidth : 0,
                  height: hpart / 1.5,
                  child: Center(
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Image.asset(
                            'assets/images/home/Nube.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                        Opacity(
                          opacity: _isPress ? 1 : 0,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: SizedBox(
                              width: wpart, // Ajusta el ancho máximo del texto aquí
                              child: FutureBuilder<String>(
                                future: _homeController.fraseRandom(),
                                builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                  if (snapshot.hasData) {
                                    return Wrap(
                                      children: [
                                        Text(
                                          "\n¿Sabias que?\n${snapshot.data}",
                                          style: PersonalTheme.of(context).titleMedium.override(
                                              fontFamily: 'Poppins',
                                              color: PersonalTheme.of(context).primaryBackground,
                                              fontSize: screenWidth >= 450 ? 20 : 17),
                                          textAlign: TextAlign.justify,
                                        ),
                                      ],
                                    );
                                  } else {
                                    return Text(
                                      'Cargando frase...',
                                      style: PersonalTheme.of(context).titleMedium.override(
                                          fontFamily: 'Poppins',
                                          color: PersonalTheme.of(context).primaryBackground,
                                          fontSize: 20),
                                      textAlign: TextAlign.justify,
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    setState(() {
                      _homeController.interaccionesAV();
                    });
                    changeState();
                    await Future.delayed(const Duration(seconds: 6));
                    changeState();
                  },
                  child: idAV == 0
                      ? const CircularProgressIndicator()
                      : Image.asset(
                          'assets/images/AV/$idAV.png',
                          fit: BoxFit.contain,
                          height: wpart,
                          //width: wpart,
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
