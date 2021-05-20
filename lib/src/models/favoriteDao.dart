import 'dart:convert';

class FavoriteDao {
  // ignore: non_constant_identifier_names
  int id, id_user, id_movie;
  String posterPath;
  String backdropPath;
  String title;
  double voteAverage;
  String overview;
  String releaseDate;

  FavoriteDao(
      {this.id,
      // ignore: non_constant_identifier_names
      this.id_user,
      // ignore: non_constant_identifier_names
      this.id_movie,
      this.posterPath,
      this.backdropPath,
      this.title,
      this.voteAverage,
      this.overview,
      this.releaseDate});

  factory FavoriteDao.fromJSON(Map<String, dynamic> map) {
    return FavoriteDao(
        id: map['id'],
        id_user: map['id_user'],
        id_movie: map['id_movie'],
        posterPath: map['poster_path'],
        backdropPath: map['backdrop_path'],
        title: map['title'],
        voteAverage: map['vote_average'],
        overview: map['overview'],
        releaseDate: map['release_date']);
  }

  Map<String, dynamic> toJSON() {
    return {
      "id": id,
      "id_user": id_user,
      "id_movie": id_movie,
      "poster_path": posterPath,
      "backdrop_path": backdropPath,
      "title": title,
      "vote_average": voteAverage,
      "overview": overview,
      "release_date": releaseDate
    };
  }

  String favoriteToJSON() {
    final mapUser = this.toJSON();
    return json.encode(mapUser);
  }
}
