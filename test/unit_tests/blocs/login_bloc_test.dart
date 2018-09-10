import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockito/mockito.dart';
import 'package:sunapsis_conference18/blocs/login_bloc.dart';
import 'package:test/test.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockFirebaseUser extends Mock implements FirebaseUser {}

main() {
  group('isLoggedIn stream tests', () {
    LoginBloc loginBloc;
    FirebaseAuth mockFirebaseAuth;
    FirebaseUser mockFirebaseUser;

    setUp(() {
      mockFirebaseAuth = MockFirebaseAuth();
      mockFirebaseUser = MockFirebaseUser();
    });

    test('Stream gets true value when currentUser() returns a user', () async {
      when(mockFirebaseAuth.currentUser())
          .thenAnswer((_) => Future.value(mockFirebaseUser));
      when(mockFirebaseUser.uid).thenReturn("test uid");
      loginBloc = LoginBloc(firebaseAuth: mockFirebaseAuth);
      await expectLater(loginBloc.isLoggedIn, emits(isTrue));
      verifyNever(mockFirebaseAuth.signInAnonymously());
      verify(mockFirebaseAuth.currentUser()).called(1);
    });

    test(
        'Stream gets true value when currentUser() returns null and signInAnonymously() returns a user',
        () async {
      when(mockFirebaseAuth.currentUser())
          .thenAnswer((_) => Future.value(null));
      when(mockFirebaseUser.uid).thenReturn("test uid");
      when(mockFirebaseAuth.signInAnonymously())
          .thenAnswer((_) => Future.value(mockFirebaseUser));
      loginBloc = LoginBloc(firebaseAuth: mockFirebaseAuth);
      await expectLater(loginBloc.isLoggedIn, emits(isTrue));
      verify(mockFirebaseAuth.signInAnonymously()).called(1);
      verify(mockFirebaseAuth.currentUser()).called(1);
    });

    test('Stream gets error when currentUser() returns an error', () async {
      when(mockFirebaseAuth.currentUser())
          .thenAnswer((_) => Future.error(Exception("Error")));
      loginBloc = LoginBloc(firebaseAuth: mockFirebaseAuth);
      await expectLater(loginBloc.isLoggedIn, emitsError("Failed to login"));
    });

    test(
        'Stream gets error when currentUser() returns null and signInAnonymously() returns error',
        () async {
      when(mockFirebaseAuth.currentUser())
          .thenAnswer((_) => Future.value(null));
      when(mockFirebaseAuth.signInAnonymously())
          .thenAnswer((_) => Future.error(Exception("Error")));
      loginBloc = LoginBloc(firebaseAuth: mockFirebaseAuth);
      await expectLater(loginBloc.isLoggedIn, emitsError("Failed to login"));
    });
  });

  group('getUser stream tests', () {
    LoginBloc loginBloc;
    FirebaseAuth mockFirebaseAuth;
    FirebaseUser mockFirebaseUser;

    setUp(() {
      mockFirebaseAuth = MockFirebaseAuth();
      mockFirebaseUser = MockFirebaseUser();
    });

    test('Stream gets user value when currentUser() returns a user', () async {
      when(mockFirebaseAuth.currentUser())
          .thenAnswer((_) => Future.value(mockFirebaseUser));
      when(mockFirebaseUser.uid).thenReturn("test uid");
      loginBloc = LoginBloc(firebaseAuth: mockFirebaseAuth);
      await expectLater(loginBloc.getUser, emits(mockFirebaseUser));
      verifyNever(mockFirebaseAuth.signInAnonymously());
      verify(mockFirebaseAuth.currentUser()).called(1);
    });

    test(
        'Stream gets user value when currentUser() returns null and signInAnonymously() returns a user',
        () async {
      when(mockFirebaseAuth.currentUser())
          .thenAnswer((_) => Future.value(null));
      when(mockFirebaseUser.uid).thenReturn("test uid");
      when(mockFirebaseAuth.signInAnonymously())
          .thenAnswer((_) => Future.value(mockFirebaseUser));
      loginBloc = LoginBloc(firebaseAuth: mockFirebaseAuth);
      await expectLater(loginBloc.getUser, emits(mockFirebaseUser));
      verify(mockFirebaseAuth.signInAnonymously()).called(1);
      verify(mockFirebaseAuth.currentUser()).called(1);
    });
  });

  group('dispose() tests', () {
    LoginBloc loginBloc;
    FirebaseAuth mockFirebaseAuth;
    FirebaseUser mockFirebaseUser;

    setUp(() {
      mockFirebaseAuth = MockFirebaseAuth();
      mockFirebaseUser = MockFirebaseUser();
    });

    test('getUser stream is closed on dispose()', () async {
      when(mockFirebaseAuth.currentUser())
          .thenAnswer((_) => Future.value(mockFirebaseUser));
      when(mockFirebaseUser.uid).thenReturn("test uid");
      loginBloc = LoginBloc(firebaseAuth: mockFirebaseAuth);
      await expectLater(loginBloc.getUser, emits(mockFirebaseUser));
      verifyNever(mockFirebaseAuth.signInAnonymously());
      verify(mockFirebaseAuth.currentUser()).called(1);
      loginBloc.dispose();
      await expectLater(
          loginBloc.getUser, emitsInOrder([mockFirebaseUser, emitsDone]));
    });

    test('isLoggedIn stream is closed on dispose()', () async {
      when(mockFirebaseAuth.currentUser())
          .thenAnswer((_) => Future.value(mockFirebaseUser));
      when(mockFirebaseUser.uid).thenReturn("test uid");
      loginBloc = LoginBloc(firebaseAuth: mockFirebaseAuth);
      await expectLater(loginBloc.isLoggedIn, emits(isTrue));
      verifyNever(mockFirebaseAuth.signInAnonymously());
      verify(mockFirebaseAuth.currentUser()).called(1);
      loginBloc.dispose();
      await expectLater(loginBloc.isLoggedIn, emitsDone);
    });
  });
}
