import 'package:flutter/material.dart';
import 'package:sunapsis_conference18/blocs/login_bloc.dart';

class LoginBlocProvider extends InheritedWidget {
  final LoginBloc bloc;

  LoginBlocProvider({Key key, Widget child, LoginBloc bloc})
      : bloc = bloc ?? LoginBloc(),
        super(key: key, child: child);

  static LoginBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(LoginBlocProvider)
              as LoginBlocProvider)
          .bloc;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}
