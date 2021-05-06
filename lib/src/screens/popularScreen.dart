import 'package:flutter/material.dart';
import 'package:practica2/src/models/popularDao.dart';
import 'package:practica2/src/network/apiPopular.dart';
import 'package:practica2/views/cardPopular.dart';

class PopularScreen extends StatefulWidget {
  PopularScreen({Key key}) : super(key: key);

  @override
  _PopularScreenState createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {
  ApiPopular apiPopular;
  @override
  void initState() {
    super.initState();
    apiPopular = ApiPopular();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Popular Movies"),
      ),
      body: FutureBuilder(
        future: apiPopular.getAllPopular(),
        builder:
            (BuildContext context, AsyncSnapshot<List<PopularDao>> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Error in this request"));
          } else if (snapshot.connectionState == ConnectionState.done) {
            return _listPopularMovies(snapshot.data);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _listPopularMovies(List<PopularDao> movies) {
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) {
        PopularDao popular = movies[index];
        return CardPopular(
          popular: popular,
        );
      },
    );
  }
}
