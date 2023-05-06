import 'package:asistente_virtual/src/pages/Widgets/_menuInferior_widget.dart';
import 'package:asistente_virtual/src/pages/Widgets/_menuSuperior_widget.dart';
import 'package:asistente_virtual/src/utils/utils_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ActividadesPage extends StatefulWidget {
  @override
  _ActividadesPageState createState() => _ActividadesPageState();
}

class _ActividadesPageState extends State<ActividadesPage> {
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
    return WillPopScope(
      onWillPop: onBackPressed,
      child: Scaffold(
        appBar: MenuSuperior(),
        body: _body(),
        bottomNavigationBar: MenuInferior(),
      ),
    );
  }

  Future<bool> onBackPressed() async {
    Navigator.pop(context);
    return false;
  }

  Widget _body() {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    double wimage = (w / 2);
    double himage = (h / 2);
    double wcentecima = w / 100;
    double hcentecima = h / 100;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: hcentecima, bottom: hcentecima),
            child: ConstrainedBox(
                constraints: BoxConstraints(),
                child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: List.generate(5, (index) {
                    final temp = index + 1;
                    return Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(8),
                          color: Colors.grey[300],
                          child: Center(
                            child: Image.asset(
                                'assets/images/download.jpg',
                                width: w / 2.1,
                                fit: BoxFit.fill),
                          ),
                        ),
                        Text(
                          'Actividad\n$temp',
                          style: TextStyle(
                              fontFamily: 'Comfortaa',
                              fontSize: hcentecima * 2),
                          textAlign: TextAlign.center,
                        )
                      ],
                    );
                  }),
                )),
          ),
        ),
      ],
    );
  }

  void refresh() {
    setState(() {});
  }
}
