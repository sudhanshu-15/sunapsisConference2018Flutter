import 'package:flutter/material.dart';
import 'package:sunapsis_conference18/blocs/events_bloc.dart';

class EventsBlocProvider extends InheritedWidget {
  final EventsBloc bloc;

  EventsBlocProvider({Key key, Widget child, EventsBloc bloc})
      : bloc = bloc ?? EventsBloc(),
        super(key: key, child: child);

  static EventsBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(EventsBlocProvider)
              as EventsBlocProvider)
          .bloc;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}
