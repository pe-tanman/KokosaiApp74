import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth_repository.dart';


final authControllerProvider = StateNotifierProvider<AuthController, User?>(
      (ref) => AuthController(ref.read),
);

class AuthController extends StateNotifier<User?> {
  final Reader _read;

  StreamSubscription<User?>? _authStateChangesSubscription;

  AuthController(this._read) : super(null) {
    _authStateChangesSubscription?.cancel();
    _authStateChangesSubscription = _read(authRepositoryProvider)
        .authStateChanges
        .listen((user) => state = user);
  }

  @override
  void dispose() {
    _authStateChangesSubscription?.cancel();
    super.dispose();
  }
  //
  // void appStarted() async {
  //   final user = _read(authRepositoryProvider).getCurrentUser();
  //   if (user == null) {
  //     await _read(authRepositoryProvider).signInAnonymously();
  //   }
  // }

  Future<void> signIn() async {
    await _read(authRepositoryProvider).signInAnonymously();
  }

  Future<void> signOut() async {
    await _read(authRepositoryProvider).signOut();
  }

}