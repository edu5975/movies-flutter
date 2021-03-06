import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practica2/src/database/databaseHelper.dart';
import 'package:practica2/src/models/userDao.dart';
import 'package:practica2/src/screens/dashboard.dart';
import 'package:practica2/src/utils/configuration.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController txtNombre = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPhone = TextEditingController();

  final picker = ImagePicker();
  String imagePath = "";

  DatabaseHelper _database;

  @override
  void initState() {
    super.initState();
    _database = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My profile"),
        backgroundColor: Configuration.colorHeader,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Configuration.colorIcons,
        onPressed: () {
          UserDao user = UserDao(
            user: txtNombre.text,
            email: txtEmail.text,
            phone: txtPhone.text,
            picture: imagePath,
          );
          _database.insert("tbl_user", user.toJson());
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => Dashboard(),
            ),
            ModalRoute.withName('/dashboard'),
          );
        },
        child: Icon(Icons.save),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Configuration.colorIcons,
        shape: CircularNotchedRectangle(),
        notchMargin: 12,
        child: Container(
          height: 60,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.cancel_sharp),
                  onPressed: () {},
                  iconSize: 35,
                  color: Colors.white,
                ),
                IconButton(
                  icon: Icon(Icons.camera_alt),
                  onPressed: () async {
                    final file = await picker.getImage(
                      source: ImageSource.camera,
                    );
                    imagePath = file.path;
                    setState(() {});
                  },
                  iconSize: 35,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ListView(
          children: [
            avatar(),
            SizedBox(height: 20),
            name(),
            SizedBox(height: 20),
            phone(),
            SizedBox(height: 20),
            email(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget avatar() {
    if (imagePath == "") {
      return CircleAvatar(
        radius: 110,
        backgroundImage: AssetImage("assets/profileDefault.jpg"),
      );
    } else {
      return ClipOval(
        child: Image.file(
          File(imagePath),
          fit: BoxFit.cover,
        ),
      );
    }
  }

  Widget name() {
    return TextFormField(
      controller: txtNombre,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Configuration.colorBorders),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Configuration.colorFocusedBorder,
            width: 2,
          ),
        ),
        prefixIcon: Icon(
          Icons.person,
          color: Configuration.colorIcons,
        ),
        labelText: "Nombre",
        helperText: "Introduce tu nombre",
      ),
    );
  }

  Widget phone() {
    return TextFormField(
      controller: txtPhone,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Configuration.colorBorders),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Configuration.colorFocusedBorder,
            width: 2,
          ),
        ),
        prefixIcon: Icon(
          Icons.phone,
          color: Configuration.colorIcons,
        ),
        labelText: "Telefono",
        helperText: "Introduce tu n??mero de telefono",
      ),
    );
  }

  Widget email() {
    return TextFormField(
      controller: txtEmail,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Configuration.colorBorders),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Configuration.colorFocusedBorder,
            width: 2,
          ),
        ),
        prefixIcon: Icon(
          Icons.email,
          color: Configuration.colorIcons,
        ),
        labelText: "Email",
        helperText: "Introduce tu correo electronico",
      ),
    );
  }
}
