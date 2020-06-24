import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:pelis_app_practica/src/models/pelicula_model.dart';

class PeliculasProvider {

  String _apiKey    = '6a1526ecbd7ae0ad00a01a496677c88b';
  String _url       = 'api.themoviedb.org';
  String _language = 'es-ES';

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
      _url,
      '3/movie/now_playing',
      {
        'api_key'   : _apiKey,
        'language'  : _language
      });

    return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>> getPopulares() async {

    if(_cargando) return [];
    _cargando = true;

    _popularesPage++;

    final url = Uri.https(
      _url,
      '3/movie/popular',
      {
        'api_key'   : _apiKey,
        'language'  : _language,
        'page'      : _popularesPage.toString(),
    });

    final respuesta = await _procesarRespuesta(url);

    _populares.addAll(respuesta);
    popularesSink(_populares);
    _cargando = false;
    return respuesta;
  }

}