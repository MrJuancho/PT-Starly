import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:asistente_virtual/src/pages/provider/ping_provider.dart';
import 'package:asistente_virtual/src/api/enviroment.dart';
import 'package:asistente_virtual/src/utils/utils_colors.dart';

class MyTextFieldAndButton extends StatefulWidget {
  const MyTextFieldAndButton({Key? key}) : super(key: key);

  @override
  _MyTextFieldAndButtonState createState() => _MyTextFieldAndButtonState();
}

class _MyTextFieldAndButtonState extends State<MyTextFieldAndButton> {
  TextEditingController _textEditingController = TextEditingController();
  PingProvider personalizacion = new PingProvider();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prueba de APIS'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _textosybotones()
          ],
        ),
      ),
    );
  }

  Widget _textosybotones() {
    return Column(
      children: [
        /* TextField(
          controller: _textEditingController,
          decoration: InputDecoration(
            hintText: 'String',
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            final enteredText = _textEditingController.text;
            print('Entered text: $enteredText');
            var data = personalizacion.oneActividadPPB(int.parse(enteredText));
            print(data);
          },
          child: const Text('Probar'),
        ), */

        ElevatedButton(
          onPressed: () {
            var data = personalizacion.ping();
            print(data);
          },
          child: const Text('Probar'),
        ),
      ],
    );
  }
}
