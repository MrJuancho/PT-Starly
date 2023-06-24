// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:asistente_virtual/src/pages/Controllers/Personalizacion_controller.dart';
import 'package:asistente_virtual/src/pages/Controllers/_menuSuperior_controller.dart';
import 'package:asistente_virtual/src/pages/Widgets/_menuInferior_widget.dart';
import 'package:asistente_virtual/src/pages/flutter_flow/Theme_Personal.dart';
import 'package:asistente_virtual/src/utils/utils_sharedpref.dart';
import 'package:asistente_virtual/src/utils/utils_snackbar.dart';
import 'package:flutter/material.dart';

class PersonalizacionPage extends StatefulWidget {
  const PersonalizacionPage({super.key});

  @override
  _PersonalizacionPageState createState() => _PersonalizacionPageState();
}

class _PersonalizacionPageState extends State<PersonalizacionPage> {
  //Controllers
  final PersonalizacionController _personalizacionController = PersonalizacionController();
  final UtilsSharedPref _sharedPref = UtilsSharedPref();
  final MenuSuperiorController _menuSuperiorController = MenuSuperiorController();
  // Lista de variables booleanas para controlar la selección de botones
  final List<bool> _selections = <bool>[true, false];
  bool vertical = false;
  List<dynamic> monedasimg = [];
  List<dynamic> estrellasimg = [];
  List<dynamic> avComprados = [];
  List<dynamic> selectedImages = [];
  int idAV = 0;
  num monedasCantidad = 0;

  @override
  void initState() {
    super.initState();
    _personalizacionController.init(context, refresh);
    recepcion();
    //change();
  }

  void recepcion() async {
    List<dynamic> monedasimgtemp = await _personalizacionController.asistentesVXmoneda();
    List<dynamic> estrellasimgtemp = await _personalizacionController.asistentesVXestrella();
    List<dynamic> avcompradostemp = await _personalizacionController.asistentesComprados();
    int avactualtemp = await _personalizacionController.asistenteActual();
    num monedasCantidadtemp = int.parse(await _menuSuperiorController.coins());
    setState(() {
      monedasimg = monedasimgtemp;
      estrellasimg = estrellasimgtemp;
      avComprados = avcompradostemp;
      idAV = avactualtemp;
      selectedImages = _selections[0] ? monedasimg : estrellasimg;
      monedasCantidad = monedasCantidadtemp;
    });
  }

  void change() {
    setState(() {});
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
        child: Center(child: _body(reducedwindowWidth, reducedwindowHeight)),
      );
    } else {
      return _body(screenWidth, screenHeight);
    }
  }

  AppBar _appbar() {
    return AppBar(
      toolbarHeight: 60,
      title: Text(
        "Personalización",
        style: PersonalTheme.of(context).headlineSmall,
      ),
      automaticallyImplyLeading: false,
      //centerTitle: true,
      backgroundColor: PersonalTheme.of(context).primary,
      actions: [
        FutureBuilder(
          future: _menuSuperiorController.stars(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Row(
                children: [
                  const Icon(Icons.star_rounded),
                  const SizedBox(width: 1),
                  Text(
                    snapshot.data,
                    style: PersonalTheme.of(context).titleMedium,
                  ),
                  const SizedBox(width: 10),
                ],
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
        const SizedBox(
          width: 5,
        ),
        Row(
          children: [
            const Icon(Icons.attach_money_rounded),
            const SizedBox(width: 0),
            monedasCantidad == 0
                ? const CircularProgressIndicator()
                : Text(
                    monedasCantidad.toString(),
                    style: PersonalTheme.of(context).titleMedium,
                  ),
            const SizedBox(width: 15),
          ],
        ),
      ],
    );
  }

  Widget _body(double screenWidth, double screenHeight) {
    double hcentecima = screenHeight / 100;
    return Scaffold(
      appBar: _appbar(),
      bottomNavigationBar: MenuInferior(),
      body: Stack(
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
          SingleChildScrollView(
            child: Center(
              child: SizedBox(
                width: screenWidth,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: hcentecima),
                      child: Center(
                        child: idAV == 0
                            ? const CircularProgressIndicator()
                            : Image.asset('assets/images/AV/$idAV.png', height: screenHeight / 4, fit: BoxFit.fill),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: hcentecima),
                      child: ToggleButtons(
                        isSelected: _selections,
                        onPressed: (index) {
                          setState(() {
                            
                            for (int i = 0; i < _selections.length; i++) {
                              _selections[i] = i == index;
                            }
                            recepcion();
                          });
                        },
                        color: PersonalTheme.of(context).alternate,
                        fillColor: PersonalTheme.of(context).alternate,
                        selectedBorderColor: PersonalTheme.of(context).alternate,
                        children: [
                          Icon(
                            Icons.attach_money_rounded,
                            color: PersonalTheme.of(context).primaryText,
                          ),
                          Icon(
                            Icons.star_rounded,
                            color: PersonalTheme.of(context).primaryText,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: screenWidth >= 450 ? (screenHeight * 0.4) + hcentecima : (screenHeight * 0.328) + hcentecima,
            left: 0,
            right: 0,
            bottom: hcentecima,
            child: SingleChildScrollView(
              child: Center(
                child: SizedBox(
                  width: screenWidth,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(),
                    child: GridView.count(
                      crossAxisCount: 3,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: List.generate(selectedImages.length, (index) {
                        return GestureDetector(
                          onTap: () async {
                            if (avComprados.contains(selectedImages[index][0])) {
                              _personalizacionController.putnewAV(selectedImages[index][0]);
                              setState(() {
                                idAV = selectedImages[index][0];
                              });
                            } else {
                              if (_selections[0]) {
                                final monedas = await _sharedPref.readtodato('Alumno', 'balanceMonedas');
                                if (monedas >= selectedImages[index][1]) {
                                  // ignore: use_build_context_synchronously
                                  showModal(context, index, screenWidth);
                                } else {
                                  // ignore: use_build_context_synchronously
                                  UtilsSnackbar.show(context, 'Monedas insuficientes');
                                }
                              }else{
                                final estrellas = await _sharedPref.readtodato('Alumno', 'balanceEstrellas');
                                if (estrellas >= selectedImages[index][1]) {
                                  // ignore: use_build_context_synchronously
                                  showModalStar(context, index, screenWidth);
                                } else {
                                  // ignore: use_build_context_synchronously
                                  UtilsSnackbar.show(context, 'Estrellas insuficientes');
                                }
                              }
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: Center(
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/AV/${selectedImages[index][0]}.png',
                                    height: screenWidth >= 450 ? 120 : 100,
                                    fit: BoxFit.fill,
                                  ),
                                  SizedBox(
                                    height: 20,
                                    child: avComprados.contains(selectedImages[index][0])
                                        ? Text(
                                            'Adquirido',
                                            style: PersonalTheme.of(context).titleSmall,
                                          )
                                        : Text(
                                            'Costo: ${selectedImages[index][1]}',
                                            style: PersonalTheme.of(context).titleSmall,
                                          ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showModal(BuildContext context, int index, double screenWidth) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: PersonalTheme.of(context).primaryText,
        title: Text(
          'Compra de asistente virtual',
          style: PersonalTheme.of(context).titleLarge.override(
                color: PersonalTheme.of(context).primary,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
        ),
        content: SizedBox(
          height: 175, // Establece la altura deseada para tu contenido
          child: Column(
            children: [
              Text(
                "¿Deseas comprar este asistente virtual?",
                style: PersonalTheme.of(context).titleMedium.override(
                      color: PersonalTheme.of(context).primary,
                      fontFamily: 'Poppins',
                    ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 25,
              ),
              Image.asset(
                'assets/images/AV/${selectedImages[index][0]}.png',
                height: screenWidth >= 450 ? 120 : 100,
                fit: BoxFit.fill,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancelar',
                style: PersonalTheme.of(context).titleSmall.override(
                      color: PersonalTheme.of(context).primary,
                      fontFamily: 'Poppins',
                    ),
              )),
          TextButton(
            onPressed: () {
              _personalizacionController.buynewAV(selectedImages[index][0]);
              setState(() {
                avComprados.add(selectedImages[index][0]);
                monedasCantidad = monedasCantidad - selectedImages[index][1];
              });
              Navigator.of(context).pop();
            },
            child: Text(
              'Comprar',
              style: PersonalTheme.of(context).titleSmall.override(
                    color: PersonalTheme.of(context).primary,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  void showModalStar(BuildContext context, int index, double screenWidth) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: PersonalTheme.of(context).primaryText,
        title: Text(
          'Reclamar asistente virtual',
          style: PersonalTheme.of(context).titleLarge.override(
                color: PersonalTheme.of(context).primary,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
        ),
        content: SizedBox(
          height: 200, // Establece la altura deseada para tu contenido
          child: Column(
            children: [
              Text(
                "Reclamaras este asistente virtual por tu esfuerzo\nFELICIDADES!",
                style: PersonalTheme.of(context).titleMedium.override(
                      color: PersonalTheme.of(context).primary,
                      fontFamily: 'Poppins',
                    ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 25,
              ),
              Image.asset(
                'assets/images/AV/${selectedImages[index][0]}.png',
                height: screenWidth >= 450 ? 120 : 100,
                fit: BoxFit.fill,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancelar',
                style: PersonalTheme.of(context).titleSmall.override(
                      color: PersonalTheme.of(context).primary,
                      fontFamily: 'Poppins',
                    ),
              )),
          TextButton(
            onPressed: () {
              _personalizacionController.claimNewAVStars(selectedImages[index][0]);
              setState(() {
                avComprados.add(selectedImages[index][0]);
              });
              Navigator.of(context).pop();
            },
            child: Text(
              'Comprar',
              style: PersonalTheme.of(context).titleSmall.override(
                    color: PersonalTheme.of(context).primary,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                  ),
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
