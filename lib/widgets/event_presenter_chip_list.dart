import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sunapsis_conference18/models/conference_speaker.dart';
import 'package:sunapsis_conference18/utils/color_config.dart';

class EventPresenterChipList extends StatelessWidget {
  final List<DocumentReference> presenterReference;

  EventPresenterChipList(this.presenterReference);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.0,
      child: Container(
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: presenterReference.length,
          itemBuilder: (BuildContext context, int index) {
            return _buildChipList(presenterReference[index]);
          },
        ),
      ),
    );
  }

  Widget _buildChipList(DocumentReference reference) {
    return StreamBuilder(
        stream: reference.snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) return Text("Presenter");
          return _createPresenter(snapshot.data.data);
        });
//    List<Widget> chipList = [];
//    for (DocumentReference reference in presenterReference) {
//      Widget chip =
//      chipList.add(chip);
//    }
//    return chipList;
  }

  Widget _createPresenter(Map<String, dynamic> presenterData) {
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
          avatar: CircleAvatar(
            backgroundImage: NetworkImage("${speaker.picture}", scale: 0.5),
          ),
        ),
      ),
      onTap: () {
        print("${speaker.name}");
      },
    );
  }
}
