import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practica2/src/models/favoriteDao.dart';

class CardFavorite extends StatelessWidget {
  const CardFavorite({Key key, @required this.favorite}) : super(key: key);

  final FavoriteDao favorite;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blue[900],
            offset: Offset(5, 5),
            blurRadius: 3,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context)
                  .size
                  .width, //*.5 <- Es equivalente a un 50%
              child: FadeInImage(
                placeholder: AssetImage('assets/Icons/activity_indicator.gif'),
                image: NetworkImage(
                    'https://image.tmdb.org/t/p/w500/${favorite.backdropPath}'),
                fadeInDuration: Duration(milliseconds: 100),
              ),
            ),
            Opacity(
              opacity: .5,
              child: Container(
                padding: EdgeInsets.all(15),
                height: 55,
                color: Colors.black,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      favorite.title,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    MaterialButton(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Icon(
                        Icons.chevron_right_rounded,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/details',
                          arguments: {
                            'id': favorite.id_movie,
                            'title': favorite.title,
                            'overview': favorite.overview,
                            'poster_path': favorite.posterPath,
                            'backdrop_path': favorite.backdropPath,
                            'release_date': favorite.releaseDate,
                            'vote_average': favorite.voteAverage
                          },
                        ).whenComplete(() => Navigator.pushReplacementNamed(
                            context, '/favorite'));
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
