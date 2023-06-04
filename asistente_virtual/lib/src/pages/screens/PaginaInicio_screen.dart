import 'package:asistente_virtual/src/pages/Controllers/Home_controller.dart';
import 'package:asistente_virtual/src/pages/Widgets/_botonesFlotantes_widget.dart';
import 'package:asistente_virtual/src/pages/Widgets/_menuInferior_widget.dart';
import 'package:asistente_virtual/src/pages/Widgets/_menuSuperior_widget.dart';
import 'package:asistente_virtual/src/pages/flutter_flow/Theme_Personal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Controler
  final HomeController _homeController = HomeController();
  bool _isPress = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //método para iniciar controlador
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _homeController.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MenuSuperior(),
      body: _asistente(),
      bottomNavigationBar: MenuInferior(),
      floatingActionButton: BotonesFlotantes(),
      backgroundColor: PersonalTheme.of(context).primaryBackground,
    );
  }

  void refresh() {
    setState(() {});
  }

  Widget _asistente() {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    double wpart = w / 1.5;
    double hpart = h / 1.5;

    return GestureDetector(
      onTap: () async {
        setState(() {
          _homeController.interaccionesAV();
          _isPress = true;
        });
        await Future.delayed(const Duration(seconds: 6));
        setState(() {
          _isPress = false;
        });
      },
      child: Container(
          width: MediaQuery.of(context).size.width * 1.0,
          height: MediaQuery.of(context).size.height * 1,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [PersonalTheme.of(context).primary, PersonalTheme.of(context).tertiary],
              stops: [0.0, 1.0],
              begin: AlignmentDirectional(0.0, -1.0),
              end: AlignmentDirectional(0, 1.0),
            ),
          ),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(left: w - wpart, top: hpart / 13),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 600),
                  width: _isPress ? wpart : 0,
                  height: _isPress ? hpart / 2 : 0,
                  child: Stack(
                    children: [
                      Image.asset(
                        'assets/images/home/Nube.png',
                        fit: BoxFit.cover,
                      ),
                      Opacity(
                        opacity: _isPress ? 1 : 0,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: FutureBuilder<String>(
                            future: _homeController.fraseRandom(),
                            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                  "\n¿Sabias que?\n${snapshot.data}",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                  textAlign: TextAlign.justify,
                                );
                              } else {
                                return Text('Cargando frase...');
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  (w - wpart) / 2,
                  (h - hpart) / 2,
                  0,
                  0,
                ),
                child: Image.asset(
                  'assets/images/home/download.jpg',
                  width: wpart,
                  height: hpart,
                ),
              ),
            ],
          )),
    );
  }
}
