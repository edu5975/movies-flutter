import 'package:flutter/material.dart';
import 'package:practica2/src/database/databaseHelper.dart';
import 'package:practica2/src/models/favoriteDao.dart';
import 'package:practica2/src/utils/configuration.dart';

class DetailScreen extends StatefulWidget {
  DetailScreen({Key key}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  DatabaseHelper _database;
  IconData icon;

  @override
  void initState() {
    _database = DatabaseHelper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final movie =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;

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

    return Scaffold(
      appBar: AppBar(
        title: Text('${movie['title']}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            )),
        backgroundColor: Configuration.colorHeader,
        actions: [
          MaterialButton(
            child: Icon(
              icon,
              color: Colors.white,
            ),
            onPressed: () {
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
            },
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Opacity(
            opacity: 0.2,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      'https://image.tmdb.org/t/p/w500/${movie['posterPath']}'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
