import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mockito/mockito.dart';
import 'package:sunapsis_conference18/blocs/events_bloc.dart';
import 'package:sunapsis_conference18/models/conference_event.dart';
import 'package:sunapsis_conference18/repository/conference_event_repository.dart';
import 'package:test/test.dart';

class MockConferenceEventRepository extends Mock
    implements ConferenceEventRepository {}

class MockDocumentReference extends Mock implements DocumentReference {}

main() {
  group('currentPage stream test', () {
    final ConferenceEventRepository mockRepository =
        MockConferenceEventRepository();
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
    final Map<String, dynamic> _responseMap2 = {
      'eventid': 123,
      'title': 'Test title 2',
      'description': 'test description 2',
      'date': 'Sep 29',
      'starttime': '7:00',
      'endtime': '9:00',
      'audience': 'Everyone',
      'level': 'All levels',
      'resources': ['resource 1', 'resource 2', 'resource 3'],
      'favorite': ['user 2', 'user 3', 'user 4'],
      'presenters': [_mockDocumentRef],
    };
    final ConferenceEvent _event = ConferenceEvent.buildFromMap(_responseMap);
    final ConferenceEvent _event2 = ConferenceEvent.buildFromMap(_responseMap2);

    test('eventsList stream gets correct value', () async {
      Stream answer = Future.value([_event, _event2]).asStream();
      final EventsBloc bloc = EventsBloc(repository: mockRepository);
      when(mockRepository.getEventsByDate("Sep 29")).thenAnswer((_) => answer);
      bloc.setCurrentPage(1);
      await expectLater(bloc.getEventsList, emits([_event, _event2]));
      bloc.dispose();
      await expectLater(
          bloc.getEventsList,
          emitsInOrder([
            [_event, _event2],
            emitsDone
          ]));
      verify(mockRepository.getEventsByDate("Sep 29")).called(1);
    });

    test('getAllEvents is called on 0 page', () async {
      final EventsBloc bloc = EventsBloc(repository: mockRepository);
      Stream answer = Future.value([_event]).asStream();
      when(mockRepository.getAllEvents()).thenAnswer((_) => answer);
      bloc.setCurrentPage(0);
      await expectLater(bloc.getEventsList, emits([_event]));
      verifyNever(mockRepository.getEventsByDate("Sep 29"));
      verify(mockRepository.getAllEvents()).called(1);
    });
  });

  group('eventsList stream test', () {
    final ConferenceEventRepository mockRepository =
        MockConferenceEventRepository();
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
    final Map<String, dynamic> _responseMap2 = {
      'eventid': 123,
      'title': 'Test title 2',
      'description': 'test description 2',
      'date': 'Sep 29',
      'starttime': '7:00',
      'endtime': '9:00',
      'audience': 'Everyone',
      'level': 'All levels',
      'resources': ['resource 1', 'resource 2', 'resource 3'],
      'favorite': ['user 2', 'user 3', 'user 4'],
      'presenters': [_mockDocumentRef],
    };
    final ConferenceEvent _event = ConferenceEvent.buildFromMap(_responseMap);
    final ConferenceEvent _event2 = ConferenceEvent.buildFromMap(_responseMap2);

    test('eventsList stream gets a correct value on repository call', () async {
      final EventsBloc bloc = EventsBloc(repository: mockRepository);
      Stream answer = Future.value([_event, _event2]).asStream();
      when(mockRepository.getEventsByDate("Sep 30")).thenAnswer((_) => answer);
      bloc.setCurrentPage(2);
      bloc.setUserId('user 1');
      await expectLater(bloc.getEventsList, emits([_event, _event2]));
      bloc.getFavoriteEvents();
      await expectLater(bloc.getEventsList, emits([_event]));
    });
  });

  group('updateFavorite() test', () {
    final ConferenceEventRepository mockRepository =
        MockConferenceEventRepository();
    final DocumentReference _mockDocumentRef = MockDocumentReference();
    final Map<String, dynamic> _responseMap2 = {
      'eventid': 123,
      'title': 'Test title 2',
      'description': 'test description 2',
      'date': 'Sep 29',
      'starttime': '7:00',
      'endtime': '9:00',
      'audience': 'Everyone',
      'level': 'All levels',
      'resources': ['resource 1', 'resource 2', 'resource 3'],
      'favorite': ['user 2', 'user 3', 'user 4'],
      'presenters': [_mockDocumentRef],
    };
    final ConferenceEvent _event = ConferenceEvent.buildFromMap(_responseMap2);
    test('toggleFavorie is called on repository', () {
      final EventsBloc bloc = EventsBloc(repository: mockRepository);
      when(mockRepository.getAllEvents())
          .thenAnswer((_) => Stream.fromFuture(Future.value([])));
      bloc.setUserId('user 1');
      bloc.updateFavorite(_event);
      verify(mockRepository.toggleFavorite(_event, 'user 1')).called(1);
    });
  });
}
