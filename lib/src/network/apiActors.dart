import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:practica2/src/models/castDao.dart';

class ApiActors {
  int idVideo = 0;
  String urlActor;

  ApiActors(int id) {
    idVideo = id;
    urlActor =
        'https://api.themoviedb.org/3/movie/${this.idVideo}/credits?api_key=09c037dbf395bdf3b388c259c483b488&language=en-EN';
  }
  Client http = Client();

  Future<List<CastDao>> getActors() async {
    final response = await http.get(urlActor);
    if (response.statusCode == 200) {
      var trailers = jsonDecode(response.body)['cast'] as List;
      List<CastDao> listActors =
          trailers.map((trailer) => CastDao.fromJSON(trailer)).toList();
      print(listActors);
      return listActors;
    } else {
      return null;
    }
  }
}
