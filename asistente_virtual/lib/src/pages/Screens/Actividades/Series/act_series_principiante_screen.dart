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

class ActSeriesPrincipiantePage extends StatefulWidget {
  const ActSeriesPrincipiantePage({
    Key? key,
    String? counter,
  })  : this.counter = counter ?? '0',
        super(key: key);

  final String counter;

  @override
  _ActSeriesPrincipianteState createState() => _ActSeriesPrincipianteState();
}

class _ActSeriesPrincipianteState extends State<ActSeriesPrincipiantePage> {
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
    return _startPressed
        ? _actividad(context)
        : _activityFinished
            ? ResultadosWidget.show(
                context, intentos, ayudas, _estadisticsController.formatMilliseconds(), _estadisticsController)
            : InstruccionesWidget.show(context, _estadisticsController, presionado,
                'Identificar la figura que sigue en la serie; dificultad principante');
  }

  Widget _actividad(BuildContext context) {
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
            animationDuration: Duration(seconds: 2),
            backDuration: Duration(milliseconds: 1000),
            pauseDuration: Duration(milliseconds: 1000),
            directionMarguee: DirectionMarguee.TwoDirection,
            child: Text(
              'Serie lógica principante',
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
                        stops: [0.0, 1.0],
                        begin: AlignmentDirectional(0.0, -1.0),
                        end: AlignmentDirectional(0, 1.0),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            height: 500.0,
                            child: Stack(
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 20.0),
                                  child: PageView(
                                    controller: _pageController,
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      Container(
                                        width: 100.0,
                                        height: 100.0,
                                        decoration: BoxDecoration(),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            InkWell(
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
                                                        'assets/images/Actividades/Series/Act_Series_Principiante/facil1Desc.jpg',
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
                                                    'assets/images/Actividades/Series/Act_Series_Principiante/facil1Desc.jpg',
                                                    width: MediaQuery.of(context).size.width * 1.0,
                                                    height: MediaQuery.of(context).size.height * 0.15,
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              ),
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
                                                      width: MediaQuery.of(context).size.width * 0.5,
                                                      height: MediaQuery.of(context).size.height * 0.2,
                                                      decoration: BoxDecoration(),
                                                      child: Column(
                                                        mainAxisSize: MainAxisSize.max,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius: BorderRadius.circular(8.0),
                                                            child: Image.asset(
                                                              'assets/images/Actividades/Series/Act_Series_Principiante/facil1.1.jpg',
                                                              width: MediaQuery.of(context).size.width * 0.35,
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
                                                      )),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    goToNextPage();
                                                    correctas += 1;
                                                  },
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.5,
                                                    height: MediaQuery.of(context).size.height * 0.2,
                                                    decoration: BoxDecoration(),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.max,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius: BorderRadius.circular(8.0),
                                                          child: Image.asset(
                                                            'assets/images/Actividades/Series/Act_Series_Principiante/facil1.2.jpg',
                                                            width: MediaQuery.of(context).size.width * 0.35,
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
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    goToNextPage();
                                                  },
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.5,
                                                    height: MediaQuery.of(context).size.height * 0.2,
                                                    decoration: BoxDecoration(),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.max,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius: BorderRadius.circular(8.0),
                                                          child: Image.asset(
                                                            'assets/images/Actividades/Series/Act_Series_Principiante/facil1.3.jpg',
                                                            width: MediaQuery.of(context).size.width * 0.35,
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
                                                InkWell(
                                                  onTap: () {
                                                    goToNextPage();
                                                  },
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.5,
                                                    height: MediaQuery.of(context).size.height * 0.2,
                                                    decoration: BoxDecoration(),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.max,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius: BorderRadius.circular(8.0),
                                                          child: Image.asset(
                                                            'assets/images/Actividades/Series/Act_Series_Principiante/facil1.4.jpg',
                                                            width: MediaQuery.of(context).size.width * 0.35,
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ),
                                                        Text(
                                                          '4',
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
                                        width: 100.0,
                                        height: 100.0,
                                        decoration: BoxDecoration(),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            InkWell(
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
                                                        'assets/images/Actividades/Series/Act_Series_Principiante/facil2Desc.png',
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
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(8.0),
                                                  child: Image.asset(
                                                    'assets/images/Actividades/Series/Act_Series_Principiante/facil2Desc.png',
                                                    width: MediaQuery.of(context).size.width * 1.0,
                                                    height: MediaQuery.of(context).size.height * 0.15,
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              ),
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
                                                    width: MediaQuery.of(context).size.width * 0.5,
                                                    height: MediaQuery.of(context).size.height * 0.2,
                                                    decoration: BoxDecoration(),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.max,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius: BorderRadius.circular(8.0),
                                                          child: Image.asset(
                                                            'assets/images/Actividades/Series/Act_Series_Principiante/facil2.1.png',
                                                            width: MediaQuery.of(context).size.width * 0.35,
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
                                                    width: MediaQuery.of(context).size.width * 0.5,
                                                    height: MediaQuery.of(context).size.height * 0.2,
                                                    decoration: BoxDecoration(),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.max,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius: BorderRadius.circular(8.0),
                                                          child: Image.asset(
                                                            'assets/images/Actividades/Series/Act_Series_Principiante/facil2.2.png',
                                                            width: MediaQuery.of(context).size.width * 0.35,
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
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    goToNextPage();
                                                  },
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.5,
                                                    height: MediaQuery.of(context).size.height * 0.2,
                                                    decoration: BoxDecoration(),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.max,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius: BorderRadius.circular(8.0),
                                                          child: Image.asset(
                                                            'assets/images/Actividades/Series/Act_Series_Principiante/facil2.3.png',
                                                            width: MediaQuery.of(context).size.width * 0.35,
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
                                                InkWell(
                                                  onTap: () {
                                                    goToNextPage();
                                                    correctas += 1;
                                                  },
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.5,
                                                    height: MediaQuery.of(context).size.height * 0.2,
                                                    decoration: BoxDecoration(),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.max,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius: BorderRadius.circular(8.0),
                                                          child: Image.asset(
                                                            'assets/images/Actividades/Series/Act_Series_Principiante/facil2.4.png',
                                                            width: MediaQuery.of(context).size.width * 0.35,
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ),
                                                        Text(
                                                          '4',
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
                                        width: 100.0,
                                        height: 100.0,
                                        decoration: BoxDecoration(),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            InkWell(
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
                                                        'assets/images/Actividades/Series/Act_Series_Principiante/facil3Desc.png',
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
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(8.0),
                                                  child: Image.asset(
                                                    'assets/images/Actividades/Series/Act_Series_Principiante/facil3Desc.png',
                                                    width: MediaQuery.of(context).size.width * 1.0,
                                                    height: MediaQuery.of(context).size.height * 0.15,
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              ),
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
                                                    width: MediaQuery.of(context).size.width * 0.5,
                                                    height: MediaQuery.of(context).size.height * 0.2,
                                                    decoration: BoxDecoration(),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.max,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius: BorderRadius.circular(8.0),
                                                          child: Image.asset(
                                                            'assets/images/Actividades/Series/Act_Series_Principiante/facil3.1.png',
                                                            width: MediaQuery.of(context).size.width * 0.35,
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
                                                    width: MediaQuery.of(context).size.width * 0.5,
                                                    height: MediaQuery.of(context).size.height * 0.2,
                                                    decoration: BoxDecoration(),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.max,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius: BorderRadius.circular(8.0),
                                                          child: Image.asset(
                                                            'assets/images/Actividades/Series/Act_Series_Principiante/facil3.2.png',
                                                            width: MediaQuery.of(context).size.width * 0.35,
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
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    goToNextPage();
                                                  },
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.5,
                                                    height: MediaQuery.of(context).size.height * 0.2,
                                                    decoration: BoxDecoration(),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.max,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius: BorderRadius.circular(8.0),
                                                          child: Image.asset(
                                                            'assets/images/Actividades/Series/Act_Series_Principiante/facil3.3.png',
                                                            width: MediaQuery.of(context).size.width * 0.35,
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
                                                InkWell(
                                                  onTap: () {
                                                    goToNextPage();
                                                  },
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.5,
                                                    height: MediaQuery.of(context).size.height * 0.2,
                                                    decoration: BoxDecoration(),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.max,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius: BorderRadius.circular(8.0),
                                                          child: Image.asset(
                                                            'assets/images/Actividades/Series/Act_Series_Principiante/facil3.4.png',
                                                            width: MediaQuery.of(context).size.width * 0.35,
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ),
                                                        Text(
                                                          '4',
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
                                        width: 100.0,
                                        height: 100.0,
                                        decoration: BoxDecoration(),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            InkWell(
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
                                                        'assets/images/Actividades/Series/Act_Series_Principiante/facil4Desc.png',
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
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(8.0),
                                                  child: Image.asset(
                                                    'assets/images/Actividades/Series/Act_Series_Principiante/facil4Desc.png',
                                                    width: MediaQuery.of(context).size.width * 1.0,
                                                    height: MediaQuery.of(context).size.height * 0.15,
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              ),
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
                                                    width: MediaQuery.of(context).size.width * 0.5,
                                                    height: MediaQuery.of(context).size.height * 0.2,
                                                    decoration: BoxDecoration(),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.max,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius: BorderRadius.circular(8.0),
                                                          child: Image.asset(
                                                            'assets/images/Actividades/Series/Act_Series_Principiante/facil4.1.png',
                                                            width: MediaQuery.of(context).size.width * 0.35,
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
                                                    correctas += 1;
                                                  },
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.5,
                                                    height: MediaQuery.of(context).size.height * 0.2,
                                                    decoration: BoxDecoration(),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.max,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius: BorderRadius.circular(8.0),
                                                          child: Image.asset(
                                                            'assets/images/Actividades/Series/Act_Series_Principiante/facil4.2.png',
                                                            width: MediaQuery.of(context).size.width * 0.35,
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
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    goToNextPage();
                                                  },
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.5,
                                                    height: MediaQuery.of(context).size.height * 0.2,
                                                    decoration: BoxDecoration(),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.max,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius: BorderRadius.circular(8.0),
                                                          child: Image.asset(
                                                            'assets/images/Actividades/Series/Act_Series_Principiante/facil4.3.png',
                                                            width: MediaQuery.of(context).size.width * 0.35,
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
                                                InkWell(
                                                  onTap: () {
                                                    goToNextPage();
                                                  },
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.5,
                                                    height: MediaQuery.of(context).size.height * 0.2,
                                                    decoration: BoxDecoration(),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.max,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius: BorderRadius.circular(8.0),
                                                          child: Image.asset(
                                                            'assets/images/Actividades/Series/Act_Series_Principiante/facil4.4.png',
                                                            width: MediaQuery.of(context).size.width * 0.35,
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ),
                                                        Text(
                                                          '4',
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
                                        width: 100.0,
                                        height: 100.0,
                                        decoration: BoxDecoration(),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            InkWell(
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
                                                        'assets/images/Actividades/Series/Act_Series_Principiante/facil5Desc.png',
                                                        fit: BoxFit.contain,
                                                      ),
                                                      allowRotation: false,
                                                      tag: 'imageTag21',
                                                      useHeroAnimation: true,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Hero(
                                                tag: 'imageTag21',
                                                transitionOnUserGestures: true,
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(8.0),
                                                  child: Image.asset(
                                                    'assets/images/Actividades/Series/Act_Series_Principiante/facil5Desc.png',
                                                    width: MediaQuery.of(context).size.width * 1.0,
                                                    height: MediaQuery.of(context).size.height * 0.15,
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    if(correctas<5){
                                                      incrementarIntentos();
                                                      correctas = 0;
                                                      goToFirstPage();
                                                      UtilsSnackbar.show(context,
                                                          'Tienes una o más respuestas incorrectas, intentalo de nuevo.');
                                                    }
                                                  },
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.5,
                                                    height: MediaQuery.of(context).size.height * 0.2,
                                                    decoration: BoxDecoration(),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.max,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius: BorderRadius.circular(8.0),
                                                          child: Image.asset(
                                                            'assets/images/Actividades/Series/Act_Series_Principiante/facil5.1.png',
                                                            width: MediaQuery.of(context).size.width * 0.35,
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
                                                    correctas += 1;
                                                    if (correctas == 5) {
                                                      incrementarIntentos();
                                                      _estadisticsController.stopTimer();
                                                      resultados();
                                                      _estadisticsController.registroResultados(36, intentos, ayudas,
                                                          _estadisticsController.formatMilliseconds());
                                                    } else {
                                                      incrementarIntentos();
                                                      correctas = 0;
                                                      goToFirstPage();
                                                      UtilsSnackbar.show(context,
                                                          'Tienes una o más respuestas incorrectas, intentalo de nuevo.');
                                                    }
                                                  },
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.5,
                                                    height: MediaQuery.of(context).size.height * 0.2,
                                                    decoration: BoxDecoration(),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.max,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius: BorderRadius.circular(8.0),
                                                          child: Image.asset(
                                                            'assets/images/Actividades/Series/Act_Series_Principiante/facil5.2.png',
                                                            width: MediaQuery.of(context).size.width * 0.35,
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
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    if(correctas<5){
                                                      incrementarIntentos();
                                                      correctas = 0;
                                                      goToFirstPage();
                                                      UtilsSnackbar.show(context,
                                                          'Tienes una o más respuestas incorrectas, intentalo de nuevo.');
                                                    }
                                                  },
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.5,
                                                    height: MediaQuery.of(context).size.height * 0.2,
                                                    decoration: BoxDecoration(),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.max,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius: BorderRadius.circular(8.0),
                                                          child: Image.asset(
                                                            'assets/images/Actividades/Series/Act_Series_Principiante/facil5.3.png',
                                                            width: MediaQuery.of(context).size.width * 0.35,
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
                                                InkWell(
                                                  onTap: () {
                                                    if(correctas<5){
                                                      incrementarIntentos();
                                                      correctas = 0;
                                                      goToFirstPage();
                                                      UtilsSnackbar.show(context,
                                                          'Tienes una o más respuestas incorrectas, intentalo de nuevo.');
                                                    }
                                                  },
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.5,
                                                    height: MediaQuery.of(context).size.height * 0.2,
                                                    decoration: BoxDecoration(),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.max,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius: BorderRadius.circular(8.0),
                                                          child: Image.asset(
                                                            'assets/images/Actividades/Series/Act_Series_Principiante/facil5.4.png',
                                                            width: MediaQuery.of(context).size.width * 0.35,
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ),
                                                        Text(
                                                          '4',
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
