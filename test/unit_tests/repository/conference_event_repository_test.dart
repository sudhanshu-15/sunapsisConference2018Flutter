@Skip("Not sure how to test with cloud firestore")
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mockito/mockito.dart';
import 'package:sunapsis_conference18/models/conference_event.dart';
import 'package:sunapsis_conference18/repository/conference_event_repository.dart';
import 'package:test/test.dart';

class MockDocumentReference extends Mock implements DocumentReference {}

class MockFirestore extends Mock implements Firestore {}

class MockCollectionReference extends Mock implements CollectionReference {}

class MockQuerySnapshot extends Mock implements QuerySnapshot {}

class MockDocumentSnapshot extends Mock implements DocumentSnapshot {
  final Map<String, dynamic> data;
  MockDocumentSnapshot([this.data]);

  dynamic operator [](String key) => data[key];
}

class MockQuery extends Mock implements Query {}

main() {
  group('getAllEvents() tests', () {
    final Firestore mockFirestore = MockFirestore();
    final CollectionReference mockCollectionReference =
        MockCollectionReference();
    final QuerySnapshot mockQuerySnapshot = MockQuerySnapshot();
    final ConferenceEventRepository repository =
        ConferenceEventRepository(mockFirestore);
    final DocumentReference _mockDocumentRef = MockDocumentReference();
    final Map<String, dynamic> _responseMap = {
      'eventid': 123,
      'title': 'Test title',
      'description': 'test description',
      'date': 'Sep 29',
      'starttime': '7:00',
      'endtime': '9:00',
      'audience': 'Everyone',
      'level': 'All levels',
      'resources': ['resource 1', 'resource 2', 'resource 3'],
      'favorite': ['user 1', 'user 2', 'user 3', 'user 4'],
      'presenters': [_mockDocumentRef],
    };
    final DocumentSnapshot mockDocumentSnapshot =
        MockDocumentSnapshot(_responseMap);
    final ConferenceEvent _event = ConferenceEvent.buildFromMap(_responseMap);

    test('returns correct stream of list of ConferenceEvent', () async {
      when(mockFirestore.collection('events'))
          .thenReturn(mockCollectionReference);
      when(mockCollectionReference.snapshots())
          .thenAnswer((_) => Stream.fromIterable([mockQuerySnapshot]));

      when(mockQuerySnapshot.documents).thenReturn([mockDocumentSnapshot]);
//      when(mockDocumentSnapshot.data).thenReturn(_responseMap);
      var _stream =
          Stream.fromIterable([mockQuerySnapshot]).map((_) => [_event]);
      await expectLater(
          repository.getAllEvents(),
          emitsAnyOf([
            [_event]
          ]));
    });
  });
}
