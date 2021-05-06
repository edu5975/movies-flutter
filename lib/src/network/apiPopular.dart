import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:practica2/src/models/popularDao.dart';

class ApiPopular {
  // ignore: non_constant_identifier_names
  final String URL_POPULAR =
      "https://api.themoviedb.org/3/movie/popular?api_key=6d896830e872a71bd4035ef3cada74c5&language=es-MX&page=1";
  Client http = Client();

  Future<List<PopularDao>> getAllPopular() async {
    final response = await http.get(URL_POPULAR);
    if (response.statusCode == 200) {
      var popular = jsonDecode(response.body)['results'] as List;
      List<PopularDao> listPopular =
          popular.map((movie) => PopularDao.fromJSON(movie)).toList();
      return listPopular;
    } else {
      return null;
    }
  }
}
