import 'package:asistente_virtual/src/pages/Widgets/_menuInferior_widget.dart';
import 'package:asistente_virtual/src/pages/Widgets/_menuSuperior_widget.dart';
import 'package:asistente_virtual/src/utils/utils_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class TareasDiariasPage extends StatefulWidget {
  @override
  _TareasDiariasPageState createState() => _TareasDiariasPageState();
}

class _TareasDiariasPageState extends State<TareasDiariasPage> {
  //Controllers

  // Lista de variables booleanas para controlar la selección de botones
  final List<bool> _selections = <bool>[true, false];
  bool vertical = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //método para iniciar controlador
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MenuSuperior(),
      body: _body(),
      bottomNavigationBar: MenuInferior(),
    );
  }

  Widget _body() {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    double wimage = (w / 2);
    double himage = (h / 2);
    double wcentecima = w / 100;
    double hcentecima = h / 100;
    bool hecho = true;
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: h / 10, left: 2 * wcentecima),
          child: Row(children: [
            Icon(Icons.abc),
            SizedBox(
              width: wcentecima,
            ),
            const Text("Completa 3 actividades"),
            SizedBox(
              width: 10 * wcentecima,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(right: 2*wcentecima),
                height: 20.0,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10.0),
                  color: hecho
                      ? Colors.green
                      : Colors.grey[
                          300], // Cambia el color de fondo dependiendo de la condición
                ),
              ),
            ),
          ]
          ),
        ),
        SizedBox(height: hcentecima,),
        Container(
          padding: EdgeInsets.only(top: h / 10, left: 2 * wcentecima),
          child: Row(children: [
            Icon(Icons.abc),
            SizedBox(
              width: wcentecima,
            ),
            const Text("Tarea 2"),
            SizedBox(
              width: 10 * wcentecima,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(right: 2*wcentecima),
                height: 20.0,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10.0),
                  color: hecho
                      ? Colors.green
                      : Colors.grey[
                          300], // Cambia el color de fondo dependiendo de la condición
                ),
              ),
            ),
          ]
          ),
        ),
        SizedBox(height: hcentecima,),

      ],
    );
  }

  void refresh() {
    setState(() {});
  }
}
