import 'package:flutter/material.dart';
import 'package:sunapsis_conference18/models/conference_speaker.dart';
import 'package:sunapsis_conference18/utils/color_config.dart';
import 'package:sunapsis_conference18/widgets/avatar_fade_image.dart';

class SpeakerCard extends StatelessWidget {
  final ConferenceSpeaker conferenceSpeaker;

  SpeakerCard({Key key, this.conferenceSpeaker}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: iuGreyLight,
      child: Container(
        child: GridTile(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              GridTileBar(
                  title: Text(
                conferenceSpeaker.name,
                style: Theme.of(context).textTheme.title,
              )),
              OrientationBuilder(
                  builder: (BuildContext context, Orientation orientation) {
                return SizedBox(
                  width: orientation == Orientation.portrait ? 100.0 : 150.0,
                  height: orientation == Orientation.portrait ? 100.0 : 150.0,
                  child: AvatarFadeImage(conferenceSpeaker.picture),
                );
              }),
              GridTileBar(
                title: Chip(
                    backgroundColor: iuGreyDark,
                    label: Text(conferenceSpeaker.organization)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
