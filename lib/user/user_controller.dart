import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kokosai_74_app/auth/auth_controller.dart';
import 'package:kokosai_74_app/user/user_repository.dart';

final userControllerProvider = StateNotifierProvider<UserController, Map<String, dynamic>?>((ref) {
  if (ref.watch(authControllerProvider) != null) {
    print('UserControllerProvider was launched!');
    return UserController(ref.read);
  } else {
    print('UserControllerProvider was launched in notLoggedIn!');
    return UserController.notLoggedIn(ref.read);
  }
});

class UserController extends StateNotifier<Map<String, dynamic>?> {
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>?>?>? _userStateChangeSubscription;

  UserController(this._read) : super({'nyan': 'loggedIn'}) {
    _userStateChangeSubscription?.cancel();
    _userStateChangeSubscription = _read(userRepositoryProvider)
        .userStateChange(_read(authControllerProvider)!.uid)
        .listen((user) {
      state = user?.data();
      print('userController: User state changed! ${user?.data()}');
    });
  }

  UserController.notLoggedIn(this._read) : super({'userId': null});

  final Reader _read;
}
