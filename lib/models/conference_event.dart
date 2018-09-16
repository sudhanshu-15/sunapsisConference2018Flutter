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
  List<EventResource> _resources;

  /// List of all the users who have marked this event as favorite
  /// Is used to filter favorite events
  List<String> _favorite;

  /// A reference to the presenter for a event.
  /// Data is stored in the presenter document and is fetched later while creating the UI
  List<DocumentReference> _presenters;

  //TODO: Add resource for location
  EventLocation _location;

  int get eventId => _eventId;
  String get title => _title;
  String get description => _description;
  String get date => _date;
  String get startTime => _startTime;
  String get endTime => _endTime;
  String get audience => _audience;
  String get level => _level;
  List<EventResource> get resources => _resources;
  List<String> get favorite => _favorite;
  List<DocumentReference> get presenters => _presenters;
  EventLocation get location => _location;

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
    for (var resourceMap in data['resources']) {
      EventResource resource =
          EventResource(resourceMap['name'], resourceMap['link']);
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
    var locationMap = data['location'];
    _location = EventLocation(
        locationMap['address'], locationMap['lat'], locationMap['lon']);
  }
}

class EventLocation {
  String _address;
  String _lat;
  String _lon;

  String get address => _address;
  String get lat => _lat;
  String get lon => _lon;

  EventLocation(this._address, this._lat, this._lon);
}

class EventResource {
  String _resourceName;
  String _link;

  String get resourceName => _resourceName;
  String get link => _link;

  EventResource(this._resourceName, this._link);
}
