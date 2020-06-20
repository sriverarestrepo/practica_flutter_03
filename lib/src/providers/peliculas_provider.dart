import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pelis_app_practica/src/models/pelicula_model.dart';

class PeliculasProvider {

  String _apiKey    = '6a1526ecbd7ae0ad00a01a496677c88b';
  String _url       = 'api.themoviedb.org';
  String _languajge = 'es-ES';

  Future<List<Pelicula>> getEnCines() async {

    final url = Uri.https(
      _url,
      '3/movie/now_playing',
      {
        'api_key'   : _apiKey,
        'language'  : _languajge
      });

    final respuesta = await http.get(url);
    
    final decodedData = json.decode(respuesta.body);

    final peliculas = new Peliculas.fromJsonList(decodedData['results']);

    return peliculas.items;

  }

}