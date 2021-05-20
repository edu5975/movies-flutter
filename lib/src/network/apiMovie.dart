import 'dart:convert';

import 'package:http/http.dart';
import 'package:practica2/src/models/movieDao.dart';

class ApiMovie {
  int idVideo = 0;
  String urlMovie;

  ApiMovie(int id) {
    idVideo = id;
    urlMovie =
        'https://api.themoviedb.org/3/movie/${this.idVideo}?api_key=6d896830e872a71bd4035ef3cada74c5&language=en-EN';
  }

  Client http = Client();

  Future<MovieDao> getMovie() async {
    final response = await http.get(urlMovie);
    if (response.statusCode == 200) {
      var esp = jsonDecode(response.body);
      MovieDao movie = MovieDao().fromJson(esp);
      return movie;
    } else {
      return null;
    }
  }
}
