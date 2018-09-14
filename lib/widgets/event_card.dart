import 'package:flutter/material.dart';
import 'package:sunapsis_conference18/blocs/events_bloc.dart';
import 'package:sunapsis_conference18/models/conference_event.dart';
import 'package:sunapsis_conference18/utils/color_config.dart';
import 'package:sunapsis_conference18/widgets/event_presenter_chip_list.dart';

class EventCard extends StatelessWidget {
  final ConferenceEvent _event;
  final String userId;
  final EventsBloc eventsBloc;

  EventCard(this._event, this.userId, this.eventsBloc);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: iuGreyLight,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            _buildDateTimeColumn(),
            _buildEventTile(eventsBloc)
          ],
        ),
      ),
    );
  }

  Widget _buildDateTimeColumn() {
    return Container(
      key: ObjectKey(_event.eventId),
      child: Column(
        children: <Widget>[
          Text(
            "${_event.startTime}",
            style: TextStyle(color: Colors.black54, fontSize: 24.0),
            key: Key("startTime${_event.eventId}"),
          ),
          Icon(Icons.arrow_drop_down),
          Text(
            "${_event.endTime}",
            style: TextStyle(color: Colors.black54, fontSize: 24.0),
            key: Key("dividerIcon${_event.eventId}"),
          ),
          Text(
            "${_event.date}",
            style: TextStyle(color: Colors.black),
            key: Key("endTime${_event.eventId}"),
          ),
        ],
      ),
    );
  }

  Widget _buildEventTile(EventsBloc eventsBloc) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ListTile(
            title: Text(
              "${_event.title}",
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
            subtitle: Text("${_event.audience}"),
            trailing: IconButton(
              icon: _isFavorite(_event.favorite),
              onPressed: () {
                eventsBloc.updateFavorite(_event);
              },
            ),
          ),
          EventPresenterChipList(_event.presenters)
        ],
      ),
    );
  }

  Widget _isFavorite(List<String> favoriteUser) {
    if (favoriteUser.contains(userId)) {
      return Icon(
        Icons.star,
        color: iuMint,
        size: 30.0,
      );
    } else {
      return Icon(
        Icons.star_border,
        color: iuMint,
      );
    }
  }
}
