import 'package:flutter/material.dart';
import 'package:practica2/src/database/databaseHelper.dart';
import 'package:practica2/src/models/castDao.dart';
import 'package:practica2/src/models/favoriteDao.dart';
import 'package:practica2/src/models/movieDao.dart';
import 'package:practica2/src/models/trailerDao.dart';
import 'package:practica2/src/network/apiActors.dart';
import 'package:practica2/src/network/apiMovie.dart';
import 'package:practica2/src/network/apiTrailler.dart';
import 'package:practica2/src/utils/configuration.dart';
import 'package:practica2/views/cardCast.dart';
import 'package:practica2/views/cardGenre.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailScreen extends StatefulWidget {
  DetailScreen({Key key}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  DatabaseHelper _database;
  IconData icon;
  Map<String, dynamic> movie;

  ApiMovie apiMovie;
  ApiTrailler apiTrailler;
  ApiActors apiActors;

  @override
  void initState() {
    _database = DatabaseHelper();
    super.initState();
  }

  bool favorite = true;

  @override
  Widget build(BuildContext context) {
    movie = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    apiTrailler = ApiTrailler(movie['id']);
    apiActors = ApiActors(movie['id']);
    apiMovie = ApiMovie(movie['id']);

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

    return Scaffold(
      body: FutureBuilder(
        future: apiMovie.getMovie(),
        builder: (BuildContext context, AsyncSnapshot<MovieDao> movie) {
          if (movie.hasError) {
            return Center(child: Text("Error in this request"));
          } else if (movie.connectionState == ConnectionState.done) {
            return FutureBuilder(
              future: apiActors.getActors(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<CastDao>> cast) {
                if (cast.hasError) {
                  return Center(child: Text("Error in this request"));
                } else if (cast.connectionState == ConnectionState.done) {
                  return _body(movie.data, cast.data);
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addFavoritos();
        },
        child: Icon(icon),
        backgroundColor: Colors.green,
      ),
    );
  }

  Widget _body(MovieDao movieDao, List<CastDao> castDao) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: size.height * 0.4,
          child: Stack(
            children: <Widget>[
              Container(
                height: size.height * 0.4 - 50,
                child: _youtubePlayer(),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: size.width * 0.8,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      topLeft: Radius.circular(40),
                    ),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 5),
                        blurRadius: 50,
                        color: Colors.black54,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      movieDao.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          child: Text(
            "Description",
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          child: Text(
            movieDao.overview,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          child: Text(
            "Genres",
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        _listGenres(movieDao.genres),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          child: Text(
            "Cast",
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        _listActors(castDao)
      ],
    );
  }

  Widget _listActors(List<CastDao> actors) {
    if (actors.length == null) return Text("ERROR");
    return Flexible(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actors.length,
        itemBuilder: (context, index) {
          CastDao cast = actors[index];
          return CardCast(
            cast: cast,
          );
        },
      ),
    );
  }

  Widget _listGenres(List<Genres> genres) {
    if (genres.length == null) return Text("ERROR");
    return Container(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: genres.length,
        itemBuilder: (context, index) {
          String genre = genres[index].name;
          return CardGenre(
            genre: genre,
          );
        },
      ),
    );
  }

  _youtubePlayer() {
    return FutureBuilder(
      future: apiTrailler.getTrailer(),
      builder:
          (BuildContext context, AsyncSnapshot<List<TrailerDao>> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text("Error in this request"));
        } else if (snapshot.connectionState == ConnectionState.done) {
          YoutubePlayerController controllerYoutube = YoutubePlayerController(
            initialVideoId: snapshot.data[0].key.toString(),
            flags: YoutubePlayerFlags(
              autoPlay: false,
              mute: true,
            ),
          );
          return YoutubePlayer(
            controller: controllerYoutube,
            actionsPadding: EdgeInsets.all(10),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
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

/*Stack(
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
          ),
        ],
      ), */
