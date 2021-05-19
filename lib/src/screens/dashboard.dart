import 'dart:io';

import 'package:flutter/material.dart';
import 'package:practica2/src/database/databaseHelper.dart';
import 'package:practica2/src/models/userDao.dart';
import 'package:practica2/src/utils/configuration.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DatabaseHelper _database = DatabaseHelper();

    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        backgroundColor: Configuration.colorHeader,
      ),
      drawer: FutureBuilder(
        future: _database.getUser("edu123@edu.com"),
        builder: (BuildContext context, AsyncSnapshot<UserDao> user) {
          return Drawer(
            child: ListView(
              children: [
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    color: Configuration.colorHeader,
                  ),
                  accountName:
                      Text(user.data == null ? "PRUEBA" : user.data.user),
                  accountEmail:
                      Text(user.data == null ? "PRUEBA" : user.data.email),
                  currentAccountPicture: user.data == null
                      ? CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://assets.turbologo.com/blog/fr/2019/10/19134208/spiderman-logo-illustration-958x575.jpg'),
                        )
                      : ClipOval(child: Image.file(File(user.data.picture))),
                  onDetailsPressed: () {
                    Navigator.pushNamed(context, '/profile');
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.trending_up,
                    color: Configuration.colorIcons,
                  ),
                  title: Text('Popular'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/popular');
                  },
                  trailing: Icon(
                    Icons.chevron_right,
                    color: Configuration.colorIcons,
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.search,
                    color: Configuration.colorIcons,
                  ),
                  title: Text('Search'),
                  onTap: () {
                    Navigator.pop(context);
                    //Navigator.pushNamed(context, '/search');
                  },
                  trailing: Icon(
                    Icons.chevron_right,
                    color: Configuration.colorIcons,
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.favorite,
                    color: Configuration.colorIcons,
                  ),
                  title: Text('Favorite'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/favorite');
                  },
                  trailing: Icon(
                    Icons.chevron_right,
                    color: Configuration.colorIcons,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
