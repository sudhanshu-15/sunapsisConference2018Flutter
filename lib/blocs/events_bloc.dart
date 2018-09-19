import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:sunapsis_conference18/models/conference_event.dart';
import 'package:sunapsis_conference18/repository/conference_event_repository.dart';

class EventsBloc {
  final ConferenceEventRepository _repository;
  final _currentPage = BehaviorSubject<int>();
  final _eventsList = BehaviorSubject<List<ConferenceEvent>>();
  final _userId = BehaviorSubject<String>();
  final _favoriteList = BehaviorSubject<bool>(seedValue: false);
  StreamSubscription<int> _pageSubscription;
  StreamSubscription<List<ConferenceEvent>> _eventsSubscription;
  Function(int) get setCurrentPage => _currentPage.sink.add;
  Function(String) get setUserId => _userId.sink.add;
  Function(bool) get setFavoriteList => _favoriteList.sink.add;

  Observable<List<ConferenceEvent>> get getEventsList => _eventsList.stream;
  Observable<bool> get isFavoriteList => _favoriteList.stream;

  EventsBloc({ConferenceEventRepository repository})
      : _repository = repository ?? ConferenceEventRepository() {
//    _pageSubscription =
//        _currentPage.stream.listen((int page) => _setCurrentList(page));
    _favoriteList.stream.listen((bool value) {
      if (value) {
        getFavoriteEvents();
      } else {
        _setCurrentList(_currentPage.value);
      }
    });
  }

  void getFavoriteEvents() {
    List<ConferenceEvent> favoriteEvents = List();
    for (ConferenceEvent event in _eventsList.value) {
      if (event.favorite.contains(_userId.value)) {
        favoriteEvents.add(event);
      }
    }
    _eventsList.sink.add(favoriteEvents);
  }

  void updateFavorite(ConferenceEvent event) {
    _repository.toggleFavorite(event, _userId.value);
  }

  void _getAllEvents() {
    print("get all events called");
    _eventsSubscription?.cancel();
    _eventsSubscription =
        _repository.getAllEvents().listen((List<ConferenceEvent> eventList) {
      _eventsList.sink.add(eventList);
    });
  }

  void _getEventsByDate(String date) {
    print("get events by date called");
    _eventsSubscription?.cancel();
    _eventsSubscription = _repository
        .getEventsByDate(date)
        .listen((List<ConferenceEvent> eventList) {
      _eventsList.sink.add(eventList);
    });
  }

  void dispose() {
    _currentPage.close();
    _eventsList.close();
    _userId.close();
    _pageSubscription?.cancel();
    _eventsSubscription?.cancel();
    _favoriteList.close();
  }

  void _setCurrentList(int page) {
    String date;
    print("Current Page: $page");
    switch (page) {
      case 1:
        date = "Sep 29";
        break;
      case 2:
        date = "Sep 30";
        break;
      case 3:
        date = "Oct 1";
        break;
      case 4:
        date = "Oct 2";
        break;
      case 5:
        date = "Oct 5";
        break;
      default:
        _getAllEvents();
        return;
        break;
    }
    _getEventsByDate(date);
  }
}
