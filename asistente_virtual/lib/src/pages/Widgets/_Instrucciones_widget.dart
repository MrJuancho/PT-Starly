import 'package:asistente_virtual/src/pages/Controllers/Estadistics_controller.dart';
import 'package:asistente_virtual/src/pages/flutter_flow/Theme_Personal.dart';
import 'package:flutter/material.dart';

class InstruccionesWidget {
  static Widget show(
      BuildContext context,
      EstadisticsController _estadisticsController,
      Function press,String instrucciones) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: PersonalTheme.of(context).primary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Instrucciones', style: PersonalTheme.of(context).displaySmall),
          SizedBox(height: 30),
          Center(
              child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: Text(
                '$instrucciones',
                textAlign: TextAlign.justify,
                style: PersonalTheme.of(context).headlineMedium),
          )),
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  //agregar a que pestaña se regresa (probablemente a la de actividades)
                  _estadisticsController.regreso(context);
                },
                child: Text('Regresar'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey[400],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  press();
                },
                child: Text('Iniciar'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
