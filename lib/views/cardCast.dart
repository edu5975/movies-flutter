import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practica2/src/models/castDao.dart';

class CardCast extends StatelessWidget {
  const CardCast({
    Key key,
    @required this.cast,
  }) : super(key: key);

  final CastDao cast;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      padding: EdgeInsets.all(5),
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: cast.profilePath == null
                ? AssetImage("assets/profileDefault.jpg")
                : NetworkImage(
                    "https://image.tmdb.org/t/p/w500/${cast.profilePath}"),
            backgroundColor: Colors.blue,
            radius: 30,
          ),
          SizedBox(width: 5),
          Text(
            cast.name,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
          SizedBox(width: 5),
          Text(
            cast.character,
            maxLines: 1,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
