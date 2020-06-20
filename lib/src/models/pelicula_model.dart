
class Peliculas {

  List<Pelicula> items = new List();

  Peliculas();

  Peliculas.fromJsonList( List<dynamic> jsonList){

    if(jsonList == null ) return;

    for (var item in jsonList) {
      final pelicula = new Pelicula.fromJsonMap(item);
      items.add(pelicula);
    }

  }

}


class Pelicula {

  double popularity;
  int voteCount;
  bool video;
  String posterPath;
  int id;
  bool adult;
  String backdropPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String title;
  double voteAverage;
  String overview;
  String releaseDate;

  Pelicula({
    this.popularity,
    this.voteCount,
    this.video,
    this.posterPath,
    this.id,
    this.adult,
    this.backdropPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.title,
    this.voteAverage,
    this.overview,
    this.releaseDate,
  });

  Pelicula.fromJsonMap( Map<String, dynamic> jsonMap){
    popularity       = jsonMap['popularity'] / 1;
    voteCount        = jsonMap['vote_count'];
    video            = jsonMap['video'];
    posterPath       = jsonMap['poster_path'];
    id               = jsonMap['id'];
    adult            = jsonMap['adult'];
    backdropPath     = jsonMap['backdrop_path'];
    originalLanguage = jsonMap['original_language'];
    originalTitle    = jsonMap['original_title'];
    genreIds         = jsonMap['genre_ids'].cast<int>();
    title            = jsonMap['title'];
    voteAverage      = jsonMap['vote_average'] / 1;
    overview         = jsonMap['overview'];
    releaseDate      = jsonMap['release_date'];
  }

  getPosterImg(){

    if(posterPath == null) {
      return 'https://i.ya-webdesign.com/images/image-not-available-png-19.png';
    }else{
      return 'https://image.tmdb.org/t/p/w500/$posterPath';
    }
  }
}

