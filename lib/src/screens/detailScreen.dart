import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final movie =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;

    return Stack(
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
    );
  }
}
