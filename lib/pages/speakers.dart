import 'package:flutter/material.dart';
import 'package:sunapsis_conference18/blocs/speakers_bloc.dart';
import 'package:sunapsis_conference18/blocs/speakers_bloc_provider.dart';
import 'package:sunapsis_conference18/models/conference_speaker.dart';

class Speakers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SpeakersBloc bloc = SpeakersBlocProvider.of(context);
    Orientation orientation = MediaQuery.of(context).orientation;
    return StreamBuilder(
        stream: bloc.getSpeakerList,
        builder: (BuildContext context,
            AsyncSnapshot<List<ConferenceSpeaker>> snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
                itemCount: snapshot.data.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        (orientation == Orientation.portrait) ? 2 : 1),
                itemBuilder: (BuildContext context, int index) {
                  ConferenceSpeaker speaker = snapshot.data[index];
                  return Card(
                    child: GridTile(
                        header: Image.network(speaker.picture),
                        child: Text(speaker.bio)),
                  );
                });
          } else {
            return Text('No data');
          }
        });
  }
}
