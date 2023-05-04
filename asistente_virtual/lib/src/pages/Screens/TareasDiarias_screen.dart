import 'package:asistente_virtual/src/pages/Controllers/TareasDiarias_controller.dart';
import 'package:asistente_virtual/src/pages/Widgets/_menuInferior_widget.dart';
import 'package:asistente_virtual/src/pages/Widgets/_menuSuperior_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class TareasDiariasPage extends StatefulWidget {
  @override
  _TareasDiariasPageState createState() => _TareasDiariasPageState();
}

class _TareasDiariasPageState extends State<TareasDiariasPage> {
  //Controllers
  final TareasDiariasController _tareasDiariasController = TareasDiariasController();

  // Lista de variables booleanas para controlar la selección de botones
  final List<bool> _selections = <bool>[true, false];
  bool vertical = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //método para iniciar controlador
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
    });
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
    //variable actualizable con controller
    int fraccion = 3;
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    double wimage = (w / 2);
    double himage = (h / 2);
    double wcentecima = w / 100;
    double hcentecima = h / 100;
    bool hecho = true;
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Column(
        //Primer tarea
        children: [
          SizedBox(
            height: 2 * hcentecima,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.abc),
              SizedBox(
                width: wcentecima,
              ),
              FutureBuilder(
                future: _tareasDiariasController.tarea(1),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return Row(
                      children: [
                        Text(snapshot.data),
                      ],
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ],
          ),
          SizedBox(
            height: hcentecima,
          ),
          Container(
            margin:
                EdgeInsets.only(left: 3 * wcentecima, right: 3 * wcentecima),
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

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FutureBuilder(
                future: _tareasDiariasController.estrellas(1),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return Row(
                      children: [
                        const Icon(Icons.star_rounded),
                        const SizedBox(width: 1),
                        Text(snapshot.data),
                        const SizedBox(width: 10),
                      ],
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
              FutureBuilder(
                future: _tareasDiariasController.monedas(1),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return Row(
                      children: [
                        const Icon(Icons.attach_money_rounded),
                        const SizedBox(width: 1),
                        Text(snapshot.data),
                        const SizedBox(width: 10),
                      ],
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ],
          ),

          //Segunda tarea
          SizedBox(
            height: 5 * hcentecima,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.abc),
              SizedBox(
                width: wcentecima,
              ),
              FutureBuilder(
                future: _tareasDiariasController.tarea(2),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return Row(
                      children: [
                        Text(snapshot.data),
                      ],
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ],
          ),
          SizedBox(
            height: hcentecima,
          ),
          Container(
            margin:
                EdgeInsets.only(left: 3 * wcentecima, right: 3 * wcentecima),
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

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FutureBuilder(
                future: _tareasDiariasController.estrellas(2),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return Row(
                      children: [
                        const Icon(Icons.star_rounded),
                        const SizedBox(width: 1),
                        Text(snapshot.data),
                        const SizedBox(width: 10),
                      ],
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
              FutureBuilder(
                future: _tareasDiariasController.monedas(2),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return Row(
                      children: [
                        const Icon(Icons.attach_money_rounded),
                        const SizedBox(width: 1),
                        Text(snapshot.data),
                        const SizedBox(width: 10),
                      ],
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ],
          ),

          //Tercer tarea
          SizedBox(
            height: 5 * hcentecima,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.abc),
              SizedBox(
                width: wcentecima,
              ),
              FutureBuilder(
                future: _tareasDiariasController.tarea(3),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return Row(
                      children: [
                        Text(snapshot.data),
                      ],
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ],
          ),
          SizedBox(
            height: hcentecima,
          ),
          Container(
            margin:
                EdgeInsets.only(left: 3 * wcentecima, right: 3 * wcentecima),
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

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FutureBuilder(
                future: _tareasDiariasController.estrellas(3),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return Row(
                      children: [
                        const Icon(Icons.star_rounded),
                        const SizedBox(width: 1),
                        Text(snapshot.data),
                        const SizedBox(width: 10),
                      ],
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
              FutureBuilder(
                future: _tareasDiariasController.monedas(3),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return Row(
                      children: [
                        const Icon(Icons.attach_money_rounded),
                        const SizedBox(width: 1),
                        Text(snapshot.data),
                        const SizedBox(width: 10),
                      ],
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ],
          ),

          //Tareas completadas
          SizedBox(
            height: hcentecima * 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [const Text("Tareas completadas")],
          ),
          SizedBox(
            height: hcentecima,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            height: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black),
              color: Colors.grey[300],
            ),
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green,
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: fraccion / 3,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: hcentecima,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("$fraccion/3")],
          ),

          //Desafios

          SizedBox(
            height: hcentecima * 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Desafio",
                style: TextStyle(fontSize: 16),
              )
            ],
          ),
          SizedBox(
            height: 2 * hcentecima,
          ),
          fraccion != 3
              ? const Text(
                  "Bloqueado",
                  style: TextStyle(fontFamily: 'Comfortaa', fontSize: 20),
                )
              : Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FutureBuilder(
                          future: _tareasDiariasController.tareaDD(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              return Row(
                                children: [
                                  Text(snapshot.data),
                                ],
                              );
                            } else {
                              return const CircularProgressIndicator();
                            }
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: hcentecima,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: 3 * wcentecima, right: 3 * wcentecima),
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
                    Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FutureBuilder(
                future: _tareasDiariasController.estrellasDD(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return Row(
                      children: [
                        const Icon(Icons.star_rounded),
                        const SizedBox(width: 1),
                        Text(snapshot.data),
                        const SizedBox(width: 10),
                      ],
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
              FutureBuilder(
                future: _tareasDiariasController.monedasDD(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return Row(
                      children: [
                        const Icon(Icons.attach_money_rounded),
                        const SizedBox(width: 1),
                        Text(snapshot.data),
                        const SizedBox(width: 10),
                      ],
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ],
          ),
                  ],
                ),

          //Recompensas

          SizedBox(
            height: hcentecima,
          ),
        ],
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}
