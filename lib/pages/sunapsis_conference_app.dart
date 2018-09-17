import 'package:flutter/material.dart';
import 'package:sunapsis_conference18/blocs/login_bloc_provider.dart';
import 'package:sunapsis_conference18/blocs/speakers_bloc_provider.dart';
import 'package:sunapsis_conference18/utils/color_config.dart';
import 'package:sunapsis_conference18/utils/navigation_routes.dart';

class SunapsisConferenceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    NavigationRoutes navigationRoutes = NavigationRoutes();
    return LoginBlocProvider(
      child: SpeakersBlocProvider(
        child: MaterialApp(
          key: Key('conference_main'),
          onGenerateRoute: navigationRoutes.routes,
          title: "sunapsis Conference 2018",
          theme: iuTheme,
        ),
      ),
    );
  }
}
