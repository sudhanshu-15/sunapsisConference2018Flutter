import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _createUser(),
        builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: Container(
                child: Text("User: ${snapshot.data.uid}"),
              ),
            );
          }
          return Center(
            child: Container(
              child: Text("User: loading"),
            ),
          );
        },
      ),
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
}
