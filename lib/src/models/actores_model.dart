
class Cast {

  List<Actor> items = new List();

  Cast.fromJsonList( List<dynamic> jsonList){

    if(jsonList == null ) return;

    for (var item in jsonList) {
      final actor = new Actor.fromJsonMap(item);
      items.add(actor);
    }

  }

}

class Actor {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Actor({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });

  Actor.fromJsonMap( Map<String, dynamic> jsonMap ){
    castId      = jsonMap['cast_id'];
    character   = jsonMap['character'];
    creditId    = jsonMap['credit_id'];
    gender      = jsonMap['gender'];
    id          = jsonMap['id'];
    name        = jsonMap['name'];
    order       = jsonMap['order'];
    profilePath = jsonMap['profile_path'];
  }

   getProfileImg(){
    if(profilePath == null) {
      return 'https://i.dlpng.com/static/png/6728146_preview.png';
    }else{
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }
  }
}


