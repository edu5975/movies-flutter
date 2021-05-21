import 'package:flutter/material.dart';
import 'package:practica2/src/database/databaseHelper.dart';
import 'package:practica2/src/models/favoriteDao.dart';

class ButtonFavorites extends StatefulWidget {
  ButtonFavorites({
    Key key,
    @required this.movie,
  }) : super(key: key);

  final Map<String, dynamic> movie;

  @override
  _ButtonFavoritesState createState() => _ButtonFavoritesState(movie: movie);
}

class _ButtonFavoritesState extends State<ButtonFavorites> {
  _ButtonFavoritesState({
    @required this.movie,
  });
  final Map<String, dynamic> movie;

  DatabaseHelper _database;
  IconData icon;
  bool favorite = true;

  @override
  Widget build(BuildContext context) {
    print(movie);
    _database = DatabaseHelper();
    if (favorite) {
      favorite = false;
      Future<FavoriteDao> _objFavorite =
          _database.getFavoriteMovies(movie['id'], 1);
      _objFavorite.then(
        (value) => {
          if (value != null)
            setState(() {
              icon = Icons.favorite;
            })
          else
            setState(() {
              icon = Icons.favorite_border;
            })
        },
      );
    }

    return Padding(
      padding: EdgeInsets.only(right: 20.0),
      child: GestureDetector(
        onTap: () {
          addFavoritos();
        },
        child: Icon(
          icon,
          size: 26.0,
        ),
      ),
    );
  }

  addFavoritos() {
    FavoriteDao favorite = FavoriteDao(
        id_user: 1, //SUSTITUIR DESPUES
        id_movie: movie['id'],
        posterPath: movie['poster_path'],
        backdropPath: movie['backdrop_path'],
        title: movie['title'],
        voteAverage: movie['vote_average'],
        overview: movie['overview'],
        releaseDate: movie['release_date']);
    Future<FavoriteDao> _objFavorite =
        _database.getFavoriteMovies(movie['id'], 1);
    _objFavorite.then(
      (value) => {
        if (value == null)
          {
            _database
                .insert('tbl_favorite', favorite.toJSON())
                .then((row) => {print('$row')}),
            print('Pelicula registrada en favoritos'),
            print(favorite.posterPath),
            setState(() {
              icon = Icons.favorite;
            }),
          }
        else
          {
            favorite.id = value.id,
            _database.delete('tbl_favorite', favorite.id),
            print('Pelcula eliminada de favoritos'),
            setState(() {
              icon = Icons.favorite_border;
            }),
          }
      },
    );
  }
}
