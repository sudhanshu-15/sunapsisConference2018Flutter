import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc {
  final FirebaseAuth _firebaseAuth;

  /// Stream that controls the login state
  /// True if logged in, false otherwise and has error if there was an error
  final _isLoggedIn = PublishSubject<bool>();

//  final _isFavoriteList = BehaviorSubject<bool>(seedValue: false);

  /// Stream that stores the value of a FirebaseUser
  final _firebaseUser = BehaviorSubject<FirebaseUser>(seedValue: null);

//  Function() get setFavoriteList => () {
//        _isFavoriteList.sink.add(!_isFavoriteList.value);
//      };
//
//  Observable<bool> get isFavoriteList => _isFavoriteList.stream;
  Observable<bool> get isLoggedIn => _isLoggedIn.stream;
  Observable<FirebaseUser> get getUser => _firebaseUser.stream;

  /// Check if there is a user available
  /// if not then [signInAnonymously] and get a user
  /// change login state stream and user stream
  /// on error add error to login state stream
  LoginBloc({FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance {
    _firebaseAuth.currentUser().then((FirebaseUser user) {
      if (user != null && user.uid.length > 0) {
        print("User: ${user.uid}");
        _isLoggedIn.sink.add(true);
        _firebaseUser.sink.add(user);
      } else {
        _firebaseAuth.signInAnonymously().then((FirebaseUser user) {
          if (user != null && user.uid.length > 0) {
            print("User: ${user.uid}");
            _isLoggedIn.sink.add(true);
            _firebaseUser.sink.add(user);
          }
        }).catchError((error) => _isLoggedIn.sink.addError("Failed to login"));
      }
    }).catchError((error) => _isLoggedIn.sink.addError("Failed to login"));
  }

  /// Close all the streams
  void dispose() {
    _isLoggedIn.close();
    _firebaseUser.close();
//    _isFavoriteList.close();
  }
}
