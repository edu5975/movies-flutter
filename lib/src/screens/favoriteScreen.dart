import 'package:flutter/material.dart';
import 'package:practica2/src/database/databaseHelper.dart';
import 'package:practica2/src/models/favoriteDao.dart';
import 'package:practica2/src/utils/configuration.dart';
import 'package:practica2/views/cardFavorite.dart';

class FavoriteScreen extends StatefulWidget {
  FavoriteScreen({Key key}) : super(key: key);

  @override
  _PopularScreenState createState() => _PopularScreenState();
}

class _PopularScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DatabaseHelper database = DatabaseHelper();

    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites Movies"),
        backgroundColor: Configuration.colorHeader,
      ),
      body: FutureBuilder(
        future: database
            .getFavoritesMovies(1), //SE NECESITA MODIFICAR PARA MÁS USUARIOS
        builder:
            (BuildContext context, AsyncSnapshot<List<FavoriteDao>> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Error in this request"));
          } else if (snapshot.connectionState == ConnectionState.done) {
            return _listFavoriteMovies(snapshot.data);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _listFavoriteMovies(List<FavoriteDao> movies) {
    if (movies == null) return Center(child: Text("No hay favoritos"));
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) {
        FavoriteDao favorite = movies[index];
        return CardFavorite(
          favorite: favorite,
        );
      },
    );
  }
}
