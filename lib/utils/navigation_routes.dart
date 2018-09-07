import 'package:flutter/material.dart';

class NavigationRoutes {
  Route routes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (BuildContext context) {
            return Scaffold(
              body: Center(
                child: Text("hello conference"),
              ),
            );
          },
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
