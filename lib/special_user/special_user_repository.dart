import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kokosai_74_app/main.dart';
import 'package:kokosai_74_app/user/user_controller.dart';

final specialUserRepositoryProvider = Provider<SpecialUserRepository>((ref) {
  return SpecialUserRepository(ref.read);
});

class SpecialUserRepository {
  final Reader _read;
  SpecialUserRepository(this._read);

  Stream<DocumentSnapshot<Map<String, dynamic>>?> specialUserStateChange() {
    return _read(firebaseDBProvider).collection('loginIds').doc(_read(userControllerProvider)?['hr']).snapshots();
  }
}