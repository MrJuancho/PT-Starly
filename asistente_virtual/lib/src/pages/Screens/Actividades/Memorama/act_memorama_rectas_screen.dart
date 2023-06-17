// ignore_for_file: library_private_types_in_public_api

import 'dart:math';
import 'package:asistente_virtual/src/pages/Controllers/Estadistics_controller.dart';
import 'package:asistente_virtual/src/pages/Widgets/_Instrucciones_widget.dart';
import 'package:asistente_virtual/src/pages/Widgets/_Resultados_widget.dart';
import 'package:asistente_virtual/src/pages/Widgets/_botonAsistencia_widget.dart';
import 'package:asistente_virtual/src/pages/Widgets/_Estadisticas_widget.dart';
import 'package:asistente_virtual/src/pages/Widgets/_vistaImagenExpandida.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:marquee_widget/marquee_widget.dart';
import '../../../../utils/utils_preferences.dart';
import '../../../flutter_flow/Theme_Personal.dart';

class ActMemoramaRectasPage extends StatefulWidget {
  const ActMemoramaRectasPage({
    Key? key,
    String? counter,
  })  : counter = counter ?? '0',
        super(key: key);

  final String counter;

  @override
  _ActMemoramaRectasState createState() => _ActMemoramaRectasState();
}

class _ActMemoramaRectasState extends State<ActMemoramaRectasPage> {
  final EstadisticsController _estadisticsController = EstadisticsController();
  bool _startPressed = false;
  bool _activityFinished = false;
  int correctas = 0;
  int intentos = 0;
  int ayudas = 0;

  List<String> cardImages = [
    'assets/images/Actividades/Memorama/Act_Memorama_Rectas/par1.png',
    'assets/images/Actividades/Memorama/Act_Memorama_Rectas/par2.png',
    'assets/images/Actividades/Memorama/Act_Memorama_Rectas/par3.png',
    'assets/images/Actividades/Memorama/Act_Memorama_Rectas/par4.png',
    'assets/images/Actividades/Memorama/Act_Memorama_Rectas/par5.png',
    'assets/images/Actividades/Memorama/Act_Memorama_Rectas/par6.png',
    'assets/images/Actividades/Memorama/Act_Memorama_Rectas/par7.png',
    'assets/images/Actividades/Memorama/Act_Memorama_Rectas/par8.png',
    'assets/images/Actividades/Memorama/Act_Memorama_Rectas/par9.png',
    'assets/images/Actividades/Memorama/Act_Memorama_Rectas/par10.png',
    'assets/images/Actividades/Memorama/Act_Memorama_Rectas/par1.png',
    'assets/images/Actividades/Memorama/Act_Memorama_Rectas/par2.png',
    'assets/images/Actividades/Memorama/Act_Memorama_Rectas/par3.png',
    'assets/images/Actividades/Memorama/Act_Memorama_Rectas/par4.png',
    'assets/images/Actividades/Memorama/Act_Memorama_Rectas/par5.png',
    'assets/images/Actividades/Memorama/Act_Memorama_Rectas/par6.png',
    'assets/images/Actividades/Memorama/Act_Memorama_Rectas/par7.png',
    'assets/images/Actividades/Memorama/Act_Memorama_Rectas/par8.png',
    'assets/images/Actividades/Memorama/Act_Memorama_Rectas/par9.png',
    'assets/images/Actividades/Memorama/Act_Memorama_Rectas/par10.png',
    
  ];

  List<String> flippedCards = [];
  List<int> flippedCardsnumbers = [];
  List<GlobalKey<FlipCardState>> cardKeys = [];
  List<bool> flippedStatus = [];

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    cardImages.shuffle(Random());
    cardKeys = List.generate(
      cardImages.length,
      (_) => GlobalKey<FlipCardState>(),
    );
    flippedStatus = List.generate(cardImages.length, (_) => false);
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

  void flipCard(int index) {
    if (flippedCards.length < 2) {
      setState(() {
        flippedCards.add(cardImages[index]);
        flippedCardsnumbers.add(index);
      });

      if (flippedCards.length == 2) {
        if (flippedCards[0] != flippedCards[1]) {
          // Si las cartas no coinciden, se voltean después de un breve retraso
          Future.delayed(const Duration(milliseconds: 500), () {
            List<GlobalKey<FlipCardState>> flippedCardKeys = [];
            for (var i = 0; i < flippedCards.length; i++) {
              int cardIndex = flippedCardsnumbers[i];
              flippedCardKeys.add(cardKeys[cardIndex]);
            }
            for (var key in flippedCardKeys) {
              key.currentState!.toggleCard();
            }
            setState(() {
              flippedCards.clear();
              flippedCardsnumbers.clear();
              incrementarIntentos();
            });
          });
        } else {
          // Si las cartas coinciden, se mantienen volteadas y se reinicia el contador
          setState(() {
            for (var index in flippedCardsnumbers) {
              flippedStatus[index] = true;
            }
            flippedCards.clear();
            flippedCardsnumbers.clear();
            incrementarIntentos();
          });
        }
        if (flippedStatus.every((status) => status == true)) {
          resultados();
          _estadisticsController.stopTimer();
          _estadisticsController.registroResultados(24, intentos, ayudas, _estadisticsController.formatMilliseconds());
        }
      }
    }
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

  Widget eleccion(double screenWidth, double screenHeight){
return _startPressed
        ? _actividad(context, screenWidth, screenHeight)
        : _activityFinished
            ? ResultadosWidget.show(
                context, intentos, ayudas, _estadisticsController.formatMilliseconds(), _estadisticsController, screenWidth, screenHeight)
            : InstruccionesWidget.show(context, _estadisticsController, presionado,
                'Encuentra la tarjeta que contenga el mismo elemento.', screenWidth, screenHeight);
  }

  Widget _actividad(BuildContext context,double screenWidth, double screenHeight) {
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
              'Rectas, paralelas, perpendiculares y secantes',
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
                        child: GridView.builder(
                          padding: const EdgeInsets.only(top: 10),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 0.0,
                            mainAxisSpacing: 10.0,
                            childAspectRatio: 0.75,
                          ),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: cardImages.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                              child: FlipCard(
                                fill: Fill.fillBack,
                                direction: FlipDirection.HORIZONTAL,
                                speed: 400,
                                key: cardKeys[index],
                                onFlipDone: (isFront) {
                                  if (isFront) {
                                    flipCard(index);
                                  }
                                },
                                front: Container(
                                  width: 100.0,
                                  height: 100.0,
                                  decoration: BoxDecoration(
                                    color: PersonalTheme.of(context).tertiary,
                                    borderRadius: BorderRadius.circular(12.0),
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(2.0, 2.0, 2.0, 2.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image.asset(
                                        'assets/images/home/cardBack.png',
                                        width: 100.0,
                                        height: 100.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                back: Container(
                                  width: 100.0,
                                  height: 100.0,
                                  decoration: BoxDecoration(
                                    color: PersonalTheme.of(context).tertiary,
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(5.0, 5.0, 5.0, 5.0),
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
                                                cardImages[index],
                                                fit: BoxFit.contain,
                                              ),
                                              allowRotation: false,
                                              useHeroAnimation: false,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Hero(
                                        tag: '$index',
                                        transitionOnUserGestures: true,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10.0),
                                          child: Image.asset(
                                            cardImages[index],
                                            width: 100.0,
                                            height: 100.0,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
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
        floatingActionButton: AyudasWidget.build(context, _estadisticsController, 11, incrementarAyudas),
        //bottomNavigationBar: MenuInferior(),
      ),
    );
  }
}
