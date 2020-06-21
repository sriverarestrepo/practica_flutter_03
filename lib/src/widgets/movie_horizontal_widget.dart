import 'package:flutter/material.dart';
import 'package:pelis_app_practica/src/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {

  final List<Pelicula> peliculas;

  MovieHorizontal({ @required this.peliculas });

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      height: _screenSize.height * 0.23,
      child: PageView(
        pageSnapping: false,
        controller: PageController(
          initialPage: 1,
          viewportFraction: 0.3,
        ),
        children: _tarjetas(context),
      ),
    );
  }

  List<Widget> _tarjetas(BuildContext context) {
      return peliculas.map(
        (pelicula) => Container(
          margin: EdgeInsets.only(right: 15.0),
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0) ,
                child: FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'), 
                  image: NetworkImage(pelicula.getPosterImg()),
                  fit: BoxFit.cover,
                  height: 160.0,
                ),
              ),
              SizedBox(height: 5.0,),
              Text(
                pelicula.title,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
        ),
      ).toList();
  }
}