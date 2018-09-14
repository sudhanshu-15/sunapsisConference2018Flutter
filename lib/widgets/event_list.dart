import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sunapsis_conference18/blocs/events_bloc.dart';
import 'package:sunapsis_conference18/blocs/login_bloc.dart';
import 'package:sunapsis_conference18/blocs/login_bloc_provider.dart';
import 'package:sunapsis_conference18/models/conference_event.dart';
import 'package:sunapsis_conference18/utils/color_config.dart';
import 'package:sunapsis_conference18/widgets/event_card.dart';

class EventList extends StatefulWidget {
  final int pageNumber;

  EventList(this.pageNumber, [EventsBloc bloc]);

  @override
  EventListState createState() {
    return new EventListState();
  }
}

class EventListState extends State<EventList> {
  LoginBloc loginBloc;
  EventsBloc eventsBloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    eventsBloc = EventsBloc();
    eventsBloc.setCurrentPage(widget.pageNumber);
    print("Current Page: ${widget.pageNumber}");
    loginBloc = LoginBlocProvider.of(context);
    loginBloc.getUser.listen((FirebaseUser user) {
      print("${user.uid}");
      eventsBloc.setUserId(user.uid);
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _buildList(context, loginBloc),
        Positioned(
            bottom: 30.0,
            right: 30.0,
            child: StreamBuilder(
                stream: eventsBloc.isFavoriteList,
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  if (snapshot.hasData) {
                    return FloatingActionButton(
                        backgroundColor: iuMidnightBlue,
                        child: Icon(
                          snapshot.data ? Icons.star : Icons.star_border,
                          color: iuMint,
                        ),
                        onPressed: () {
                          print("Favorite list triggered: ${snapshot.data}");
                          eventsBloc.setFavoriteList(!snapshot.data);
                        });
                  } else {
                    return Container(
                      height: 0.0,
                      width: 0.0,
                    );
                  }
                })),
      ],
    );
  }

  Widget _buildList(BuildContext context, LoginBloc loginBloc) {
    return StreamBuilder(
      stream: loginBloc.getUser,
      builder:
          (BuildContext context, AsyncSnapshot<FirebaseUser> userSnapshot) {
        if (userSnapshot.hasData) {
          return StreamBuilder(
            stream: eventsBloc.getEventsList,
            builder: (BuildContext context,
                AsyncSnapshot<List<ConferenceEvent>> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return EventCard(snapshot.data[index],
                          userSnapshot.data.uid, eventsBloc);
                    });
              } else {
                return Card(
                  child: ListTile(
                    title: Text("No data"),
                  ),
                );
              }
            },
          );
        } else {
          return Container(
            height: 0.0,
            width: 0.0,
          );
        }
      },
    );
  }

  @override
  void dispose() {
    eventsBloc.dispose();
    super.dispose();
  }
}
