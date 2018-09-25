import 'package:flutter/material.dart';
import 'package:sunapsis_conference18/pages/events.dart';
import 'package:sunapsis_conference18/pages/speakers.dart';
import 'package:sunapsis_conference18/pages/splash_screen.dart';

class NavigationRoutes {
  Route routes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (BuildContext context) => SplashScreen(),
        );
        break;
      case '/speakers':
        return MaterialPageRoute(builder: (BuildContext context) => Speakers());
        break;
      case '/events':
        return MaterialPageRoute(
          builder: (BuildContext context) => Events(),
        );
        break;
      default:
        return MaterialPageRoute(
          builder: (BuildContext context) => Events(),
        );
    }
  }
}
