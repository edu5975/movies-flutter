import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var pwdController = TextEditingController();

    final popcorn = Image.asset(
      'assets/popcorn.png',
      width: 500,
      height: 500,
    );

    final txtEmail = TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          hintText: 'Introduce el email',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 5,
          )),
    );

    final txtPwd = TextFormField(
      controller: pwdController,
      keyboardType: TextInputType.text,
      obscureText: true,
      decoration: InputDecoration(
          hintText: 'Introduce el password',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 5,
          )),
    );

    final loginButton = MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          'Validar Usuario',
          style: TextStyle(color: Colors.white),
        ),
        color: Colors.blue[300],
        onPressed: () {
          //VALIDAR MEDIANTE API
          Navigator.pushNamed(context, '/dashboard');
        });

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: ExactAssetImage('assets/wallpaper.jpg'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Card(
          color: Colors.white,
          elevation: 10.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              shrinkWrap: true,
              children: [
                txtEmail,
                SizedBox(
                  height: 10,
                ),
                txtPwd,
                SizedBox(
                  height: 10,
                ),
                loginButton
              ],
            ),
          ),
        ),
        Positioned(
          child: popcorn,
          bottom: 200,
        )
      ],
    );
  }
}
