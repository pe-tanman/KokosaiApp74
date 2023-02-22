import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kokosai_74_app/main.dart';
import 'package:kokosai_74_app/user/user_controller.dart';

final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  return OrderRepository(ref.read);
});

class OrderRepository {
  final Reader _read;
  OrderRepository(this._read);

  Stream<DocumentSnapshot<Map<String, dynamic>>?> orderFor110StateChange() {
    return _read(firebaseDBProvider)
      .collection('artBooks')
      .doc('110')
      .collection('orders')
      .doc(_read(userControllerProvider)?['hr'])
      .snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>?> orderFor209StateChange() {
    return _read(firebaseDBProvider)
      .collection('artBooks')
      .doc('209')
      .collection('orders')
      .doc(_read(userControllerProvider)?['hr'])
      .snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>?> orderFor309StateChange() {
    return _read(firebaseDBProvider)
      .collection('artBooks')
      .doc('309')
      .collection('orders')
      .doc(_read(userControllerProvider)?['hr'])
      .snapshots();
  }
}