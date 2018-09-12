import 'package:cloud_firestore/cloud_firestore.dart';

/// ConferenceEvent data object that represents a conference event.
/// Has a named constructor which accepts a Map<String, dynamic> and created a ConferenceEvent object
class ConferenceEvent {
  /// Unique event id, identifier of Document on CloudFirestore on Firebase
  int _eventId;
  String _title;
  String _description;
  String _date;
  String _startTime;
  String _endTime;
  String _audience;
  String _level;

  /// List all possible resources, documents for a talk, ppt links etc
  List<String> _resources;

  /// List of all the users who have marked this event as favorite
  /// Is used to filter favorite events
  List<String> _favorite;

  /// A reference to the presenter for a event.
  /// Data is stored in the presenter document and is fetched later while creating the UI
  List<DocumentReference> _presenters;

  //TODO: Add resource for location

  int get eventId => _eventId;
  String get title => _title;
  String get description => _description;
  String get date => _date;
  String get startTime => _startTime;
  String get endTime => _endTime;
  String get audience => _audience;
  String get level => _level;
  List<String> get resources => _resources;
  List<String> get favorite => _favorite;
  List<DocumentReference> get presenters => _presenters;

  ConferenceEvent.buildFromMap(Map<String, dynamic> data) {
    _eventId = data['eventid'];
    _title = data['title'];
    _description = data['description'];
    _date = data['date'];
    _startTime = data['starttime'];
    _endTime = data['endtime'];
    _audience = data['audience'];
    _level = data['level'];
    _resources = List();
    for (String resource in data['resources']) {
      _resources.add(resource);
    }
    _favorite = List();
    for (String user in data['favorite']) {
      _favorite.add(user);
    }
    _presenters = List();
    for (DocumentReference presenter in data['presenters']) {
      _presenters.add(presenter);
    }
  }
}
