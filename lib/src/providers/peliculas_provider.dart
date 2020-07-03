import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:pelis_app_practica/src/models/pelicula_model.dart';
import 'package:pelis_app_practica/src/constants/credenciales_contants.dart';

class PeliculasProvider {

  int _popularesPage  = 0;
  bool _cargando      = false;

  List<Pelicula> _populares = new List();

  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink => _popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;

  void disposeStreams(){
    _popularesStreamController?.close();
  }


  Future<List<Pelicula>> _procesarRespuesta(Uri url) async{
    final respuesta = await http.get(url);
    final decodedData = json.decode(respuesta.body);
    final peliculas = new Peliculas.fromJsonList(decodedData['results']);
      return peliculas.items;
  }

  Future<List<Pelicula>> getEnCines() async {

    final url = Uri.https(
      MOVIES_API_URL,
      '3/movie/now_playing',
      {
        'api_key'   : MOVIES_API_KEY,
        'language'  : MOVIES_API_LANGUAGE
      });

    return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>> getPopulares() async {

    if(_cargando) return [];

    _cargando = true;

    _popularesPage++;

    final url = Uri.https(
      MOVIES_API_URL,
      '3/movie/popular',
      {
        'api_key'   : MOVIES_API_KEY,
        'language'  : MOVIES_API_LANGUAGE,
        'page'      : _popularesPage.toString(),
    });

    final respuesta = await _procesarRespuesta(url);

    _populares.addAll(respuesta);
    popularesSink(_populares);

    _cargando = false;

    return respuesta;
  }

  Future<List<Pelicula>> buscarPelicula(String query) async {

    final url = Uri.https(
      MOVIES_API_URL,
      '3/search/movie',
      {
        'api_key'   : MOVIES_API_KEY,
        'language'  : MOVIES_API_LANGUAGE,
        'query'     : query
      });

    return await _procesarRespuesta(url);
  }

}