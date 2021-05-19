import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:practica2/src/models/castDao.dart';

class ApiActors {
  int idVideo = 0;
  String URL_TRENDING;

  ApiActors(int id) {
    idVideo = id;
    URL_TRENDING =
        'https://api.themoviedb.org/3/movie/${this.idVideo}/credits?api_key=09c037dbf395bdf3b388c259c483b488&language=en-EN';
  }
  Client http = Client();

  Future<List<CastDao>> getActors() async {
    final response = await http.get(URL_TRENDING);
    if (response.statusCode == 200) {
      var trailers = jsonDecode(response.body)['cast'] as List;
      List<CastDao> listTrailers =
          trailers.map((trailer) => CastDao.fromJSON(trailer)).toList();
      return listTrailers;
    } else {
      return null;
    }
  }
}
