import 'package:asistente_virtual/src/pages/Controllers/Home_controller.dart';
import 'package:asistente_virtual/src/pages/Widgets/_botonesFlotantes_widget.dart';
import 'package:flutter/material.dart';
import 'package:asistente_virtual/src/utils/utils_colors.dart';
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
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: MenuSuperior(),
      body: Column(
        children: [
          IconButton(
              onPressed: () async {
                final  frase = await _homeController.fraseRandom();
                showModal(context, frase);
              },
              icon: const Icon(Icons.accessibility_new_rounded))
        ],
      ),
      bottomNavigationBar: MenuInferior(),
      floatingActionButton: BotonesFlotantes(),
    );
  }

  void refresh() {
    setState(() {});
  }

  void showModal(BuildContext context, String frase) {
    showDialog(
      context: context,
      builder: (BuildContext) => AlertDialog(
        content: Text("Sabias que?\n$frase"),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Bye'))
        ],
      ),
    );
  }
}
