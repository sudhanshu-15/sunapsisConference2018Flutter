import 'package:sunapsis_conference18/models/conference_speaker.dart';
import 'package:test/test.dart';

main() {
  group('ConferenceSpeaker tests', () {
    Map<String, dynamic> _responseMap;

    setUp(() {
      _responseMap = {
        'bio': 'Test bio',
        'name': 'Test Name',
        'organization': 'test organization',
        'picture': 'test picture link',
      };
    });

    test('Creates correct ConferenceSpeaker with map', () {
      ConferenceSpeaker conferenceSpeaker =
          ConferenceSpeaker.buildFromMap(_responseMap);
      expect(conferenceSpeaker.bio, _responseMap['bio']);
      expect(conferenceSpeaker.name, _responseMap['name']);
      expect(conferenceSpeaker.organization, _responseMap['organization']);
      expect(conferenceSpeaker.picture, _responseMap['picture']);
    });
  });
}
