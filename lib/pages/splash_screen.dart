import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.teal[300],
      child: Center(
        child: Stack(
          key: Key("splash_screen"),
          children: <Widget>[
            AspectRatio(
              aspectRatio: 360 / 640,
              child: Image.asset(
                "res/splash.png",
                fit: BoxFit.fill,
              ),
            ),
            Positioned(
              child: _showProgress(context),
              top: MediaQuery.of(context).size.height / 1.5,
              left: MediaQuery.of(context).size.width / 2.5,
            )
          ],
        ),
      ),
    ));
  }

  Widget _showProgress(BuildContext context) {
    return FutureBuilder(
      future: _createUser(),
      builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
        if (snapshot.hasData) {
          return RaisedButton.icon(
              onPressed: () => _navigate(context),
              icon: Icon(Icons.group),
              label: Text("Login"));
        }
        return CircularProgressIndicator();
      },
    );
  }

  Future<FirebaseUser> _createUser() async {
    FirebaseUser user = await _auth.currentUser();
    if (user != null && user.uid.length != 0) {
      print("user found ${user.uid}");
      return user;
    } else {
      user = await _auth.signInAnonymously();
      print("user created: ${user.uid}");
    }
    return user;
  }

  void _navigate(BuildContext context) {
    Navigator.of(context).pushNamed("/events");
  }
}
