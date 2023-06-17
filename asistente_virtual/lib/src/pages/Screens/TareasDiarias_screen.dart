// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:asistente_virtual/src/pages/Controllers/TareasDiarias_controller.dart';
import 'package:asistente_virtual/src/pages/Widgets/_menuInferior_widget.dart';
import 'package:asistente_virtual/src/pages/Widgets/_menuSuperior_widget.dart';
import 'package:flutter/material.dart';
import 'package:asistente_virtual/src/pages/flutter_flow/Theme_Personal.dart';

class TareasDiariasPage extends StatefulWidget {
  const TareasDiariasPage({super.key});

  @override
  _TareasDiariasPageState createState() => _TareasDiariasPageState();
}

class _TareasDiariasPageState extends State<TareasDiariasPage> {
  //Controllers
  final TareasDiariasController _tareasDiariasController = TareasDiariasController();

  // Lista de variables booleanas para controlar la selección de botones
  bool vertical = false;

  @override
  void initState() {
    super.initState();
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
        child: Center(child: builder(reducedwindowWidth, reducedwindowHeight)),
      );
    } else {
      return builder(screenWidth, screenHeight);
    }
  }

  Widget builder(double screenWidth, double screenHeight) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _tareasDiariasController.getTareas(),
      builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Mientras se cargan los valores, puedes mostrar un indicador de carga o un mensaje
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // En caso de error al obtener los valores, puedes mostrar un mensaje de error
          return  Text('Error al obtener los valores',style: PersonalTheme.of(context).titleMedium,);
        } else {
          // Si se obtienen los valores correctamente, puedes pasarlos al método _body()
          Map<String, dynamic> tareas = snapshot.data!;
          int actividades = tareas['Actividades'] ?? 0;
          int interacciones = tareas['Interacciones'] ?? 0;
          int tareasCompletadas = tareas['TareasCom'] >= 3 ? 3 : tareas['TareasCom'];

          return Scaffold(
            appBar: MenuSuperior(),
            body: _body(actividades, interacciones, tareasCompletadas, screenWidth, screenHeight),
            bottomNavigationBar: MenuInferior(),
          );
        }
      },
    );
  }

  Widget _body(int actCompletadas, int interaccionesAV, int tareasCom, double screenWidth, double screenHeight) {
    //variable actualizable con controller
    double wcentecima = screenWidth / 100;
    double hcentecima = screenHeight / 100;
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Stack(
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
                              Text(snapshot.data,style: PersonalTheme.of(context).titleMedium,),
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
                Center(
                  child: Container(
                    
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    height: 20,
                    width: screenWidth,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black),
                      color: PersonalTheme.of(context).primaryBackground,
                    ),
                    child: Stack(
                      children: [
                        Container(
                          width: screenWidth,
                          height: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: PersonalTheme.of(context).fadedalternate,
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: actCompletadas >= 3 ? 3 / 3 : actCompletadas / 3,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: PersonalTheme.of(context).tertiary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          
                SizedBox(
                  width: screenWidth,
                  child: Row(
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
                                Text(snapshot.data,style: PersonalTheme.of(context).titleMedium,),
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
                                Text(snapshot.data,style: PersonalTheme.of(context).titleMedium,),
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
                              Text(snapshot.data,style: PersonalTheme.of(context).titleMedium,),
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
                  width: screenWidth,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black),
                    color: PersonalTheme.of(context).primaryBackground,
                  ),
                  child: Stack(
                    children: [
                      Container(
                        width: screenWidth,
                        height: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: PersonalTheme.of(context).fadedalternate,
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: actCompletadas >= 5 ? 5 / 5 : actCompletadas / 5,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: PersonalTheme.of(context).tertiary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
          
                SizedBox(
                  width: screenWidth,
                  child: Row(
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
                                Text(snapshot.data,style: PersonalTheme.of(context).titleMedium,),
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
                                Text(snapshot.data,style: PersonalTheme.of(context).titleMedium,),
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
                              Text(snapshot.data,style: PersonalTheme.of(context).titleMedium,),
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
                  width: screenWidth,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black),
                    color: PersonalTheme.of(context).primaryBackground,
                  ),
                  child: Stack(
                    children: [
                      Container(
                        width: screenWidth,
                        height: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: PersonalTheme.of(context).fadedalternate,
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: interaccionesAV >= 3 ? 3 / 3 : interaccionesAV / 3,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: PersonalTheme.of(context).tertiary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
          
                SizedBox(
                  width: screenWidth,
                  child: Row(
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
                                Text(snapshot.data,style: PersonalTheme.of(context).titleMedium,),
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
                                Text(snapshot.data,style: PersonalTheme.of(context).titleMedium,),
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
                ),
          
                //Tareas completadas
                SizedBox(
                  height: hcentecima * 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text("Tareas completadas",style: PersonalTheme.of(context).titleMedium,)],
                ),
                SizedBox(
                  height: hcentecima,
                ),
                Container(
                  width: screenWidth,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black),
                    color: PersonalTheme.of(context).primaryBackground,
                  ),
                  child: Stack(
                    children: [
                      Container(
                        width: screenWidth,
                        height: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: PersonalTheme.of(context).fadedalternate,
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: tareasCom >= 3 ? 3 / 3 : tareasCom / 3,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: PersonalTheme.of(context).tertiary,
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
                  children: [Text("$tareasCom/3",style: PersonalTheme.of(context).titleMedium,)],
                ),
          
                //Desafios
          
                SizedBox(
                  height: hcentecima * 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Desafio",
                      style: PersonalTheme.of(context).titleMedium,
                    )
                  ],
                ),
                SizedBox(
                  height: 2 * hcentecima,
                ),
                tareasCom < 3
                    ? Text(
                        "Bloqueado",
                        style: PersonalTheme.of(context).titleLarge,
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
                                builder: (BuildContext context, AsyncSnapshot snapshot) {
                                  if (snapshot.hasData) {
                                    return Row(
                                      children: [
                                        Text(snapshot.data,style: PersonalTheme.of(context).titleMedium,),
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
                            width: screenWidth,
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            height: 20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black),
                              color: PersonalTheme.of(context).primaryBackground,
                            ),
                            child: Stack(
                              children: [
                                Container(
                                  width: screenWidth,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: PersonalTheme.of(context).fadedalternate,
                                  ),
                                ),
                                FutureBuilder(
                                  future: _tareasDiariasController.conteoDD(),
                                  builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                                    if (snapshot.hasData) {
                                      return FractionallySizedBox(
                                        widthFactor: snapshot.data! >= 10 ? 10 / 10 : snapshot.data! / 10,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: PersonalTheme.of(context).tertiary,
                                          ),
                                        ),
                                      );
                                    } else {
                                      return const CircularProgressIndicator();
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: screenWidth,
                            child: Row(
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
                                          Text(snapshot.data,style: PersonalTheme.of(context).titleMedium,),
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
                                          Text(snapshot.data,style: PersonalTheme.of(context).titleMedium,),
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
                          ),
                        ],
                      ),
          
                //Recompensas
          
                SizedBox(
                  height: hcentecima,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}
