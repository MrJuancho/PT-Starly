import 'package:asistente_virtual/src/pages/Controllers/Estadistics_controller.dart';
import 'package:asistente_virtual/src/pages/Widgets/_Estadisticas_widget.dart';
import 'package:asistente_virtual/src/pages/Widgets/_botonAsistencia_widget.dart';
import 'package:asistente_virtual/src/pages/flutter_flow/Theme_Personal.dart';
import 'package:asistente_virtual/src/utils/utils_preferences.dart';
import 'package:flutter/material.dart';
import 'package:marquee_widget/marquee_widget.dart';

class ActSopaSentimientosEmocionesPage extends StatefulWidget {
  @override
  _ActSopaSentimientosEmocionesState createState() => _ActSopaSentimientosEmocionesState();
}

class _ActSopaSentimientosEmocionesState extends State<ActSopaSentimientosEmocionesPage> {
  final EstadisticsController _estadisticsController = EstadisticsController();
  bool _startPressed = false;
  bool _activityFinished = false;
  int correctas = 0;
  int intentos = 0;
  int ayudas = 0;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  List<String> words = [
    'FLUTTER',
    'DART',
    'WIDGET',
    'MOBILE',
    'APP',
    // Agrega aquí más palabras
  ];

  List<String> selectedWords = [];

  List<List<String>> grid = [
    ['F', 'L', 'U', 'T', 'T', 'E', 'R'],
    ['D', 'A', 'R', 'T', 'E', 'H', 'T'],
    ['W', 'I', 'D', 'G', 'E', 'T', 'A'],
    ['M', 'O', 'B', 'I', 'L', 'E', 'A'],
    ['P', 'P', 'A', 'E', 'K', 'B', 'F'],
    // Agrega aquí más letras
  ];

  List<List<bool>> selectedCells = List.generate(
    5,
    (_) => List<bool>.filled(7, false),
  );

  /* void checkWord() {
    if (words.contains(currentWord)) {
      if (!selectedWords.contains(currentWord)) {
        selectedWords.add(currentWord);
        // Aquí puedes incrementar el contador de intentos
      }
    }
  } */

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

  @override
  Widget build(BuildContext context) {
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
              'Sentimientos y Emociones',
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
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          height: MediaQuery.of(context).size.height * 0.6,
                          width: MediaQuery.of(context).size.width * 0.9,
                          color: PersonalTheme.of(context).primaryText,
                          child: GridView.builder(
                            itemCount: 35,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 7,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              int row = index ~/ 7;
                              int col = index % 7;
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedCells[row][col] = !selectedCells[row][col];
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    color: selectedCells[row][col]
                                        ? PersonalTheme.of(context).tertiary
                                        : PersonalTheme.of(context).fadedalternate,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    grid[row][col],
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text('Palabras')
                      ],
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
/* return Scaffold(
      appBar: AppBar(
        title: Text('Sopa de Letras'),
      ),
      body: GridView.builder(
        
        itemCount: 35,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
        ),
        itemBuilder: (BuildContext context, int index) {
          int row = index ~/ 7;
          int col = index % 7;
          return GestureDetector(
            
            onTap: () {
              setState(() {
                selectedCells[row][col] = !selectedCells[row][col];
              });
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                color: selectedCells[row][col]
                    ? PersonalTheme.of(context).tertiary
                    : PersonalTheme.of(context).fadedalternate,
              ),
              alignment: Alignment.center,
              child: Text(
                grid[row][col],
                style: TextStyle(fontSize: 20),
              ),
            ),
          );
        },
      ),
    ); */