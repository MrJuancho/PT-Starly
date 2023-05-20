import 'package:asistente_virtual/src/pages/Controllers/Estadistics_controller.dart';
import 'package:asistente_virtual/src/pages/Widgets/_Estadisticas_widget.dart';
import 'package:asistente_virtual/src/pages/Widgets/_botonAsistencia_widget.dart';
import 'package:asistente_virtual/src/pages/flutter_flow/Theme_Personal.dart';
import 'package:asistente_virtual/src/utils/utils_preferences.dart';
import 'package:flutter/material.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'dart:math';

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

  List<List<String>> letterGrid = [
    ['F', 'L', 'U', 'T', 'T', 'E', 'R'],
    ['D', 'A', 'R', 'T', 'E', 'H', 'T'],
    ['W', 'I', 'D', 'G', 'E', 'T', 'A'],
    ['M', 'O', 'B', 'I', 'L', 'E', 'A'],
    ['P', 'P', 'A', 'E', 'K', 'B', 'F'],
    // Agrega aquí más letras
  ];

  String currentWord = '';
  bool isDragging = false;
  Offset startPoint = Offset.zero;
  List<Offset> path = [];

  List<List<bool>> selectedCells = List.generate(
    5,
    (_) => List<bool>.filled(7, false),
  );

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

  bool isAdjacent(Offset cell1, Offset cell2) {
    final cellSize = (MediaQuery.of(context).size.width * 0.9) / letterGrid.first.length;
    final maxDistance = cellSize * 1.5; // Ajusta este valor según tus necesidades

    return (cell2 - cell1).distance <= maxDistance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      stops: const [0.0, 1.0],
                      begin: const AlignmentDirectional(0.0, -1.0),
                      end: const AlignmentDirectional(0, 1.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        height: MediaQuery.of(context).size.height * 0.52,
                        width: MediaQuery.of(context).size.width * 0.9,
                        color: PersonalTheme.of(context).primaryText,
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onHorizontalDragStart: (details) {
                            setState(() {
                              currentWord = '';
                              isDragging = true;
                              startPoint = details.localPosition;
                            });
                          },
                          onHorizontalDragUpdate: (details) {
                            if (!isDragging) return;

                            setState(() {
                              final cellSize = (MediaQuery.of(context).size.width * 0.9) / letterGrid.first.length;
                              final row = (startPoint.dy / cellSize).floor();
                              final column = (startPoint.dx / cellSize).floor();
                              final currentRow = (details.localPosition.dy / cellSize).floor();
                              final currentColumn = (details.localPosition.dx / cellSize).floor();

                              currentWord = '';

                              if (row >= 0 &&
                                  row < letterGrid.length &&
                                  column >= 0 &&
                                  column < letterGrid[row].length &&
                                  currentRow >= 0 &&
                                  currentRow < letterGrid.length &&
                                  currentColumn >= 0 &&
                                  currentColumn < letterGrid[currentRow].length) {
                                if (row == currentRow) {
                                  final start = column < currentColumn ? column : currentColumn;
                                  final end = column > currentColumn ? column : currentColumn;

                                  for (int i = start; i <= end; i++) {
                                    currentWord += letterGrid[row][i];
                                  }
                                } else if (column == currentColumn) {
                                  final start = row < currentRow ? row : currentRow;
                                  final end = row > currentRow ? row : currentRow;

                                  for (int i = start; i <= end; i++) {
                                    currentWord += letterGrid[i][column];
                                  }
                                } else if ((currentColumn - column).abs() == (currentRow - row).abs()) {
                                  final stepRow = currentRow > row ? 1 : -1;
                                  final stepColumn = currentColumn > column ? 1 : -1;

                                  int i = row;
                                  int j = column;

                                  while (i != currentRow || j != currentColumn) {
                                    final selectedLetter = letterGrid[i][j];
                                    currentWord += selectedLetter;

                                    i += stepRow;
                                    j += stepColumn;
                                  }

                                  final selectedLetter = letterGrid[currentRow][currentColumn];
                                  currentWord += selectedLetter;
                                }
                              }
                            });
                          },
                          onHorizontalDragEnd: (details) {
                            setState(() {
                              print('Current word: $currentWord');
                              currentWord = '';
                              isDragging = false;
                            });
                          },
                          onVerticalDragStart: (details) {
                            setState(() {
                              currentWord = '';
                              isDragging = true;
                              startPoint = details.localPosition;
                            });
                          },
                          onVerticalDragUpdate: (details) {
                            if (!isDragging) return;

                            setState(() {
                              final cellSize = (MediaQuery.of(context).size.width * 0.9) / letterGrid.first.length;
                              final row = (startPoint.dy / cellSize).floor();
                              final column = (startPoint.dx / cellSize).floor();
                              final currentRow = (details.localPosition.dy / cellSize).floor();
                              final currentColumn = (details.localPosition.dx / cellSize).floor();

                              currentWord = '';

                              if (row >= 0 &&
                                  row < letterGrid.length &&
                                  column >= 0 &&
                                  column < letterGrid[row].length &&
                                  currentRow >= 0 &&
                                  currentRow < letterGrid.length &&
                                  currentColumn >= 0 &&
                                  currentColumn < letterGrid[currentRow].length) {
                                if (column == currentColumn) {
                                  final start = row < currentRow ? row : currentRow;
                                  final end = row > currentRow ? row : currentRow;

                                  for (int i = start; i <= end; i++) {
                                    currentWord += letterGrid[i][column];
                                  }
                                } else if ((currentColumn - column).abs() == (currentRow - row).abs()) {
                                  final stepRow = currentRow > row ? 1 : -1;
                                  final stepColumn = currentColumn > column ? 1 : -1;

                                  int i = row;
                                  int j = column;

                                  while (i != currentRow || j != currentColumn) {
                                    final selectedLetter = letterGrid[i][j];
                                    currentWord += selectedLetter;

                                    i += stepRow;
                                    j += stepColumn;
                                  }

                                  final selectedLetter = letterGrid[currentRow][currentColumn];
                                  currentWord += selectedLetter;
                                }
                              }
                            });
                          },
                          onVerticalDragEnd: (details) {
                            setState(() {
                              print('Current word: $currentWord');
                              currentWord = '';
                              isDragging = false;
                            });
                          },
                          child: GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: letterGrid.first.length,
                              childAspectRatio: 1.0, // Asegura que las celdas tengan un aspecto cuadrado
                            ),
                            itemCount: letterGrid.length * letterGrid.first.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final row = index ~/ letterGrid.first.length;
                              final column = index % letterGrid.first.length;

                              if (row < letterGrid.length && column < letterGrid[row].length) {
                                final letter = letterGrid[row][column];

                                return Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                  ),
                                  child: Center(
                                    child: Text(
                                      letter,
                                      style: PersonalTheme.of(context)
                                          .bodyMedium
                                          .override(fontFamily: 'Poppins', color: PersonalTheme.of(context).primary),
                                    ),
                                  ),
                                );
                              } else {
                                return Container(); // Celda vacía
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Palabras a encontrar'),
                      SizedBox(
                        height: 10,
                      ),
                      Text(words.join(' ')),
                      SizedBox(
                        height: 15,
                      ),
                      Text('Palabras encontradas'),
                      SizedBox(
                        height: 10,
                      ),
                      Text(selectedWords.join(' ')),
                    ],
                  ),
                ),
              ),
              EstadisticasWidget.build(context, intentos, ayudas, _estadisticsController),
            ],
          ),
        ),
      ),
      floatingActionButton: AyudasWidget.build(context, _estadisticsController, 40, incrementarAyudas),
      //bottomNavigationBar: MenuInferior(),
    );
  }
}

/* style: PersonalTheme.of(context)
                                            .bodyMedium
                                            .override(fontFamily: 'Poppins', color: PersonalTheme.of(context).primary),
                                            return Scaffold(
      appBar: AppBar(
        title: Text('Sopa de Letras'),
      ),
      body: GridView.builder(
        
        itemCount: 35,
        letterGridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                letterGrid[row][col],
                style: TextStyle(fontSize: 20),
              ),
            ),
          );
        },
      ),
    ); */