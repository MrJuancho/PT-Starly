// ignore_for_file: file_names, library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';

//Paquete de la api a probar
import 'package:asistente_virtual/src/pages/Provider/TblAlumno_provider.dart';

import '../Provider/CatPropPersonalizacion_provider.dart';

class MyTextFieldAndButton extends StatefulWidget {
  const MyTextFieldAndButton({super.key});

  @override
  _MyTextFieldAndButtonState createState() => _MyTextFieldAndButtonState();
}

class _MyTextFieldAndButtonState extends State<MyTextFieldAndButton> {
  final TextEditingController _textEditingController = TextEditingController();
  final TextEditingController _textEditingController1 = TextEditingController();
  final TextEditingController _textEditingController2 = TextEditingController();
  final TextEditingController _textEditingController3 = TextEditingController();
  final TblAlumnoProvider personalizacion = TblAlumnoProvider();
  final CatPropPersonalizacionProvider _catPropPersonalizacionProvider =
      CatPropPersonalizacionProvider();

  @override
  void dispose() {
    _textEditingController.dispose();
    _textEditingController1.dispose();
    _textEditingController2.dispose();
    _textEditingController3.dispose();
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
          children: [_textosybotones()],
        ),
      ),
    );
  }

  Widget _textosybotones() {
    return Column(
      children: [
        //campo de texto para meter a la api
        TextField(
          controller: _textEditingController,
          decoration: const InputDecoration(
            hintText: 'String',
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () async {
            final texto = _textEditingController.text;
            final jsondata =
                await _catPropPersonalizacionProvider.oneProp(int.parse(texto));
            //final frase = jsonDecode(jsondata);
            final frasedato = jsondata['descProp'];
            showModal(context, frasedato);
          },
          child: const Text("Submit"),
        ),

        /* ElevatedButton(
          onPressed: () {
            var data = personalizacion.ping();
            print(data);
          },
          child: const Text('Probar'),
        ), */
        /* TextField(
          controller: _textEditingController1,
          decoration: InputDecoration(
            hintText: 'user',
          ),
        ),
        TextField(
          controller: _textEditingController2,
          decoration: InputDecoration(
            hintText: 'monedas',
          ),
        ),
        TextField(
          controller: _textEditingController3,
          decoration: InputDecoration(
            hintText: 'estrellas',
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            var enteredText1 = _textEditingController1.text;
            var enteredText2 = _textEditingController2.text;
            var enteredText3 = _textEditingController3.text;
            if (enteredText2.isEmpty) {
              print("moneda null");
              enteredText2 = "0";
            } else if (enteredText3.isEmpty) {
              print("estrellas null");
              enteredText3 = "0";
            }
            print('Entered text: $enteredText1 $enteredText2 $enteredText3');
            personalizacion.putMonedasEstrellas(
                enteredText1, int.parse(enteredText2), int.parse(enteredText3));
          },
          child: const Text('Probar'),
        ), */
      ],
    );
  }

  void showModal(BuildContext context, String frase) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
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
