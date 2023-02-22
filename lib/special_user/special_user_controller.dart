import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'special_user_repository.dart';

final specialUserControllerProvider = StateNotifierProvider<SpecialUserController, Map<String, dynamic>?>((ref) {
  print('SpecialUserControllerProvider was launched!');
  return SpecialUserController(ref.read);
});

class SpecialUserController extends StateNotifier<Map<String, dynamic>?> {
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>?>?>? _specialUserStateChangeSubscription;

  SpecialUserController(this._read) : super(null) {
    _specialUserStateChangeSubscription?.cancel();
    _specialUserStateChangeSubscription = _read(specialUserRepositoryProvider).specialUserStateChange().listen((user) {
      state = user?.data();
      print('specialUserController: Special user state changed! ${user?.data()}');
    });
  }

  final Reader _read;
}
