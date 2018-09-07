import 'package:flutter/material.dart';
import 'package:sunapsis_conference18/utils/navigation_routes.dart';

class SunapsisConferenceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    NavigationRoutes navigationRoutes = NavigationRoutes();
    return MaterialApp(
      key: Key('conference_main'),
      onGenerateRoute: navigationRoutes.routes,
      title: "sunapsis Conference 2018",
    );
  }
}
