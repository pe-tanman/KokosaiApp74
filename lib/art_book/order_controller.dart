import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kokosai_74_app/art_book/order_repository.dart';
import 'package:kokosai_74_app/auth/auth_controller.dart';
import 'package:kokosai_74_app/main.dart';
import 'package:kokosai_74_app/user/user_controller.dart';

final orderControllerProvider = StateNotifierProvider<OrderController, Map<String, Map<String, dynamic>?>>((ref) {
  print('OrderControllerProvider was launched!');
  return OrderController(ref.read);
});

class OrderController extends StateNotifier<Map<String, Map<String, dynamic>?>> {
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>?>?>? _orderFor110StateChangeSubscription;
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>?>?>? _orderFor209StateChangeSubscription;
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>?>?>? _orderFor309StateChangeSubscription;

  final Reader _read;

  OrderController(this._read) : super({'110': null, '209': null, '309': null,}) {
    _orderFor110StateChangeSubscription?.cancel();
    _orderFor209StateChangeSubscription?.cancel();
    _orderFor309StateChangeSubscription?.cancel();

    _orderFor110StateChangeSubscription = _read(orderRepositoryProvider).orderFor110StateChange().listen((order) {
      Map<String, Map<String, dynamic>?> stateCache = state;
      stateCache.addAll({'110': order?.data()});
      state = {...stateCache};
      print('orderController: Order 110 state changed! ${state.toString()}');
    });

    _orderFor209StateChangeSubscription = _read(orderRepositoryProvider).orderFor209StateChange().listen((order) {
      Map<String, Map<String, dynamic>?> stateCache = state;
      stateCache.addAll({'209': order?.data()});
      state = {...stateCache};
      print('orderController: Order 209 state changed! ${state.toString()}');
    });

    _orderFor309StateChangeSubscription = _read(orderRepositoryProvider).orderFor309StateChange().listen((order) {
      Map<String, Map<String, dynamic>?> stateCache = state;
      stateCache.addAll({'309': order?.data()});
      state = {...stateCache};
      print('orderController: Order 309 state changed! ${state.toString()}');
    });
  }
  
  // ログイン済み && firestoreのusersコレクションにユーザーデータがある && firestoreのartBooks/[画集のクラス]/[ユーザーのhr]が存在しない && firestoreのartBooks/orderControllerより取り置き受付中である => 取り置き可
  Future<void> order(String artBookName, int orderCount) async {
    if (_read(authControllerProvider) != null) {

      if (_read(userControllerProvider) != null) {
        DocumentReference artBookRef = _read(firebaseDBProvider).collection('artBooks').doc(artBookName);
        DocumentReference userOrderRef = artBookRef
          .collection('orders')
          .doc(_read(userControllerProvider)!['hr']!);
        DocumentSnapshot userOrderSnapshot = await userOrderRef.get();

        if (!userOrderSnapshot.exists) {
          Map<String, dynamic>? orderState = await _fetchOrderState(artBookName);

          if (orderState?['isOrderable'] ?? false) {
            DocumentSnapshot artBookSnapshot = await artBookRef.get();
            Map<String, dynamic> artBookData = artBookSnapshot.data() as Map<String, dynamic>;
            artBookData.addAll({
              'hr': _read(userControllerProvider)!['hr'],
              'orderCount': orderCount,
              'createdAt': FieldValue.serverTimestamp(),
            });
            userOrderRef.set(artBookData);
          } else {
            throw 'NotOrderable';
          }
        } else {
          throw 'OrderAlreadyExists';
        }
      } else {
        throw 'UserDocNotExisted';
      }
    } else {
      throw 'UserNotLoggedIn';
    }
  }

  Future<Map<String, dynamic>?> _fetchOrderState(String artBookName) async {
    DocumentReference orderControllerRef = _read(firebaseDBProvider).collection('artBooks').doc(artBookName);
    DocumentSnapshot orderControllerSnapshot = await orderControllerRef.get();
    Map<String, dynamic>? orderControllerData = orderControllerSnapshot.data() as Map<String, dynamic>?;
    return orderControllerData;
  }
}
