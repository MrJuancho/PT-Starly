import 'package:asistente_virtual/src/pages/Controllers/Home_controller.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:asistente_virtual/src/utils/utils_colors.dart';
import 'package:flutter/scheduler.dart';
import 'package:asistente_virtual/src/pages/Widgets/_menuSuperior_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Controler
  HomeController _homeController = new HomeController();

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
      body: Column(
        children: [
          _menuSuperior()
        ],
      ),
    );
  }

  Widget _menuSuperior() {
    return MenuSuperior();
  }

  void refresh() {
    setState(() {});
  }
}
