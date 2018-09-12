import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mockito/mockito.dart';
import 'package:sunapsis_conference18/models/conference_event.dart';
import 'package:test/test.dart';

class MockDocumentReference extends Mock implements DocumentReference {}

main() {
  group('ConferenceEvent tests', () {
    DocumentReference _mockDocumentRef;
    Map<String, dynamic> _responseMap;

    setUp(() {
      _mockDocumentRef = MockDocumentReference();
      _responseMap = {
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
    });

    test('Creates correct ConferenceEvent with map', () {
      ConferenceEvent conferenceEvent =
          ConferenceEvent.buildFromMap(_responseMap);
      expect(conferenceEvent.eventId, _responseMap['eventid']);
      expect(conferenceEvent.title, _responseMap['title']);
      expect(conferenceEvent.description, _responseMap['description']);
      expect(conferenceEvent.date, _responseMap['date']);
      expect(conferenceEvent.startTime, _responseMap['starttime']);
      expect(conferenceEvent.endTime, _responseMap['endtime']);
      expect(conferenceEvent.audience, _responseMap['audience']);
      expect(conferenceEvent.level, _responseMap['level']);
      expect(conferenceEvent.resources.length, 3);
      expect(conferenceEvent.resources[0], 'resource 1');
      expect(conferenceEvent.favorite.length, 4);
      expect(conferenceEvent.presenters[0], _mockDocumentRef);
    });
  });
}
