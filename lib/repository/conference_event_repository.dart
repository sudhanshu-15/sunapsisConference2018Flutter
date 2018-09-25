import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sunapsis_conference18/models/conference_event.dart';

class ConferenceEventRepository {
  final String _collectionName;
  final Firestore _firestore;

  ConferenceEventRepository([Firestore fireStore])
      : _collectionName = 'events',
        _firestore = fireStore ?? Firestore.instance;

  Stream<List<ConferenceEvent>> getAllEvents() {
    return _firestore
        .collection(_collectionName)
        .orderBy('eventid')
        .snapshots()
        .map((QuerySnapshot snapshot) => _eventMapper(snapshot));
  }

  Stream<List<ConferenceEvent>> getEventsByDate(String date) {
    return _firestore
        .collection(_collectionName)
        .where('date', isEqualTo: date)
        .orderBy('eventid')
        .snapshots()
        .map((QuerySnapshot snapshot) => _eventMapper(snapshot));
  }

  //TODO: Refine logic, don't make another server call
  Stream<List<ConferenceEvent>> getFavoriteEvents(String userId) {
    return _firestore.collection(_collectionName).snapshots().map(
        (QuerySnapshot snapshot) => _favoriteEventMapper(snapshot, userId));
  }

  void toggleFavorite(ConferenceEvent event, String userId) async {
    final DocumentReference eventReference =
        _firestore.document('$_collectionName/event${event.eventId}');
    _firestore.runTransaction((Transaction transaction) async {
      DocumentSnapshot eventSnapshot = await transaction.get(eventReference);
      if (eventSnapshot.exists) {
        List<String> favorite = event.favorite;
        if (favorite.contains(userId)) {
          favorite.remove(userId);
          await transaction
              .update(eventReference, <String, dynamic>{'favorite': favorite});
        } else {
          favorite.add(userId);
          await transaction
              .update(eventReference, <String, dynamic>{'favorite': favorite});
        }
      }
    });
  }

  List<ConferenceEvent> _eventMapper(QuerySnapshot snapshot) {
    List<ConferenceEvent> events = [];
    for (int i = 0; i < snapshot.documents.length; i++) {
      DocumentSnapshot documentSnapshot = snapshot.documents[i];
      ConferenceEvent event =
          ConferenceEvent.buildFromMap(documentSnapshot.data);
      events.add(event);
    }
    return events;
  }

  //TODO: Refine logic
  List<ConferenceEvent> _favoriteEventMapper(
      QuerySnapshot snapshot, String userId) {
    List<ConferenceEvent> events = _eventMapper(snapshot);
    List<ConferenceEvent> favoriteEvents = [];
    for (ConferenceEvent event in events) {
      if (event.favorite.contains(userId)) {
        favoriteEvents.add(event);
      }
    }
    return favoriteEvents;
  }
}
