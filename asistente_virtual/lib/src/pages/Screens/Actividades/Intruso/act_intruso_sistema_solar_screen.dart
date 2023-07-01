// ignore_for_file: library_private_types_in_public_api

import 'package:asistente_virtual/src/pages/Controllers/Estadistics_controller.dart';
import 'package:asistente_virtual/src/pages/Widgets/_Instrucciones_widget.dart';
import 'package:asistente_virtual/src/pages/Widgets/_Resultados_widget.dart';
import 'package:asistente_virtual/src/pages/Widgets/_botonAsistencia_widget.dart';
import 'package:asistente_virtual/src/pages/Widgets/_Estadisticas_widget.dart';
import 'package:asistente_virtual/src/utils/utils_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:marquee_widget/marquee_widget.dart';
import '../../../../utils/utils_preferences.dart';
import '../../../flutter_flow/Theme_Personal.dart';

class ActIntrusoSistemaSolarPage extends StatefulWidget {
  const ActIntrusoSistemaSolarPage({
    Key? key,
    String? counter,
  })  : counter = counter ?? '0',
        super(key: key);

  final String counter;

  @override
  _ActIntrusoSistemaSolarState createState() => _ActIntrusoSistemaSolarState();
}

class _ActIntrusoSistemaSolarState extends State<ActIntrusoSistemaSolarPage> {
  final PageController _pageController = PageController();
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

  void goToNextPage() {
    if (_pageController.page != null) {
      final nextPage = _pageController.page!.toInt() + 1;
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void goToFirstPage() {
    _pageController.animateToPage(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
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
                'Identificar que luna o cuerpo celeste no pertenece a la zona del sistema solar.',
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
              'Encontrar el intruso en grupos del sistema solar',
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
                    child: Column(
                      children: [
                        Expanded(
                          child: SizedBox(
                            width: screenWidth,
                            height: screenHeight,
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 20.0),
                                  child: PageView(
                                    controller: _pageController,
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      Container(
                                        decoration: const BoxDecoration(),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    goToNextPage();
                                                    incrementarIntentos();
                                                  },
                                                  child: Container(
                                                    width: screenWidth * 0.5,
                                                    height: screenHeight * 0.2,
                                                    decoration: const BoxDecoration(),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.max,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius: BorderRadius.circular(8.0),
                                                          child: Image.asset(
                                                            'assets/images/Actividades/Intruso/Act_Intruso_Sistema_Solar/space1.png',
                                                            width: screenWidth * 0.35,
                                                            height: screenHeight * 0.15,
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ),
                                                        Text(
                                                          '1',
                                                          style: PersonalTheme.of(context).titleMedium.override(
                                                                fontFamily: 'Readex Pro',
                                                                color: PersonalTheme.of(context).primaryText,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    goToNextPage();
                                                    incrementarIntentos();
                                                    
                                                  },
                                                  child: Container(
                                                    width: screenWidth * 0.5,
                                                    height: screenHeight * 0.2,
                                                    decoration: const BoxDecoration(),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.max,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius: BorderRadius.circular(8.0),
                                                          child: Image.asset(
                                                            'assets/images/Actividades/Intruso/Act_Intruso_Sistema_Solar/space2.png',
                                                            width: screenWidth * 0.35,
                                                            height: screenHeight * 0.15,
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ),
                                                        Text(
                                                          '2',
                                                          style: PersonalTheme.of(context).titleMedium.override(
                                                                fontFamily: 'Readex Pro',
                                                                color: PersonalTheme.of(context).primaryText,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            screenWidth >= 450
                                                ? const SizedBox(
                                                    height: 30,
                                                  )
                                                : const SizedBox(
                                                    height: 10,
                                                  ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    goToNextPage();
                                                    incrementarIntentos();
                                                    correctas += 1;
                                                  },
                                                  child: Container(
                                                    width: screenWidth * 0.5,
                                                    height: screenHeight * 0.2,
                                                    decoration: const BoxDecoration(),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.max,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius: BorderRadius.circular(8.0),
                                                          child: Image.asset(
                                                            'assets/images/Actividades/Intruso/Act_Intruso_Sistema_Solar/space3.png',
                                                            width: screenWidth * 0.35,
                                                            height: screenHeight * 0.15,
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ),
                                                        Text(
                                                          '3',
                                                          style: PersonalTheme.of(context).titleMedium.override(
                                                                fontFamily: 'Readex Pro',
                                                                color: PersonalTheme.of(context).primaryText,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        decoration: const BoxDecoration(),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    goToNextPage();
                                                    incrementarIntentos();
                                                    correctas += 1;
                                                  },
                                                  child: Container(
                                                    width: screenWidth * 0.5,
                                                    height: screenHeight * 0.2,
                                                    decoration: const BoxDecoration(),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.max,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius: BorderRadius.circular(8.0),
                                                          child: Image.asset(
                                                            'assets/images/Actividades/Intruso/Act_Intruso_Sistema_Solar/space4.png',
                                                            width: screenWidth * 0.35,
                                                            height: screenHeight * 0.15,
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ),
                                                        Text(
                                                          '1',
                                                          style: PersonalTheme.of(context).titleMedium.override(
                                                                fontFamily: 'Readex Pro',
                                                                color: PersonalTheme.of(context).primaryText,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    goToNextPage();
                                                    incrementarIntentos();
                                                  },
                                                  child: Container(
                                                    width: screenWidth * 0.5,
                                                    height: screenHeight * 0.2,
                                                    decoration: const BoxDecoration(),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.max,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius: BorderRadius.circular(8.0),
                                                          child: Image.asset(
                                                            'assets/images/Actividades/Intruso/Act_Intruso_Sistema_Solar/space5.png',
                                                            width: screenWidth * 0.35,
                                                            height: screenHeight * 0.15,
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ),
                                                        Text(
                                                          '2',
                                                          style: PersonalTheme.of(context).titleMedium.override(
                                                                fontFamily: 'Readex Pro',
                                                                color: PersonalTheme.of(context).primaryText,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            screenWidth >= 450
                                                ? const SizedBox(
                                                    height: 30,
                                                  )
                                                : const SizedBox(
                                                    height: 10,
                                                  ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    goToNextPage();
                                                    incrementarIntentos();
                                                  },
                                                  child: Container(
                                                    width: screenWidth * 0.5,
                                                    height: screenHeight * 0.2,
                                                    decoration: const BoxDecoration(),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.max,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius: BorderRadius.circular(8.0),
                                                          child: Image.asset(
                                                            'assets/images/Actividades/Intruso/Act_Intruso_Sistema_Solar/space6.png',
                                                            width: screenWidth * 0.35,
                                                            height: screenHeight * 0.15,
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ),
                                                        Text(
                                                          '3',
                                                          style: PersonalTheme.of(context).titleMedium.override(
                                                                fontFamily: 'Readex Pro',
                                                                color: PersonalTheme.of(context).primaryText,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        decoration: const BoxDecoration(),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    goToNextPage();
                                                    incrementarIntentos();
                                                  },
                                                  child: Container(
                                                    width: screenWidth * 0.5,
                                                    height: screenHeight * 0.2,
                                                    decoration: const BoxDecoration(),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.max,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius: BorderRadius.circular(8.0),
                                                          child: Image.asset(
                                                            'assets/images/Actividades/Intruso/Act_Intruso_Sistema_Solar/space7.png',
                                                            width: screenWidth * 0.35,
                                                            height: screenHeight * 0.15,
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ),
                                                        Text(
                                                          '1',
                                                          style: PersonalTheme.of(context).titleMedium.override(
                                                                fontFamily: 'Readex Pro',
                                                                color: PersonalTheme.of(context).primaryText,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    goToNextPage();
                                                    incrementarIntentos();
                                                  },
                                                  child: Container(
                                                    width: screenWidth * 0.5,
                                                    height: screenHeight * 0.2,
                                                    decoration: const BoxDecoration(),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.max,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius: BorderRadius.circular(8.0),
                                                          child: Image.asset(
                                                            'assets/images/Actividades/Intruso/Act_Intruso_Sistema_Solar/space8.png',
                                                            width: screenWidth * 0.35,
                                                            height: screenHeight * 0.15,
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ),
                                                        Text(
                                                          '2',
                                                          style: PersonalTheme.of(context).titleMedium.override(
                                                                fontFamily: 'Readex Pro',
                                                                color: PersonalTheme.of(context).primaryText,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            screenWidth >= 450
                                                ? const SizedBox(
                                                    height: 30,
                                                  )
                                                : const SizedBox(
                                                    height: 10,
                                                  ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    goToNextPage();
                                                    incrementarIntentos();
                                                    correctas += 1;
                                                  },
                                                  child: Container(
                                                    width: screenWidth * 0.5,
                                                    height: screenHeight * 0.2,
                                                    decoration: const BoxDecoration(),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.max,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius: BorderRadius.circular(8.0),
                                                          child: Image.asset(
                                                            'assets/images/Actividades/Intruso/Act_Intruso_Sistema_Solar/space9.png',
                                                            width: screenWidth * 0.35,
                                                            height: screenHeight * 0.15,
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ),
                                                        Text(
                                                          '3',
                                                          style: PersonalTheme.of(context).titleMedium.override(
                                                                fontFamily: 'Readex Pro',
                                                                color: PersonalTheme.of(context).primaryText,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        decoration: const BoxDecoration(),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    correctas += 1;
                                                    if (correctas == 4) {
                                                      incrementarIntentos();
                                                      _estadisticsController.stopTimer();
                                                      resultados();
                                                      _estadisticsController.registroResultados(15, intentos, ayudas,
                                                          _estadisticsController.formatMilliseconds());
                                                    } else {
                                                      incrementarIntentos();
                                                      correctas = 0;
                                                      goToFirstPage();
                                                      UtilsSnackbar.show(context,
                                                          'Tienes una o más respuestas incorrectas, intentalo de nuevo.',4);
                                                    }
                                                    
                                                  },
                                                  child: Container(
                                                    width: screenWidth * 0.5,
                                                    height: screenHeight * 0.2,
                                                    decoration: const BoxDecoration(),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.max,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius: BorderRadius.circular(8.0),
                                                          child: Image.asset(
                                                            'assets/images/Actividades/Intruso/Act_Intruso_Sistema_Solar/space10.png',
                                                            width: screenWidth * 0.35,
                                                            height: screenHeight * 0.15,
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ),
                                                        Text(
                                                          '1',
                                                          style: PersonalTheme.of(context).titleMedium.override(
                                                                fontFamily: 'Readex Pro',
                                                                color: PersonalTheme.of(context).primaryText,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    if (correctas < 4) {
                                                      incrementarIntentos();
                                                      correctas = 0;
                                                      goToFirstPage();
                                                      UtilsSnackbar.show(context,
                                                          'Tienes una o más respuestas incorrectas, intentalo de nuevo.',4);
                                                    }
                                                  },
                                                  child: Container(
                                                    width: screenWidth * 0.5,
                                                    height: screenHeight * 0.2,
                                                    decoration: const BoxDecoration(),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.max,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius: BorderRadius.circular(8.0),
                                                          child: Image.asset(
                                                            'assets/images/Actividades/Intruso/Act_Intruso_Sistema_Solar/space11.png',
                                                            width: screenWidth * 0.35,
                                                            height: screenHeight * 0.15,
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ),
                                                        Text(
                                                          '2',
                                                          style: PersonalTheme.of(context).titleMedium.override(
                                                                fontFamily: 'Readex Pro',
                                                                color: PersonalTheme.of(context).primaryText,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            screenWidth >= 450
                                                ? const SizedBox(
                                                    height: 30,
                                                  )
                                                : const SizedBox(
                                                    height: 10,
                                                  ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    if (correctas < 4) {
                                                      incrementarIntentos();
                                                      correctas = 0;
                                                      goToFirstPage();
                                                      UtilsSnackbar.show(context,
                                                          'Tienes una o más respuestas incorrectas, intentalo de nuevo.',4);
                                                    }
                                                  },
                                                  child: Container(
                                                    width: screenWidth * 0.5,
                                                    height: screenHeight * 0.2,
                                                    decoration: const BoxDecoration(),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.max,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius: BorderRadius.circular(8.0),
                                                          child: Image.asset(
                                                            'assets/images/Actividades/Intruso/Act_Intruso_Sistema_Solar/space12.png',
                                                            width: screenWidth * 0.35,
                                                            height: screenHeight * 0.15,
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ),
                                                        Text(
                                                          '3',
                                                          style: PersonalTheme.of(context).titleMedium.override(
                                                                fontFamily: 'Readex Pro',
                                                                color: PersonalTheme.of(context).primaryText,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                EstadisticasWidget.build(context, intentos, ayudas, _estadisticsController),
              ],
            ),
          ),
        ),
        floatingActionButton: AyudasWidget.build(context, _estadisticsController, 25, incrementarAyudas),
        //bottomNavigationBar: MenuInferior(),
      ),
    );
  }
}
