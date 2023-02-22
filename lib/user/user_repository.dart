import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kokosai_74_app/auth/auth_controller.dart';
import 'package:kokosai_74_app/main.dart';

abstract class BaseUserRepository {
  Stream<DocumentSnapshot<Map<String, dynamic>>?> userStateChange(String docName);
}

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository(ref.read);
});

class UserRepository implements BaseUserRepository {
  final Reader _read;
  UserRepository(this._read);

  @override
  Stream<DocumentSnapshot<Map<String, dynamic>>?> userStateChange(String docName) {
    return _read(firebaseDBProvider).collection('users').doc(docName).snapshots();
  }
}