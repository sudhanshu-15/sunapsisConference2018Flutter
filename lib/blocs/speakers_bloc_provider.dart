import 'package:flutter/material.dart';
import 'package:sunapsis_conference18/blocs/speakers_bloc.dart';

class SpeakersBlocProvider extends InheritedWidget {
  final SpeakersBloc bloc;

  SpeakersBlocProvider({Key key, Widget child, SpeakersBloc bloc})
      : bloc = bloc ?? SpeakersBloc(),
        super(key: key, child: child);

  static SpeakersBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(SpeakersBlocProvider)
              as SpeakersBlocProvider)
          .bloc;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}
