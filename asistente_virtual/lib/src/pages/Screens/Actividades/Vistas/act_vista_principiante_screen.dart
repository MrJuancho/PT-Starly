// ignore_for_file: library_private_types_in_public_api

import 'package:asistente_virtual/src/pages/Controllers/Estadistics_controller.dart';
import 'package:asistente_virtual/src/pages/Widgets/_Instrucciones_widget.dart';
import 'package:asistente_virtual/src/pages/Widgets/_Resultados_widget.dart';
import 'package:asistente_virtual/src/pages/Widgets/_botonAsistencia_widget.dart';
import 'package:asistente_virtual/src/pages/Widgets/_Estadisticas_widget.dart';
import 'package:asistente_virtual/src/pages/Widgets/_vistaImagenExpandida.dart';
import 'package:asistente_virtual/src/utils/utils_snackbar.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';
import 'package:marquee_widget/marquee_widget.dart';
import '../../../../utils/utils_preferences.dart';
import '../../../flutter_flow/Theme_Personal.dart';

class ActVistasPrincipiantePage extends StatefulWidget {
  const ActVistasPrincipiantePage({
    Key? key,
    String? counter,
  })  : counter = counter ?? '0',
        super(key: key);

  final String counter;

  @override
  _ActVistasPrincipianteState createState() => _ActVistasPrincipianteState();
}

class _ActVistasPrincipianteState extends State<ActVistasPrincipiantePage> {
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
                'Se muestra una serie de figuras en 3D en la parte superior de la pantalla, seleccionar la vista que corresponde a la vista aérea de la figura mostrada. En caso de no existir en las opciones, buscar una vista lateral.\nDificultad Principante',
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
              'Vistas principiante',
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
                                            Padding(
                                              padding: const EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor: Colors.transparent,
                                                onLongPress: () async {
                                                  await Navigator.push(
                                                    context,
                                                    PageTransition(
                                                      type: PageTransitionType.fade,
                                                      child: ExpandedImageView(
                                                        image: Image.asset(
                                                          'assets/images/Actividades/Vistas/Act_Vistas_Principiante/vistas1-1Desc.jpg',
                                                          fit: BoxFit.contain,
                                                        ),
                                                        allowRotation: false,
                                                        tag: 'imageTag1',
                                                        useHeroAnimation: true,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Hero(
                                                  tag: 'imageTag1',
                                                  transitionOnUserGestures: true,
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(8.0),
                                                    child: Image.asset(
                                                      'assets/images/Actividades/Vistas/Act_Vistas_Principiante/vistas1-1Desc.jpg',
                                                      width: screenWidth * 1.0,
                                                      height: screenHeight * 0.15,
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                ),
                                              ),
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
                                                            'assets/images/Actividades/Vistas/Act_Vistas_Principiante/vistas1-1-1.jpg',
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
                                                            'assets/images/Actividades/Vistas/Act_Vistas_Principiante/vistas1-1-2.jpg',
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
                                                            'assets/images/Actividades/Vistas/Act_Vistas_Principiante/vistas1-1-3.jpg',
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
                                            Padding(
                                              padding: const EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor: Colors.transparent,
                                                onLongPress: () async {
                                                  await Navigator.push(
                                                    context,
                                                    PageTransition(
                                                      type: PageTransitionType.fade,
                                                      child: ExpandedImageView(
                                                        image: Image.asset(
                                                          'assets/images/Actividades/Vistas/Act_Vistas_Principiante/vistas1-2Desc.jpg',
                                                          fit: BoxFit.contain,
                                                        ),
                                                        allowRotation: false,
                                                        tag: 'imageTag5',
                                                        useHeroAnimation: true,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Hero(
                                                  tag: 'imageTag5',
                                                  transitionOnUserGestures: true,
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(8.0),
                                                    child: Image.asset(
                                                      'assets/images/Actividades/Vistas/Act_Vistas_Principiante/vistas1-2Desc.jpg',
                                                      width: screenWidth * 1.0,
                                                      height: screenHeight * 0.15,
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                ),
                                              ),
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
                                                            'assets/images/Actividades/Vistas/Act_Vistas_Principiante/vistas1-2-1.jpg',
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
                                                            'assets/images/Actividades/Vistas/Act_Vistas_Principiante/vistas1-2-2.jpg',
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
                                                            'assets/images/Actividades/Vistas/Act_Vistas_Principiante/vistas1-2-3.jpg',
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
                                            Padding(
                                              padding: const EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor: Colors.transparent,
                                                onLongPress: () async {
                                                  await Navigator.push(
                                                    context,
                                                    PageTransition(
                                                      type: PageTransitionType.fade,
                                                      child: ExpandedImageView(
                                                        image: Image.asset(
                                                          'assets/images/Actividades/Vistas/Act_Vistas_Principiante/vistas1-3Desc.jpg',
                                                          fit: BoxFit.contain,
                                                        ),
                                                        allowRotation: false,
                                                        tag: 'imageTag9',
                                                        useHeroAnimation: true,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Hero(
                                                  tag: 'imageTag9',
                                                  transitionOnUserGestures: true,
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(8.0),
                                                    child: Image.asset(
                                                      'assets/images/Actividades/Vistas/Act_Vistas_Principiante/vistas1-3Desc.jpg',
                                                      width: screenWidth * 1.0,
                                                      height: screenHeight * 0.15,
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                ),
                                              ),
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
                                                    if (correctas < 3) {
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
                                                            'assets/images/Actividades/Vistas/Act_Vistas_Principiante/vistas1-3-1.jpg',
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
                                                    if (correctas < 3) {
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
                                                            'assets/images/Actividades/Vistas/Act_Vistas_Principiante/vistas1-3-2.jpg',
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
                                                    correctas += 1;
                                                    if (correctas == 3) {
                                                      incrementarIntentos();
                                                      _estadisticsController.stopTimer();
                                                      resultados();
                                                      _estadisticsController.registroResultados(61, intentos, ayudas,
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
                                                            'assets/images/Actividades/Vistas/Act_Vistas_Principiante/vistas1-3-3.jpg',
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
        floatingActionButton: AyudasWidget.build(context, _estadisticsController, 18, incrementarAyudas),
        //bottomNavigationBar: MenuInferior(),
      ),
    );
  }
}
