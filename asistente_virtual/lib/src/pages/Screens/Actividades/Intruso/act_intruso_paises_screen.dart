// ignore_for_file: library_private_types_in_public_api

import 'package:asistente_virtual/src/pages/Controllers/Estadistics_controller.dart';
import 'package:asistente_virtual/src/pages/Widgets/_Instrucciones_widget.dart';
import 'package:asistente_virtual/src/pages/Widgets/_Resultados_widget.dart';
import 'package:asistente_virtual/src/pages/Widgets/_botonAsistencia_widget.dart';
import 'package:asistente_virtual/src/pages/Widgets/_Estadisticas_widget.dart';
import 'package:asistente_virtual/src/pages/Widgets/_vistaImagenExpandida.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';
import 'package:marquee_widget/marquee_widget.dart';
import '../../../../utils/utils_preferences.dart';
import '../../../flutter_flow/Theme_Personal.dart';

class ActIntrusoPaisesPage extends StatefulWidget {
  const ActIntrusoPaisesPage({
    Key? key,
    String? counter,
  })  : counter = counter ?? '0',
        super(key: key);

  final String counter;

  @override
  _ActIntrusoPaisesState createState() => _ActIntrusoPaisesState();
}

class _ActIntrusoPaisesState extends State<ActIntrusoPaisesPage> {
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
        ? _actividad(context,screenWidth, screenHeight  )
        : _activityFinished
            ? ResultadosWidget.show(
                context, intentos, ayudas, _estadisticsController.formatMilliseconds(), _estadisticsController,screenWidth, screenHeight)
            : InstruccionesWidget.show(
                context, _estadisticsController, presionado, 'Encontrar el pais que no pertenece al continente.',screenWidth, screenHeight);
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
              'Intruso del país que no pertenece al continente',
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
                            crossAxisCount: 5,
                            crossAxisSpacing: 3.0,
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
                                //AQUI
                                incrementarIntentos();
                                if (correctas == 3) {
                                  _estadisticsController.stopTimer();
                                  resultados();
                                  _estadisticsController.registroResultados(
                                      23, intentos, ayudas, _estadisticsController.formatMilliseconds());
                                } else {
                                  correctas += 1;
                                }
                              },
                              onLongPress: () async {
                                await Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    child: ExpandedImageView(
                                      image: Image.asset(
                                        'assets/images/Actividades/Intruso/Act_Intruso_Paises/pais1.png',
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
                                child: Image.asset(
                                  'assets/images/Actividades/Intruso/Act_Intruso_Paises/pais1.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                incrementarIntentos();
                              },
                              onLongPress: () async {
                                await Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    child: ExpandedImageView(
                                      image: Image.asset(
                                        'assets/images/Actividades/Intruso/Act_Intruso_Paises/pais2.png',
                                        fit: BoxFit.contain,
                                      ),
                                      allowRotation: false,
                                      tag: 'imageTag2',
                                      useHeroAnimation: true,
                                    ),
                                  ),
                                );
                              },
                              child: Hero(
                                tag: 'imageTag2',
                                transitionOnUserGestures: true,
                                child: Image.asset(
                                  'assets/images/Actividades/Intruso/Act_Intruso_Paises/pais2.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                incrementarIntentos();
                              },
                              onLongPress: () async {
                                await Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    child: ExpandedImageView(
                                      image: Image.asset(
                                        'assets/images/Actividades/Intruso/Act_Intruso_Paises/pais3.png',
                                        fit: BoxFit.contain,
                                      ),
                                      allowRotation: false,
                                      tag: 'imageTag3',
                                      useHeroAnimation: true,
                                    ),
                                  ),
                                );
                              },
                              child: Hero(
                                tag: 'imageTag3',
                                transitionOnUserGestures: true,
                                child: Image.asset(
                                  'assets/images/Actividades/Intruso/Act_Intruso_Paises/pais3.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                incrementarIntentos();
                              },
                              onLongPress: () async {
                                await Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    child: ExpandedImageView(
                                      image: Image.asset(
                                        'assets/images/Actividades/Intruso/Act_Intruso_Paises/pais4.png',
                                        fit: BoxFit.contain,
                                      ),
                                      allowRotation: false,
                                      tag: 'imageTag4',
                                      useHeroAnimation: true,
                                    ),
                                  ),
                                );
                              },
                              child: Hero(
                                tag: 'imageTag4',
                                transitionOnUserGestures: true,
                                child: Image.asset(
                                  'assets/images/Actividades/Intruso/Act_Intruso_Paises/pais4.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                incrementarIntentos();
                              },
                              onLongPress: () async {
                                await Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    child: ExpandedImageView(
                                      image: Image.asset(
                                        'assets/images/Actividades/Intruso/Act_Intruso_Paises/pais5.png',
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
                                child: Image.asset(
                                  'assets/images/Actividades/Intruso/Act_Intruso_Paises/pais5.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                incrementarIntentos();
                              },
                              onLongPress: () async {
                                await Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    child: ExpandedImageView(
                                      image: Image.asset(
                                        'assets/images/Actividades/Intruso/Act_Intruso_Paises/pais6.png',
                                        fit: BoxFit.contain,
                                      ),
                                      allowRotation: false,
                                      tag: 'imageTag6',
                                      useHeroAnimation: true,
                                    ),
                                  ),
                                );
                              },
                              child: Hero(
                                tag: 'imageTag6',
                                transitionOnUserGestures: true,
                                child: Image.asset(
                                  'assets/images/Actividades/Intruso/Act_Intruso_Paises/pais6.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                incrementarIntentos();
                              },
                              onLongPress: () async {
                                await Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    child: ExpandedImageView(
                                      image: Image.asset(
                                        'assets/images/Actividades/Intruso/Act_Intruso_Paises/pais7.png',
                                        fit: BoxFit.contain,
                                      ),
                                      allowRotation: false,
                                      tag: 'imageTag7',
                                      useHeroAnimation: true,
                                    ),
                                  ),
                                );
                              },
                              child: Hero(
                                tag: 'imageTag7',
                                transitionOnUserGestures: true,
                                child: Image.asset(
                                  'assets/images/Actividades/Intruso/Act_Intruso_Paises/pais7.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                //AQUI
                                incrementarIntentos();
                                if (correctas == 3) {
                                  _estadisticsController.stopTimer();
                                  resultados();
                                  _estadisticsController.registroResultados(
                                      23, intentos, ayudas, _estadisticsController.formatMilliseconds());
                                } else {
                                  correctas += 1;
                                }
                              },
                              onLongPress: () async {
                                await Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    child: ExpandedImageView(
                                      image: Image.asset(
                                        'assets/images/Actividades/Intruso/Act_Intruso_Paises/pais8.png',
                                        fit: BoxFit.contain,
                                      ),
                                      allowRotation: false,
                                      tag: 'imageTag8',
                                      useHeroAnimation: true,
                                    ),
                                  ),
                                );
                              },
                              child: Hero(
                                tag: 'imageTag8',
                                transitionOnUserGestures: true,
                                child: Image.asset(
                                  'assets/images/Actividades/Intruso/Act_Intruso_Paises/pais8.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                incrementarIntentos();
                              },
                              onLongPress: () async {
                                await Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    child: ExpandedImageView(
                                      image: Image.asset(
                                        'assets/images/Actividades/Intruso/Act_Intruso_Paises/pais9.png',
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
                                child: Image.asset(
                                  'assets/images/Actividades/Intruso/Act_Intruso_Paises/pais9.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                incrementarIntentos();
                              },
                              onLongPress: () async {
                                await Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    child: ExpandedImageView(
                                      image: Image.asset(
                                        'assets/images/Actividades/Intruso/Act_Intruso_Paises/pais10.png',
                                        fit: BoxFit.contain,
                                      ),
                                      allowRotation: false,
                                      tag: 'imageTag10',
                                      useHeroAnimation: true,
                                    ),
                                  ),
                                );
                              },
                              child: Hero(
                                tag: 'imageTag10',
                                transitionOnUserGestures: true,
                                child: Image.asset(
                                  'assets/images/Actividades/Intruso/Act_Intruso_Paises/pais10.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                incrementarIntentos();
                              },
                              onLongPress: () async {
                                await Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    child: ExpandedImageView(
                                      image: Image.asset(
                                        'assets/images/Actividades/Intruso/Act_Intruso_Paises/pais11.png',
                                        fit: BoxFit.contain,
                                      ),
                                      allowRotation: false,
                                      tag: 'imageTag11',
                                      useHeroAnimation: true,
                                    ),
                                  ),
                                );
                              },
                              child: Hero(
                                tag: 'imageTag11',
                                transitionOnUserGestures: true,
                                child: Image.asset(
                                  'assets/images/Actividades/Intruso/Act_Intruso_Paises/pais11.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                incrementarIntentos();
                              },
                              onLongPress: () async {
                                await Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    child: ExpandedImageView(
                                      image: Image.asset(
                                        'assets/images/Actividades/Intruso/Act_Intruso_Paises/pais12.png',
                                        fit: BoxFit.contain,
                                      ),
                                      allowRotation: false,
                                      tag: 'imageTag12',
                                      useHeroAnimation: true,
                                    ),
                                  ),
                                );
                              },
                              child: Hero(
                                tag: 'imageTag12',
                                transitionOnUserGestures: true,
                                child: Image.asset(
                                  'assets/images/Actividades/Intruso/Act_Intruso_Paises/pais12.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                incrementarIntentos();
                              },
                              onLongPress: () async {
                                await Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    child: ExpandedImageView(
                                      image: Image.asset(
                                        'assets/images/Actividades/Intruso/Act_Intruso_Paises/pais13.png',
                                        fit: BoxFit.contain,
                                      ),
                                      allowRotation: false,
                                      tag: 'imageTag13',
                                      useHeroAnimation: true,
                                    ),
                                  ),
                                );
                              },
                              child: Hero(
                                tag: 'imageTag13',
                                transitionOnUserGestures: true,
                                child: Image.asset(
                                  'assets/images/Actividades/Intruso/Act_Intruso_Paises/pais13.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                //AQUI
                                incrementarIntentos();
                                if (correctas == 3) {
                                  _estadisticsController.stopTimer();
                                  resultados();
                                  _estadisticsController.registroResultados(
                                      23, intentos, ayudas, _estadisticsController.formatMilliseconds());
                                } else {
                                  correctas += 1;
                                }
                              },
                              onLongPress: () async {
                                await Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    child: ExpandedImageView(
                                      image: Image.asset(
                                        'assets/images/Actividades/Intruso/Act_Intruso_Paises/pais14.png',
                                        fit: BoxFit.contain,
                                      ),
                                      allowRotation: false,
                                      tag: 'imageTag14',
                                      useHeroAnimation: true,
                                    ),
                                  ),
                                );
                              },
                              child: Hero(
                                tag: 'imageTag14',
                                transitionOnUserGestures: true,
                                child: Image.asset(
                                  'assets/images/Actividades/Intruso/Act_Intruso_Paises/pais14.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                incrementarIntentos();
                              },
                              onLongPress: () async {
                                await Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    child: ExpandedImageView(
                                      image: Image.asset(
                                        'assets/images/Actividades/Intruso/Act_Intruso_Paises/pais15.png',
                                        fit: BoxFit.contain,
                                      ),
                                      allowRotation: false,
                                      tag: 'imageTag15',
                                      useHeroAnimation: true,
                                    ),
                                  ),
                                );
                              },
                              child: Hero(
                                tag: 'imageTag15',
                                transitionOnUserGestures: true,
                                child: Image.asset(
                                  'assets/images/Actividades/Intruso/Act_Intruso_Paises/pais15.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                incrementarIntentos();
                              },
                              onLongPress: () async {
                                await Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    child: ExpandedImageView(
                                      image: Image.asset(
                                        'assets/images/Actividades/Intruso/Act_Intruso_Paises/pais16.png',
                                        fit: BoxFit.contain,
                                      ),
                                      allowRotation: false,
                                      tag: 'imageTag16',
                                      useHeroAnimation: true,
                                    ),
                                  ),
                                );
                              },
                              child: Hero(
                                tag: 'imageTag16',
                                transitionOnUserGestures: true,
                                child: Image.asset(
                                  'assets/images/Actividades/Intruso/Act_Intruso_Paises/pais16.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                incrementarIntentos();
                              },
                              onLongPress: () async {
                                await Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    child: ExpandedImageView(
                                      image: Image.asset(
                                        'assets/images/Actividades/Intruso/Act_Intruso_Paises/pais17.png',
                                        fit: BoxFit.contain,
                                      ),
                                      allowRotation: false,
                                      tag: 'imageTag17',
                                      useHeroAnimation: true,
                                    ),
                                  ),
                                );
                              },
                              child: Hero(
                                tag: 'imageTag17',
                                transitionOnUserGestures: true,
                                child: Image.asset(
                                  'assets/images/Actividades/Intruso/Act_Intruso_Paises/pais17.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                incrementarIntentos();
                              },
                              onLongPress: () async {
                                await Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    child: ExpandedImageView(
                                      image: Image.asset(
                                        'assets/images/Actividades/Intruso/Act_Intruso_Paises/pais18.png',
                                        fit: BoxFit.contain,
                                      ),
                                      allowRotation: false,
                                      tag: 'imageTag18',
                                      useHeroAnimation: true,
                                    ),
                                  ),
                                );
                              },
                              child: Hero(
                                tag: 'imageTag18',
                                transitionOnUserGestures: true,
                                child: Image.asset(
                                  'assets/images/Actividades/Intruso/Act_Intruso_Paises/pais18.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                incrementarIntentos();
                              },
                              onLongPress: () async {
                                await Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    child: ExpandedImageView(
                                      image: Image.asset(
                                        'assets/images/Actividades/Intruso/Act_Intruso_Paises/pais19.png',
                                        fit: BoxFit.contain,
                                      ),
                                      allowRotation: false,
                                      tag: 'imageTag19',
                                      useHeroAnimation: true,
                                    ),
                                  ),
                                );
                              },
                              child: Hero(
                                tag: 'imageTag19',
                                transitionOnUserGestures: true,
                                child: Image.asset(
                                  'assets/images/Actividades/Intruso/Act_Intruso_Paises/pais19.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                //AQUI
                                incrementarIntentos();
                                if (correctas == 3) {
                                  _estadisticsController.stopTimer();
                                  resultados();
                                  _estadisticsController.registroResultados(
                                      23, intentos, ayudas, _estadisticsController.formatMilliseconds());
                                } else {
                                  correctas += 1;
                                }
                              },
                              onLongPress: () async {
                                await Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    child: ExpandedImageView(
                                      image: Image.asset(
                                        'assets/images/Actividades/Intruso/Act_Intruso_Paises/pais20.png',
                                        fit: BoxFit.contain,
                                      ),
                                      allowRotation: false,
                                      tag: 'imageTag20',
                                      useHeroAnimation: true,
                                    ),
                                  ),
                                );
                              },
                              child: Hero(
                                tag: 'imageTag20',
                                transitionOnUserGestures: true,
                                child: Image.asset(
                                  'assets/images/Actividades/Intruso/Act_Intruso_Paises/pais20.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.fitWidth,
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
        floatingActionButton: AyudasWidget.build(context, _estadisticsController, 32, incrementarAyudas),
        //bottomNavigationBar: MenuInferior(),
      ),
    );
  }
}
