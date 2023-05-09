import 'package:asistente_virtual/src/pages/Controllers/Estadistics_controller.dart';
import 'package:asistente_virtual/src/pages/flutter_flow/Theme_Personal.dart';
import 'package:flutter/material.dart';

class ResultadosWidget {
  static Widget show(BuildContext context, int intentos, int ayudas,
      String tiempo, EstadisticsController _controller) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            PersonalTheme.of(context).primary,
            PersonalTheme.of(context).tertiary
          ],
          stops: [0.0, 1.0],
          begin: AlignmentDirectional(0.0, -1.0),
          end: AlignmentDirectional(0, 1.0),
        ),
      ),
      child: Center(
        child: Container(
          /* color: PersonalTheme.of(context).tertiary, */
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: PersonalTheme.of(context).primaryText,
          ),
          height: MediaQuery.of(context).size.height * 0.6,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Material(
            borderRadius: BorderRadius.circular(15),
            color: PersonalTheme.of(context).primaryText,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Resultados',
                  style: PersonalTheme.of(context).displaySmall.override(
                        color: PersonalTheme.of(context).primary,
                        fontFamily: 'Poppins',
                      ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'Intentos: $intentos',
                  style: PersonalTheme.of(context).headlineMedium.override(
                        color: PersonalTheme.of(context).primary,
                        fontFamily: 'Poppins',
                      ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'Asistencias: $ayudas',
                  style: PersonalTheme.of(context).headlineMedium.override(
                        color: PersonalTheme.of(context).primary,
                        fontFamily: 'Poppins',
                      ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'Tiempo: $tiempo',
                  style: PersonalTheme.of(context).headlineMedium.override(
                        color: PersonalTheme.of(context).primary,
                        fontFamily: 'Poppins',
                      ),
                ),
                const SizedBox(
                  height: 30,
                ),
                IconButton(
                  iconSize: 40,
                  color: PersonalTheme.of(context).primary,
                  onPressed: () {
                    _controller.regreso(context);
                    //_controller.dispose();
                  },
                  icon: const Icon(Icons.check_circle_outline_rounded),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
