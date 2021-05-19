import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:practica2/src/models/trailerDao.dart';

class ApiTrailler {
  int idPelicula = 0;
  String URL_TRENDING;

  ApiTrailler(int id) {
    idPelicula = id;
    URL_TRENDING =
        'https://api.themoviedb.org/3/movie/${this.idPelicula}/videos?api_key=09c037dbf395bdf3b388c259c483b488&language=es-EN';
  }
  Client http = Client();

  Future<List<TrailerDao>> getTrailer() async {
    final response = await http.get(URL_TRENDING);
    if (response.statusCode == 200) {
      var trailers = jsonDecode(response.body)['results'] as List;
      List<TrailerDao> listTrailers =
          trailers.map((trailer) => TrailerDao.fromJSON(trailer)).toList();
      return listTrailers;
    } else {
      return null;
    }
  }
}
