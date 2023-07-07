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

class ActSopaRevolucionPage extends StatefulWidget {
  const ActSopaRevolucionPage({super.key});

  @override
  _ActSopaRevolucionState createState() => _ActSopaRevolucionState();
}

class _ActSopaRevolucionState extends State<ActSopaRevolucionPage> {
  final EstadisticsController _estadisticsController = EstadisticsController();
  bool _startPressed = false;
  bool _activityFinished = false;
  int correctas = 0;
  int intentos = 0;
  int ayudas = 0;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  List<String> words = [
    'AGRARIA',
    'CONSTITUCION',
    'LATIFUNDIOS',
    'MADERO',
    'PORFIRIATO',
    'REFORMAS',
    'SINDICALISMO',
    'VILLA',
    'ZAPATA',
  ];

  List<String> selectedWords = [];

  List<List<String>> letterGrid = [
    ['Z', 'O', 'T', 'A', 'I', 'R', 'I', 'F', 'R', 'O', 'P', 'Y'],
    ['L', 'V', 'S', 'M', 'K', 'X', 'N', 'R', 'Q', 'O', 'A', 'K'],
    ['W', 'G', 'R', 'E', 'F', 'O', 'R', 'M', 'A', 'S', 'L', 'M'],
    ['P', 'C', 'V', 'E', 'J', 'C', 'O', 'E', 'Y', 'S', 'W', 'H'],
    ['B', 'M', 'F', 'D', 'F', 'N', 'T', 'V', 'I', 'L', 'L', 'A'],
    ['C', 'O', 'N', 'S', 'T', 'I', 'T', 'U', 'C', 'I', 'O', 'N'],
    ['O', 'M', 'S', 'I', 'L', 'A', 'C', 'I', 'D', 'N', 'I', 'S'],
    ['L', 'A', 'T', 'I', 'F', 'U', 'N', 'D', 'I', 'O', 'S', 'M'],
    ['Z', 'X', 'C', 'D', 'A', 'T', 'A', 'P', 'A', 'Z', 'D', 'B'],
    ['Q', 'G', 'H', 'K', 'M', 'A', 'D', 'E', 'R', 'O', 'R', 'E'],
    ['A', 'I', 'R', 'A', 'R', 'G', 'A', 'Y', 'X', 'H', 'Z', 'G'],
    ['V', 'B', 'G', 'X', 'F', 'V', 'O', 'K', 'W', 'Y', 'O', 'V'],
    ['W', 'Z', 'U', 'D', 'V', 'W', 'G', 'W', 'V', 'E', 'J', 'S'],
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
            : InstruccionesWidget.show(
                context,
                _estadisticsController,
                presionado,
                'Buscar palabras relacionadas a eventos historicos de la revolucion mexicana.',
                screenWidth,
                screenHeight);
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
            'Términos históricos de la revolución',
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
                                          55, intentos, ayudas, _estadisticsController.formatMilliseconds());
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
                                          55, intentos, ayudas, _estadisticsController.formatMilliseconds());
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
      floatingActionButton: AyudasWidget.build(context, _estadisticsController, 29, incrementarAyudas),
      //bottomNavigationBar: MenuInferior(),
    );
  }
}
