import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sunapsis_conference18/models/conference_speaker.dart';

class ConferenceSpeakerRepository {
  final String _collectionName;
  final Firestore _firestore;

  ConferenceSpeakerRepository([Firestore fireStore])
      : _collectionName = 'speakers',
        _firestore = fireStore ?? Firestore.instance;

  Stream<List<ConferenceSpeaker>> getSpeakersList() {
    print('Get all speakers called');
    return _firestore
        .collection(_collectionName)
        .snapshots()
        .map((QuerySnapshot snapshot) => _speakersMapper(snapshot));
  }

  List<ConferenceSpeaker> _speakersMapper(QuerySnapshot snapshot) {
    List<ConferenceSpeaker> speakers = [];
    for (int i = 0; i < snapshot.documents.length; i++) {
      DocumentSnapshot documentSnapshot = snapshot.documents[i];
      ConferenceSpeaker speaker =
          ConferenceSpeaker.buildFromMap(documentSnapshot.data);
      speakers.add(speaker);
    }
    return speakers;
  }
}
