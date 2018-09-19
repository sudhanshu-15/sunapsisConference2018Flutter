import 'package:flutter/material.dart';
import 'package:sunapsis_conference18/blocs/speakers_bloc.dart';
import 'package:sunapsis_conference18/blocs/speakers_bloc_provider.dart';
import 'package:sunapsis_conference18/models/conference_speaker.dart';
import 'package:sunapsis_conference18/widgets/side_drawer.dart';
import 'package:sunapsis_conference18/widgets/speaker_card.dart';

class Speakers extends StatelessWidget {
  final List<DrawerItem> drawerList = [
    DrawerItem(iconData: Icons.event, label: 'Schedules', callback: () {}),
    DrawerItem(iconData: Icons.mic, label: 'Speakers', callback: () {}),
    DrawerItem(
        iconData: Icons.launch,
        isTwitter: true,
        label: 'Twitter',
        callback: () {},
        isExternal: true),
    DrawerItem(
        iconData: Icons.map,
        label: 'Explore Indy',
        callback: () {},
        isExternal: true)
  ];

  @override
  Widget build(BuildContext context) {
    SpeakersBloc bloc = SpeakersBlocProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "res/sunapsislogo.png",
          fit: BoxFit.cover,
        ),
      ),
      body: StreamBuilder(
          stream: bloc.getSpeakerList,
          builder: (BuildContext context,
              AsyncSnapshot<List<ConferenceSpeaker>> snapshot) {
            if (snapshot.hasData) {
              return OrientationBuilder(
                builder: (BuildContext context, Orientation orientation) {
                  return CustomScrollView(
                    primary: false,
                    slivers: <Widget>[
                      SliverPadding(
                        padding: EdgeInsets.all(4.0),
                        sliver: SliverGrid.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: 4.0,
                          mainAxisSpacing: 4.0,
                          childAspectRatio:
                              orientation == Orientation.portrait ? 3 / 4 : 1.0,
                          children: _createSpeakerCard(snapshot.data, context),
                        ),
                      )
                    ],
                  );
                },
              );
            } else {
              return Text('No data');
            }
          }),
      drawer: SideDrawer(1, drawerList),
    );
  }

  List<Widget> _createSpeakerCard(
      List<ConferenceSpeaker> speakers, BuildContext context) {
    List<Widget> widgets = [];
    for (ConferenceSpeaker speaker in speakers) {
      Widget speakerCard = SpeakerCard(
        conferenceSpeaker: speaker,
      );
      widgets.add(speakerCard);
    }
    return widgets;
  }
}
