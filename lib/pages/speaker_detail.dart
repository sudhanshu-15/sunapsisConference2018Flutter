import 'package:flutter/material.dart';
import 'package:sunapsis_conference18/models/conference_speaker.dart';
import 'package:sunapsis_conference18/utils/color_config.dart';
import 'package:sunapsis_conference18/widgets/avatar_fade_image.dart';

class SpeakerDetail extends StatelessWidget {
  final ConferenceSpeaker speaker;

  SpeakerDetail({Key key, @required this.speaker}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "res/sunapsislogo.png",
          fit: BoxFit.cover,
        ),
      ),
      body: ListView(
        children: <Widget>[
          _buildAvatarImage(context),
          _buildTitle(context),
          _buildOrganizationChip(context),
          _buildBio(context)
        ],
      ),
    );
  }

  Widget _buildAvatarImage(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 16.0),
      height: 200.0,
      width: 200.0,
      child: Center(
        child: Hero(tag: speaker, child: AvatarFadeImage(speaker.picture)),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Center(
        child: Text(
          speaker.name,
          style: TextStyle(fontSize: 28.0),
        ),
      ),
    );
  }

  Widget _buildOrganizationChip(BuildContext context) {
    return Center(
      child: Chip(
        label: Text(
          speaker.organization,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
        backgroundColor: iuGreyDark,
      ),
    );
  }

  Widget _buildBio(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Text(
        speaker.bio,
        style: TextStyle(fontSize: 18.0),
      ),
    );
  }
}
