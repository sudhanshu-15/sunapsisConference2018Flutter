import 'package:rxdart/rxdart.dart';
import 'package:sunapsis_conference18/models/conference_speaker.dart';
import 'package:sunapsis_conference18/repository/conference_speaker_repository.dart';

class SpeakersBloc {
  final ConferenceSpeakerRepository _repository;
  final _speakerList = BehaviorSubject<List<ConferenceSpeaker>>();

  Observable<List<ConferenceSpeaker>> get getSpeakerList => _speakerList.stream;

  SpeakersBloc({ConferenceSpeakerRepository repository})
      : _repository = repository ?? ConferenceSpeakerRepository() {
    _repository.getSpeakersList().listen((List<ConferenceSpeaker> list) {
      _speakerList.sink.add(list);
    });
  }

  void dispose() {
    _speakerList.close();
  }
}
