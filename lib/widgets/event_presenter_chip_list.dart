import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sunapsis_conference18/models/conference_speaker.dart';
import 'package:sunapsis_conference18/pages/speaker_detail.dart';
import 'package:sunapsis_conference18/utils/color_config.dart';
import 'package:sunapsis_conference18/widgets/avatar_fade_image.dart';

class EventPresenterChipList extends StatelessWidget {
  final List<DocumentReference> presenterReference;

  EventPresenterChipList(this.presenterReference);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.0,
      child: Builder(
        builder: (BuildContext context) {
          if (presenterReference.length == 0)
            return Container(
              height: 0.0,
              width: 0.0,
            );
          return Container(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: presenterReference.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildChipList(presenterReference[index], context);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildChipList(DocumentReference reference, BuildContext context) {
    return StreamBuilder(
        stream: reference.snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) return Text("Presenter");
          return _createPresenter(snapshot.data.data, context);
        });
  }

  Widget _createPresenter(
      Map<String, dynamic> presenterData, BuildContext context) {
    ConferenceSpeaker speaker = ConferenceSpeaker.buildFromMap(presenterData);
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Chip(
          backgroundColor: iuGreyDark,
          label: Text(
            "${speaker.name}",
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
          ),
          avatar: Hero(tag: speaker, child: AvatarFadeImage(speaker.picture)),
        ),
      ),
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return SpeakerDetail(
            speaker: speaker,
          );
        }));
      },
    );
  }
}
