import 'package:flutter/material.dart';
import 'package:practica2/src/models/popularDao.dart';

class CardPopular extends StatelessWidget {
  const CardPopular({
    Key key,
    @required this.popular,
  }) : super(key: key);

  final PopularDao popular;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black87,
            offset: Offset(0.0, 5.0),
            blurRadius: 2.5,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Container(
              child: FadeInImage(
                placeholder: AssetImage('assets/activity_indicator.gif'),
                image: NetworkImage(
                    'https://image.tmdb.org/t/p/w500/${popular.backdropPath}'),
                fadeInDuration: Duration(milliseconds: 100),
              ),
            ),
            Opacity(
              opacity: 0.65,
              child: Container(
                height: 55.0,
                color: Colors.black,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      " " + popular.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    MaterialButton(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          "/detail",
                          arguments: {
                            'title': popular.title,
                            'id': popular.id,
                            'overview': popular.overview,
                            'posterPath': popular.posterPath,
                          },
                        );
                      },
                      child: Icon(
                        Icons.chevron_right,
                        color: Colors.white,
                      ),
                    )
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
