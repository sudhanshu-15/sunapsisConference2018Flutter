import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc {
  final FirebaseAuth _firebaseAuth;

  final _isLoggedIn = PublishSubject<bool>();
  final _firebaseUser = BehaviorSubject<FirebaseUser>(seedValue: null);

  Observable<bool> get isLoggedIn => _isLoggedIn.stream;
  Observable<FirebaseUser> get getUser => _firebaseUser.stream;

  LoginBloc({FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance {
    _firebaseAuth.currentUser().then((FirebaseUser user) {
      if (user != null && user.uid.length > 0) {
        _isLoggedIn.sink.add(true);
        _firebaseUser.sink.add(user);
      } else {
        _firebaseAuth.signInAnonymously().then((FirebaseUser user) {
          if (user != null && user.uid.length > 0) {
            _isLoggedIn.sink.add(true);
            _firebaseUser.sink.add(user);
          }
        }).catchError((error) => _isLoggedIn.sink.addError("Failed to login"));
      }
    }).catchError((error) => _isLoggedIn.sink.addError("Failed to login"));
  }

  void dispose() {
    _isLoggedIn.close();
    _firebaseUser.close();
  }
}
