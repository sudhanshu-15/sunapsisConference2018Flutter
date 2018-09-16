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
        'location': {
          'address': 'test address',
          'lat': '39.767140',
          'lon': '-86.163655'
        },
        'endtime': '9:00',
        'audience': 'Everyone',
        'level': 'All levels',
        'resources': [
          {'name': 'test resource 1', 'link': 'test link'},
          {'name': 'test resource 2', 'link': 'test link'},
          {'name': 'test resource 3', 'link': 'test link'}
        ],
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
      expect(conferenceEvent.location.address, 'test address');
      expect(conferenceEvent.resources.length, 3);
      expect(conferenceEvent.resources[0].resourceName, 'test resource 1');
      expect(conferenceEvent.favorite.length, 4);
      expect(conferenceEvent.presenters[0], _mockDocumentRef);
    });
  });
}
