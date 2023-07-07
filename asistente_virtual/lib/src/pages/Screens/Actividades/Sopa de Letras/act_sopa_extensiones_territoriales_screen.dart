// ignore_for_file: null_check_always_fails, library_private_types_in_public_api

import 'package:asistente_virtual/src/pages/Controllers/Estadistics_controller.dart';
import 'package:asistente_virtual/src/pages/Widgets/_Estadisticas_widget.dart';
import 'package:asistente_virtual/src/pages/Widgets/_Instrucciones_widget.dart';
import 'package:asistente_virtual/src/pages/Widgets/_Resultados_widget.dart';
import 'package:asistente_virtual/src/pages/Widgets/_botonAsistencia_widget.dart';
import 'package:asistente_virtual/src/pages/flutter_flow/Theme_Personal.dart';
import 'package:asistente_virtual/src/utils/utils_preferences.dart';
import 'package:flutter/material.dart';
import 'package:marquee_widget/marquee_widget.dart';

class ActSopaExtensionesTerritorialesPage extends StatefulWidget {
  const ActSopaExtensionesTerritorialesPage({super.key});

  @override
  _ActSopaExtensionesTerritorialesState createState() => _ActSopaExtensionesTerritorialesState();
}

class _ActSopaExtensionesTerritorialesState extends State<ActSopaExtensionesTerritorialesPage> {
  final EstadisticsController _estadisticsController = EstadisticsController();
  bool _startPressed = false;
  bool _activityFinished = false;
  int correctas = 0;
  int intentos = 0;
  int ayudas = 0;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  List<String> words = [
    'CANCUN',
    'CARMEN',
    'CITLALTEPETL',
    'EVERMAN',
    'GUADALUPE',
    'MAGDALENA',
    'NEVADO',
    'PARICUTIN',
    'POPOCATEPETL',
  ];

  List<String> selectedWords = [];

  List<List<String>> letterGrid = [
    ['Ñ', 'U', 'U', 'K', 'Z', 'X', 'A', 'I', 'T', 'E', 'Q', 'N'],
    ['U', 'O', 'O', 'W', 'A', 'R', 'Q', 'V', 'Ñ', 'L', 'W', 'E'],
    ['H', 'Z', 'B', 'L', 'E', 'W', 'T', 'N', 'G', 'K', 'V', 'V'],
    ['A', 'F', 'E', 'M', 'M', 'R', 'I', 'D', 'A', 'E', 'N', 'A'],
    ['L', 'Z', 'J', 'M', 'Q', 'B', 'T', 'C', 'R', 'B', 'X', 'D'],
    ['Y', 'G', 'F', 'O', 'Ñ', 'D', 'A', 'M', 'Z', 'X', 'X', 'O'],
    ['E', 'P', 'U', 'L', 'A', 'D', 'A', 'U', 'G', 'C', 'P', 'P'],
    ['W', 'U', 'E', 'C', 'A', 'N', 'C', 'U', 'N', 'Ñ', 'A', 'B'],
    ['C', 'M', 'P', 'A', 'R', 'I', 'C', 'U', 'T', 'I', 'N', 'W'],
    ['C', 'I', 'T', 'L', 'A', 'L', 'T', 'E', 'P', 'E', 'T', 'L'],
    ['C', 'A', 'R', 'M', 'E', 'N', 'E', 'K', 'E', 'P', 'Z', 'O'],
    ['L', 'T', 'E', 'P', 'E', 'T', 'A', 'C', 'O', 'P', 'O', 'P'],
    ['N', 'I', 'A', 'N', 'E', 'L', 'A', 'D', 'G', 'A', 'M', 'O'],
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
      _estadisticsController.sumamonedas();
    });
  }

  bool checkString(List<String> words, String searchString) {
    if (words.contains(searchString)) {
      return true;
    } else {
      String reversedString = searchString.split('').reversed.join();
      return words.contains(reversedString);
    }
  }

  String currentString(List<String> words, String searchString) {
    if (words.contains(searchString)) {
      return searchString;
    } else {
      String reversedString = searchString.split('').reversed.join();
      if (words.contains(reversedString)) {
        return reversedString;
      } else {
        return null!;
      }
    }
  }

  bool haveSameContent(List<String> list1, List<String> list2) {
    return list1.toSet().containsAll(list2.toSet()) && list2.toSet().containsAll(list1.toSet());
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
            : InstruccionesWidget.show(context, _estadisticsController, presionado,
                'Sopa de letras con nombres de volcanes.', screenWidth, screenHeight);
  }

  Scaffold _actividad(BuildContext context, double screenWidth, double screenHeight) {
    final cellSize = (screenWidth * 0.95) / letterGrid.first.length;
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
            'Tipos de extensiones terrenales',
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
                  child: screenWidth >= 450
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              height: cellSize * letterGrid.length,
                              width: screenWidth * 0.95,
                              color: PersonalTheme.of(context).primaryText,
                              child: GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onPanStart: (details) {
                                  setState(() {
                                    currentWord = '';
                                    isDragging = true;
                                    startPoint = details.localPosition;
                                  });
                                },
                                onPanUpdate: (details) {
                                  if (!isDragging) return;

                                  setState(() {
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
                                onPanEnd: (details) {
                                  setState(() {
                                    if (checkString(words, currentWord)) {
                                      if (!selectedWords.contains(currentWord)) {
                                        currentWord = currentString(words, currentWord);
                                        selectedWords.add(currentWord);
                                        words.removeWhere((element) => element == currentWord);
                                      }
                                    }
                                    incrementarIntentos();
                                    if (words.isEmpty) {
                                      _estadisticsController.stopTimer();
                                      resultados();
                                      _estadisticsController.registroResultados(
                                          56, intentos, ayudas, _estadisticsController.formatMilliseconds());
                                    } else {
                                      currentWord = '';
                                      isDragging = false;
                                    }
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
                                            style: PersonalTheme.of(context).bodyMedium.override(
                                                fontFamily: 'Poppins', color: PersonalTheme.of(context).primary),
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
                            Scrollbar(
                              thumbVisibility: true,
                              scrollbarOrientation: ScrollbarOrientation.right,
                              child: SingleChildScrollView(
                                child: SizedBox(
                                  width: screenWidth,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Text('Palabras por encontrar', style: PersonalTheme.of(context).bodySmall),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            words.join('\n'),
                                            style: PersonalTheme.of(context).bodySmall,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              height: cellSize * letterGrid.length,
                              width: screenWidth * 0.95,
                              color: PersonalTheme.of(context).primaryText,
                              child: GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onPanStart: (details) {
                                  setState(() {
                                    currentWord = '';
                                    isDragging = true;
                                    startPoint = details.localPosition;
                                  });
                                },
                                onPanUpdate: (details) {
                                  if (!isDragging) return;

                                  setState(() {
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
                                onPanEnd: (details) {
                                  setState(() {
                                    if (checkString(words, currentWord)) {
                                      if (!selectedWords.contains(currentWord)) {
                                        currentWord = currentString(words, currentWord);
                                        selectedWords.add(currentWord);
                                        words.removeWhere((element) => element == currentWord);
                                      }
                                    }
                                    incrementarIntentos();
                                    if (words.isEmpty) {
                                      _estadisticsController.stopTimer();
                                      resultados();
                                      _estadisticsController.registroResultados(
                                          56, intentos, ayudas, _estadisticsController.formatMilliseconds());
                                    } else {
                                      currentWord = '';
                                      isDragging = false;
                                    }
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
                                            style: PersonalTheme.of(context).bodyMedium.override(
                                                fontFamily: 'Poppins', color: PersonalTheme.of(context).primary),
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
                            const SizedBox(
                              height: 5,
                            ),
                            Expanded(
                              child: Scrollbar(
                                thumbVisibility: true,
                                scrollbarOrientation: ScrollbarOrientation.right,
                                child: SingleChildScrollView(
                                  child: SizedBox(
                                    width: screenWidth,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Text('Palabras por encontrar', style: PersonalTheme.of(context).bodySmall),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              words.join('\n'),
                                              style: PersonalTheme.of(context).bodySmall,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
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
      floatingActionButton: AyudasWidget.build(context, _estadisticsController, 33, incrementarAyudas),
      //bottomNavigationBar: MenuInferior(),
    );
  }
}
