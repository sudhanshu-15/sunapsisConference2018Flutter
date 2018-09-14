import 'package:flutter/material.dart';
import 'package:sunapsis_conference18/blocs/events_bloc_provider.dart';
import 'package:sunapsis_conference18/blocs/login_bloc_provider.dart';
import 'package:sunapsis_conference18/utils/navigation_routes.dart';

class SunapsisConferenceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    NavigationRoutes navigationRoutes = NavigationRoutes();
    return LoginBlocProvider(
      child: EventsBlocProvider(
        child: MaterialApp(
          key: Key('conference_main'),
          onGenerateRoute: navigationRoutes.routes,
          title: "sunapsis Conference 2018",
        ),
      ),
    );
  }
}
