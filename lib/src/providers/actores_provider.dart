import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:pelis_app_practica/src/models/actores_model.dart';
import 'package:pelis_app_practica/src/constants/credenciales_contants.dart';


class ActoresProvider {
  
  Future<List<Actor>> _procesarRespuesta(Uri url) async{
    final respuesta = await http.get(url);
    final decodedData = json.decode(respuesta.body);
    final cast = new Cast.fromJsonList(decodedData['cast']);
      return cast.items;
  }

  Future<List<Actor>> getCast(String peliculaId) async{
      final url = Uri.https(
      MOVIES_API_URL,
      '3/movie/$peliculaId/credits',
      {
        'api_key'   : MOVIES_API_KEY,
        'language'  : MOVIES_API_LANGUAGE
      });

    return await _procesarRespuesta(url);
  }
}