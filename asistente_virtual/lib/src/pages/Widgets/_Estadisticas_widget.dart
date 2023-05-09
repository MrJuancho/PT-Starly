import 'package:asistente_virtual/src/pages/Controllers/Estadistics_controller.dart';
import 'package:asistente_virtual/src/pages/flutter_flow/Theme_Personal.dart';
import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class EstadisticasWidget {
  static Widget build(BuildContext context, int intentos, int ayudas,
      EstadisticsController _estadisticsController) {
    //final EstadisticsController _estadisticsController = EstadisticsController();
    return Align(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 1.0,
        height: MediaQuery.of(context).size.height * 0.12,
        decoration: BoxDecoration(
          color: PersonalTheme.of(context).primaryBackground,
          borderRadius: BorderRadius.circular(20.0),
          shape: BoxShape.rectangle,
          border: Border.all(
            color: Color(0x00E21C3D),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Estadisticas',
                  style: PersonalTheme.of(context).titleLarge,
                ),
              ],
            ),
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Text(
                      'Intentos:',
                      style: PersonalTheme.of(context).bodyMedium.override(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 0.0),
                    child: Text(
                      /*valueOrDefault<String>(
                                    FFAppState().contadorIntentos.toString(),
                                    '0',
                                  ),*/
                      "$intentos",
                      style: PersonalTheme.of(context).bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Text(
                      'Asistencias',
                      style: PersonalTheme.of(context).bodyMedium.override(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 0.0),
                    child: Text(
                      /*valueOrDefault<String>(
                                    FFAppState().contadorIntentos.toString(),
                                    '0',
                                  ),*/
                      "$ayudas",
                      style: PersonalTheme.of(context).bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Text(
                      'Tiempo:',
                      style: PersonalTheme.of(context).bodyMedium.override(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 0.0),
                      child: StreamBuilder<int>(
                        stream: _estadisticsController.timerController.rawTime,
                        initialData: 0,
                        builder: (context, snapshot) {
                          final value = snapshot.data!;
                          final displayTime = StopWatchTimer.getDisplayTime(
                              value,
                              hours: false);
                          return Text(displayTime,
                              style: PersonalTheme.of(context).bodyMedium);
                        },
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
