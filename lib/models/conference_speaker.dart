/// Class that represents a Speaker in the conference
class ConferenceSpeaker {
  String _bio;
  String _name;
  String _organization;
  String _picture;

  String get bio => _bio;
  String get name => _name;
  String get organization => _organization;
  String get picture => _picture;

  /// Creates a [ConferenceSpeaker] object with a [Map]
  ConferenceSpeaker.buildFromMap(Map<String, dynamic> data) {
    _bio = data['bio'];
    _name = data['name'];
    _organization = data['organization'];
    _picture = data['picture'];
  }
}
