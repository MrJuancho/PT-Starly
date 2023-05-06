import 'package:asistente_virtual/src/pages/Controllers/Personalizacion_controller.dart';
import 'package:asistente_virtual/src/pages/Widgets/_menuInferior_widget.dart';
import 'package:asistente_virtual/src/utils/utils_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class PersonalizacionPage extends StatefulWidget {
  @override
  _PersonalizacionPageState createState() => _PersonalizacionPageState();
}

class _PersonalizacionPageState extends State<PersonalizacionPage> {
  //Controllers
  PersonalizacionController _personalizacionController =
      PersonalizacionController();

  // Lista de variables booleanas para controlar la selección de botones
  final List<bool> _selections = <bool>[true, false];
  bool vertical = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //método para iniciar controlador
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _personalizacionController.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      body: _body(),
      bottomNavigationBar: MenuInferior(),
    );
  }

  AppBar _appbar() {
    return AppBar(
      toolbarHeight: 60,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded),
        onPressed: () {
          _personalizacionController.pantallaanterior(context);
        },
      ),
      title: const Text("Personalización"),
      centerTitle: true,
      backgroundColor: UtilsColors.primaryColor,
    );
  }

  Widget _body() {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    double wimage = (w / 2);
    double himage = (h / 2);
    double wcentecima = w / 100;
    double hcentecima = h / 100;
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: hcentecima),
          child: Center(
            child: Image.asset(
              'assets/images/AV.png',
              width: wimage,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: hcentecima),
          child: ToggleButtons(
            children: [
              const Icon(Icons.attach_money_rounded),
              const Icon(Icons.star_rounded),
            ],
            isSelected: _selections,
            onPressed: (index) {
              setState(() {
                for (int i = 0; i < _selections.length; i++) {
                  _selections[i] = i == index;
                }
              });
            },
            color: UtilsColors.primaryBackgroundColor,
            fillColor: UtilsColors.primaryOpacityColor,
            selectedBorderColor: UtilsColors.primaryColor,
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: hcentecima,bottom: hcentecima),
            child: ConstrainedBox(
              
                constraints: BoxConstraints(),
                child: GridView.count(
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: List.generate(20, (index) {
                    return Container(
                      margin: const EdgeInsets.all(8),
                      color: Colors.grey[300],
                      child: Center(
                        child: Text(
                          'Item $index',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
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
