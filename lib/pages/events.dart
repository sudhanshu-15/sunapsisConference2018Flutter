import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sunapsis_conference18/blocs/login_bloc.dart';
import 'package:sunapsis_conference18/blocs/login_bloc_provider.dart';

class Events extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => EventsState();
}

class EventsState extends State<Events> {
  LoginBloc _loginBloc;

  @override
  Widget build(BuildContext context) {
    _loginBloc = LoginBlocProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Events"),
      ),
      body: Center(
        child: Container(
          child: StreamBuilder(
            stream: _loginBloc.getUser,
            builder:
                (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
              if (snapshot.hasData) {
                return Text("User: ${snapshot.data.uid}");
              } else {
                return Text("User: Loading..");
              }
            },
          ),
        ),
      ),
    );
  }
}
