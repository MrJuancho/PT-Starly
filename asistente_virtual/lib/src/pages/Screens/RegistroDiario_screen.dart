// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:asistente_virtual/src/pages/Controllers/RegistroDiario_controller.dart';
import 'package:asistente_virtual/src/pages/Widgets/_menuInferior_widget.dart';
import 'package:asistente_virtual/src/pages/Widgets/_menuSuperior_widget.dart';
import 'package:asistente_virtual/src/pages/flutter_flow/Theme_Personal.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';

class RegistroDiarioPage extends StatefulWidget {
  const RegistroDiarioPage({super.key});

  @override
  _RegistroDiarioState createState() => _RegistroDiarioState();
}

class _RegistroDiarioState extends State<RegistroDiarioPage> {
  //CONTROLLERS
  DateTime today = DateTime.now();
  final RegistroDiarioController _registroDiarioController = RegistroDiarioController();

  List<dynamic> detalles = [];
  int tareas = 0;
  bool desafio = false;
  @override
  void initState() {
    super.initState();
    actualizaciondia();
  }

  Future<void> actualizaciondia() async {
    detalles = [];
    detalles = await _registroDiarioController.informacion(today);
    if (detalles.isNotEmpty) {
      setState(() {
        tareas = detalles[0];
        desafio = detalles[1];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    const reducedwindowWidth = 500.00;
    const reducedwindowHeight = 810.00;

    if (screenWidth >= 450) {
      return SizedBox(
        height: reducedwindowHeight,
        width: reducedwindowWidth,
        child: Center(child: registro(reducedwindowWidth, reducedwindowHeight)),
      );
    } else {
      return registro(screenWidth, screenHeight);
    }
  }

  Widget registro(double screenWidth, double screenHeight) {
    return Scaffold(
      appBar: MenuSuperior(),
      bottomNavigationBar: MenuInferior(),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [PersonalTheme.of(context).primary, PersonalTheme.of(context).tertiary],
                stops: const [0.0, 1.0],
                begin: const AlignmentDirectional(0.0, -1.0),
                end: const AlignmentDirectional(0, 1.0),
              ),
            ),
          ),
          Center(
            child: Column(
              children: [
                SizedBox(
                  width: screenWidth,
                  child: TableCalendar(
                    focusedDay: today,
                    //rowHeight: 43,
                    firstDay: DateTime.utc(2023, 1, 1),
                    lastDay: DateTime.utc(2030, 12, 31),
                    headerStyle: const HeaderStyle(titleCentered: true, formatButtonVisible: false),
                    availableGestures: AvailableGestures.all,
                    locale: 'en_US',
                    selectedDayPredicate: (day) {
                      return isSameDay(today, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) async {
                      setState(() {
                        today = selectedDay;
                        today = focusedDay;
                        actualizaciondia();
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                detalles.isEmpty
                    ? Text(
                        'Sin tareas completadas este dia',
                        style: PersonalTheme.of(context).displayMedium,
                        textAlign: TextAlign.center,
                      )
                    : Column(
                        children: [
                          Text(
                            'Tareas completadas: ${detalles[0]}',
                            style: PersonalTheme.of(context).displaySmall,
                            textAlign: TextAlign.center,
                          ),
                          detalles[1] == true
                              ? Text(
                                  'Desafio completado',
                                  style: PersonalTheme.of(context).displaySmall,
                                  textAlign: TextAlign.center,
                                )
                              : Text(
                                  'Desafio no completado',
                                  style: PersonalTheme.of(context).displaySmall,
                                  textAlign: TextAlign.center,
                                )
                        ],
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
