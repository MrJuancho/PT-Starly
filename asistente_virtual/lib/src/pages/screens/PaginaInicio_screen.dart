import 'package:asistente_virtual/src/pages/Controllers/Home_controller.dart';
import 'package:asistente_virtual/src/pages/Widgets/_botonesFlotantes_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:asistente_virtual/src/pages/Widgets/_menuSuperior_widget.dart';
import 'package:asistente_virtual/src/pages/Widgets/_menuInferior_widget.dart';

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
          _isPress = true;
        });
        await Future.delayed(const Duration(seconds: 6));
        setState(() {
          _isPress = false;
        });
      },
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
                    'lib/src/assets/images/Nube.png',
                    fit: BoxFit.cover,
                  ),
                  Opacity(
                    opacity: _isPress ? 1 : 0,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: FutureBuilder<String>(
                        future: _homeController.fraseRandom(),
                        builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
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
              'lib/src/assets/images/download.jpg',
              width: wpart,
              height: hpart,
            ),
          ),
        ],
      ),
    );
  }
}
