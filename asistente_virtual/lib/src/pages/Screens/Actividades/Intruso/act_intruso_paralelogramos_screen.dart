// ignore_for_file: library_private_types_in_public_api

import 'package:asistente_virtual/src/pages/Controllers/Estadistics_controller.dart';
import 'package:asistente_virtual/src/pages/Widgets/_Instrucciones_widget.dart';
import 'package:asistente_virtual/src/pages/Widgets/_Resultados_widget.dart';
import 'package:asistente_virtual/src/pages/Widgets/_botonAsistencia_widget.dart';
import 'package:asistente_virtual/src/pages/Widgets/_Estadisticas_widget.dart';
import 'package:flutter/material.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:asistente_virtual/src/utils/utils_preferences.dart';
import 'package:asistente_virtual/src/pages/flutter_flow/Theme_Personal.dart';

class ActIntrusoParalelogramosPage extends StatefulWidget {
  const ActIntrusoParalelogramosPage({
    Key? key,
    String? counter,
  })  : counter = counter ?? '0',
        super(key: key);

  final String counter;

  @override
  _ActIntrusoParalelogramosState createState() => _ActIntrusoParalelogramosState();
}

class _ActIntrusoParalelogramosState extends State<ActIntrusoParalelogramosPage> {
  final EstadisticsController _estadisticsController = EstadisticsController();
  bool _startPressed = false;
  bool _activityFinished = false;
  int correctas = 0;
  int intentos = 0;
  int ayudas = 0;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _estadisticsController.dispose();
    _unfocusNode.dispose();
    super.dispose();
  }

  void incrementarIntentos() {
    setState(() {
      intentos++;
    });
  }

  void incrementarAyudas() {
    setState(() {
      ayudas++;
    });
  }

  void presionado() {
    setState(() {
      _startPressed = true;
      _estadisticsController.startTimer();
    });
  }

  void resultados() {
    setState(() {
      _startPressed = false;
      _activityFinished = true;
      _estadisticsController.sumamonedas();
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    const reducedwindowWidth = 500.00;
    const reducedwindowHeight = 900.00;

    if (screenWidth >= 450) {
      return SizedBox(
        height: reducedwindowHeight,
        width: reducedwindowWidth,
        child: Center(child: eleccion(reducedwindowWidth, reducedwindowHeight)),
      );
    } else {
      return eleccion(screenWidth, screenHeight);
    }
  }

  Widget eleccion(double screenWidth, double screenHeight) {
    return _startPressed
        ? _actividad(context, screenWidth, screenHeight)
        : _activityFinished
            ? ResultadosWidget.show(context, intentos, ayudas, _estadisticsController.formatMilliseconds(),
                _estadisticsController, screenWidth, screenHeight)
            : InstruccionesWidget.show(
                context,
                _estadisticsController,
                presionado,
                'Identificar de las 4 figuras que se mostraran quien no es un paralelogramo',
                screenWidth,
                screenHeight);
  }

  Widget _actividad(BuildContext context, double screenWidth, double screenHeight) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: PersonalTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: PersonalTheme.of(context).primary,
          elevation: 2,
          centerTitle: true,
          title: Marquee(
            forwardAnimation: Curves.easeIn,
            autoRepeat: true,
            direction: Axis.horizontal,
            textDirection: TextDirection.ltr,
            animationDuration: const Duration(seconds: 2),
            backDuration: const Duration(milliseconds: 1000),
            pauseDuration: const Duration(milliseconds: 1000),
            directionMarguee: DirectionMarguee.TwoDirection,
            child: Text(
              '¿Quién no es un paralelogramo?',
              style: PersonalTheme.of(context).headlineMedium.override(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 22.0,
                  ),
            ),
          ),
        ),
        body: SafeArea(
          child: Visibility(
            visible: responsiveVisibility(
              context: context,
              tablet: false,
              tabletLandscape: false,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 1.0,
                    height: MediaQuery.of(context).size.height * 0.7,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [PersonalTheme.of(context).primary, PersonalTheme.of(context).tertiary],
                        stops: const [0.0, 1.0],
                        begin: const AlignmentDirectional(0.0, -1.0),
                        end: const AlignmentDirectional(0, 1.0),
                      ),
                    ),
                    child: Align(
                      alignment: const AlignmentDirectional(0.0, 0.0),
                      child: SizedBox(
                        width: screenWidth * 1.0,
                        height: screenHeight * 0.7,
                        child: GridView(
                          padding: EdgeInsets.zero,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 40.0,
                            childAspectRatio: 1.0,
                          ),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          children: [
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                setState(() {
                                  incrementarIntentos();
                                });
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(0.0),
                                child: Image.asset(
                                  'assets/images/Actividades/Intruso/Act_Intruso_Paralelogramos/Para1.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                setState(() {
                                  //AQUI
                                  incrementarIntentos();
                                  if (correctas == 2) {
                                    _estadisticsController.stopTimer();
                                    resultados();
                                    _estadisticsController.registroResultados(
                                        12, intentos, ayudas, _estadisticsController.formatMilliseconds());
                                  } else {
                                    correctas += 1;
                                  }
                                });
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(0.0),
                                child: Image.asset(
                                  'assets/images/Actividades/Intruso/Act_Intruso_Paralelogramos/Para2.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                setState(() {
                                  incrementarIntentos();
                                });
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(0.0),
                                child: Image.asset(
                                  'assets/images/Actividades/Intruso/Act_Intruso_Paralelogramos/Para3.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                setState(() {
                                  //AQUI
                                  incrementarIntentos();
                                  if (correctas == 2) {
                                    _estadisticsController.stopTimer();
                                    resultados();
                                    _estadisticsController.registroResultados(
                                        12, intentos, ayudas, _estadisticsController.formatMilliseconds());
                                  } else {
                                    correctas += 1;
                                  }
                                });
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(0.0),
                                child: Image.asset(
                                  'assets/images/Actividades/Intruso/Act_Intruso_Paralelogramos/Para4.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                setState(() {
                                  incrementarIntentos();
                                });
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(0.0),
                                child: Image.asset(
                                  'assets/images/Actividades/Intruso/Act_Intruso_Paralelogramos/Para5.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                setState(() {
                                  incrementarIntentos();
                                });
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(0.0),
                                child: Image.asset(
                                  'assets/images/Actividades/Intruso/Act_Intruso_Paralelogramos/Para6.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                setState(() {
                                  incrementarIntentos();
                                });
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(0.0),
                                child: Image.asset(
                                  'assets/images/Actividades/Intruso/Act_Intruso_Paralelogramos/Para7.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                setState(() {
                                  incrementarIntentos();
                                });
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(0.0),
                                child: Image.asset(
                                  'assets/images/Actividades/Intruso/Act_Intruso_Paralelogramos/Para8.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                setState(() {
                                  //AQUI
                                  incrementarIntentos();
                                  if (correctas == 2) {
                                    _estadisticsController.stopTimer();
                                    resultados();
                                    _estadisticsController.registroResultados(
                                        12, intentos, ayudas, _estadisticsController.formatMilliseconds());
                                  } else {
                                    correctas += 1;
                                  }
                                });
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(0.0),
                                child: Image.asset(
                                  'assets/images/Actividades/Intruso/Act_Intruso_Paralelogramos/Para9.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                EstadisticasWidget.build(context, intentos, ayudas, _estadisticsController),
              ],
            ),
          ),
        ),
        floatingActionButton: AyudasWidget.build(context, _estadisticsController, 14, incrementarAyudas),
        //bottomNavigationBar: MenuInferior(),
      ),
    );
  }
}
