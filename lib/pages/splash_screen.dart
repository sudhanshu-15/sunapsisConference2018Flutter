import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sunapsis_conference18/blocs/login_bloc.dart';
import 'package:sunapsis_conference18/blocs/login_bloc_provider.dart';
import 'package:sunapsis_conference18/utils/color_config.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  LoginBloc _loginBloc;
  StreamSubscription<bool> _isLoggedInSubscription;
  Timer _timer;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loginBloc = LoginBlocProvider.of(context);
    _isLoggedInSubscription = _loginBloc.isLoggedIn.listen((bool loginState) {
      if (loginState) {
        _timer = Timer(Duration(seconds: 2), () {
          Navigator.of(context).pushReplacementNamed("/events");
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: iuMidnightBlue,
      child: Center(
        child: Stack(
          key: Key("splash_screen"),
          children: <Widget>[
            AspectRatio(
              aspectRatio: 360 / 640,
              child: Image.asset(
                "res/splashscreen.jpg",
                fit: BoxFit.fitWidth,
              ),
            ),
            Positioned(
              child: CircularProgressIndicator(),
              top: MediaQuery.of(context).size.height / 1.5,
              left: MediaQuery.of(context).size.width / 2.5,
            )
          ],
        ),
      ),
    ));
  }

  @override
  void dispose() {
    _isLoggedInSubscription.cancel();
    _timer.cancel();
    super.dispose();
  }
}
