import 'package:flutter/material.dart';
import 'package:sunapsis_conference18/pages/splash_screen.dart';

class NavigationRoutes {
  Route routes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (BuildContext context) => SplashScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (BuildContext context) {
            return Scaffold(
              body: Center(
                child: Text("hello unknown"),
              ),
            );
          },
        );
    }
  }
}
