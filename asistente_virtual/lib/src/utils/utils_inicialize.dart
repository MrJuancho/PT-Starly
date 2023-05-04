import 'package:asistente_virtual/src/pages/Controllers/TareasDiarias_controller.dart';
import 'package:asistente_virtual/src/utils/utils_sharedpref.dart';

class UtilsInicialize {
  final UtilsSharedPref _sharedPref = UtilsSharedPref();
  final TareasDiariasController _tareasDiariasController =
      TareasDiariasController();

  Future initDD(String key, String value) async {
    if (await _sharedPref.contains(key)) {
      print('Desafio asignado');
      if (await _sharedPref.existField(key, value)) {
        print('Existe expiracion');
        DateTime fecha = DateTime.now();
        //DateTime fecha = DateTime(2023, 5, 4, 13, 30);
        _sharedPref.printAllSharedPreferences(key);
        final fechajson = await _sharedPref.readtodato(key, value);
        final fechastring = fechajson.toString();
        DateTime conversion = DateTime.parse(fechastring);
        print(conversion.runtimeType);
        if (conversion.year == fecha.year &&
            conversion.month == fecha.month &&
            conversion.day < fecha.day) {
          _sharedPref.remove(key);
          print('Desafio anterior removido');
        }
      }
    } else {
      print('no hay desafio y se va a crear');
      _tareasDiariasController.desafioRandom();
    }
  }
}
