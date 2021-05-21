import 'package:flutter/material.dart';
import 'package:practica2/src/models/castDao.dart';
import 'package:practica2/src/models/movieDao.dart';
import 'package:practica2/src/models/trailerDao.dart';
import 'package:practica2/src/network/apiActors.dart';
import 'package:practica2/src/network/apiMovie.dart';
import 'package:practica2/src/network/apiTrailler.dart';
import 'package:practica2/src/utils/configuration.dart';
import 'package:practica2/views/buttonFavorite.dart';
import 'package:practica2/views/cardCast.dart';
import 'package:practica2/views/cardGenre.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailScreen extends StatefulWidget {
  DetailScreen({Key key}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Map<String, dynamic> movie;

  ApiMovie apiMovie;
  ApiTrailler apiTrailler;
  ApiActors apiActors;

  @override
  Widget build(BuildContext context) {
    movie = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    apiTrailler = ApiTrailler(movie['id']);
    apiActors = ApiActors(movie['id']);
    apiMovie = ApiMovie(movie['id']);

    return Scaffold(
        body: FutureBuilder(
      future: apiMovie.getMovie(),
      builder: (BuildContext context, AsyncSnapshot<MovieDao> movie) {
        if (movie.hasError) {
          return Center(child: Text("Error in this request"));
        } else if (movie.connectionState == ConnectionState.done) {
          return FutureBuilder(
            future: apiActors.getActors(),
            builder: (BuildContext context, AsyncSnapshot<List<CastDao>> cast) {
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
    ));
  }

  Widget _body(MovieDao movieDao, List<CastDao> castDao) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      slivers: <Widget>[
        SliverAppBar(
          backgroundColor: Configuration.colorHeader,
          expandedHeight: 300.0,
          stretch: true,
          onStretchTrigger: () {
            // Function callback for stretch
            return Future<void>.value();
          },
          flexibleSpace: FlexibleSpaceBar(
            stretchModes: const <StretchMode>[
              StretchMode.zoomBackground,
              StretchMode.blurBackground,
              StretchMode.fadeTitle,
            ],
            background: _youtubePlayer(),
          ),
          actions: [
            ButtonFavorites(movie: movie),
          ],
          actionsIconTheme: IconThemeData(
            size: 30.0,
            color: Colors.red,
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            <Widget>[
              _infoMovie(movieDao),
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
                  style: TextStyle(
                    fontSize: 16,
                  ),
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
              _listActors(castDao),
            ],
          ),
        ),
      ],
    );
  }

  Widget _listActors(List<CastDao> actors) {
    if (actors.length == null) return Text("ERROR");
    return Container(
      height: 160,
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

  Widget _youtubePlayer() {
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

  Widget _infoMovie(MovieDao movieDao) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      child: Row(
        children: [
          Container(
            height: 150,
            width: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    'https://image.tmdb.org/t/p/w500/${movieDao.posterPath}'),
              ),
            ),
          ),
          SizedBox(width: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: size.width * .6,
                child: Text(
                  movieDao.title,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Text(
                    movieDao.voteAverage.toString(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Builder(
                    builder: (BuildContext context) {
                      IconData i1 = Icons.star_border,
                          i2 = Icons.star_border,
                          i3 = Icons.star_border,
                          i4 = Icons.star_border,
                          i5 = Icons.star_border;
                      if (movieDao.voteAverage >= 1) i1 = Icons.star_half;
                      if (movieDao.voteAverage >= 2) i1 = Icons.star;
                      if (movieDao.voteAverage >= 3) i2 = Icons.star_half;
                      if (movieDao.voteAverage >= 4) i2 = Icons.star;
                      if (movieDao.voteAverage >= 5) i3 = Icons.star_half;
                      if (movieDao.voteAverage >= 6) i3 = Icons.star;
                      if (movieDao.voteAverage >= 7) i4 = Icons.star_half;
                      if (movieDao.voteAverage >= 8) i4 = Icons.star;
                      if (movieDao.voteAverage >= 9) i5 = Icons.star_half;
                      if (movieDao.voteAverage == 10) i5 = Icons.star;

                      return Row(
                        children: [
                          Icon(i1, color: Colors.red),
                          Icon(i2, color: Colors.red),
                          Icon(i3, color: Colors.red),
                          Icon(i4, color: Colors.red),
                          Icon(i5, color: Colors.red),
                        ],
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 5),
              Text(
                'Reseale date: ' + movieDao.releaseDate,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
