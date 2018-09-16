import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sunapsis_conference18/models/conference_event.dart';
import 'package:sunapsis_conference18/models/conference_speaker.dart';
import 'package:sunapsis_conference18/utils/color_config.dart';
import 'package:sunapsis_conference18/widgets/avatar_fade_image.dart';
import 'package:url_launcher/url_launcher.dart';

class EventsDetail extends StatelessWidget {
  final ConferenceEvent _event;

  EventsDetail(this._event);

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
          Center(
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Text(
                _event.title,
                style: Theme.of(context).textTheme.headline,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 16.0, right: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Icon(Icons.calendar_today),
                Container(
                  width: 15.0,
                ),
                Text(
                  _event.date,
                  style: Theme.of(context).textTheme.subhead,
                ),
                Container(
                  width: 25.0,
                ),
                Icon(Icons.access_time),
                Container(
                  width: 15.0,
                ),
                Text(
                  "${_event.startTime} - ${_event.endTime}",
                  style: Theme.of(context).textTheme.subhead,
                ),
              ],
            ),
          ),
          Divider(),
          _loactionDetails(
              "39.767140",
              "-86.163655",
              "The Westin, 241 W Washington St, Indianapolis, IN 46204",
              context),
          Divider(),
          _audienceUnderstanding(_event.audience, _event.level, context),
          Divider(),
          _createPresenterList(_event.presenters),
          _createDetails(_event.description),
          _buildResourcesTile(_event.resources),
        ],
      ),
    );
  }

  Widget _audienceUnderstanding(
      String audience, String level, BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 16.0, right: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Wrap(
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 16.0,
              children: <Widget>[
                Icon(Icons.people),
                Text(
                  'Audience: ',
                  style: Theme.of(context)
                      .textTheme
                      .subhead
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  '$audience',
                  style: Theme.of(context).textTheme.subhead,
                ),
              ],
            ),
            Container(height: 10.0),
            Wrap(
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 16.0,
              children: <Widget>[
                Icon(
                  Icons.whatshot,
                ),
                Text(
                  'Level of understanding:',
                  style: Theme.of(context)
                      .textTheme
                      .subhead
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  '$level',
                  style: Theme.of(context).textTheme.subhead,
                )
              ],
            )
          ],
        ));
  }

  Widget _loactionDetails(
      String lat, String lon, String label, BuildContext context) {
    final androidUrl = 'geo:0:0?q=$lat,$lon($label)';
    final iosUrl = 'http:maps.apple.com/?q=$label&ll=$lat,$lon';
    bool isAndroid = Theme.of(context).platform == TargetPlatform.android;
    return Container(
      padding: EdgeInsets.only(right: 8.0),
      child: ListTile(
        leading: Icon(
          Icons.location_on,
          color: Colors.black,
        ),
        title: Text(
          label,
          style: Theme.of(context).textTheme.subhead,
        ),
        trailing: Icon(
          Icons.directions,
          color: iuMidnightBlue,
          size: 24.0,
        ),
        onTap: () async {
          String url = isAndroid ? androidUrl : iosUrl;
          if (await canLaunch(url)) {
            await launch(url);
          }
        },
      ),
    );
  }

  Widget _createPresenterList(List<DocumentReference> presenterReference) {
    if (presenterReference.length == 0) {
      return Container(
        height: 0.0,
        width: 0.0,
      );
    }
    return Container(
      padding: EdgeInsets.only(left: 16.0, right: 16.0),
      child: Builder(builder: (BuildContext context) {
        List<Widget> list = [
          Text("By:",
              style: Theme.of(context)
                  .textTheme
                  .subhead
                  .copyWith(fontWeight: FontWeight.bold))
        ];
        for (DocumentReference ref in presenterReference) {
          Widget widget = _buildChipList(ref);
          list.add(widget);
        }
        return Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: list,
          spacing: 4.0,
        );
      }),
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
          avatar: AvatarFadeImage(speaker.picture, 1.0),
        ),
      ),
      onTap: () {
        print("${speaker.name}");
      },
    );
  }

  Widget _createDetails(String details) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Text(
        details,
        style: TextStyle(fontSize: 20.0),
      ),
    );
  }

  Widget _buildResourcesTile(List<String> resources) {
    if (resources.length == 0)
      return Container(
        width: 0.0,
        height: 0.0,
      );
    return ExpansionTile(
      leading: Icon(Icons.insert_link),
      title: Text("Resources:"),
      children:
          resources.map((String resource) => _buildResource(resource)).toList(),
    );
  }

  Widget _buildResource(String resource) {
    return ListTile(
      title: Text(resource),
      trailing: Icon(
        Icons.launch,
        color: iuMidnightBlue,
      ),
      onTap: () async {
        if (await canLaunch(resource)) {
          await launch(resource);
        }
      },
    );
  }
}
