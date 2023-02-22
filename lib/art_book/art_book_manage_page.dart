import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kokosai_74_app/appbar_options.dart';
import 'package:kokosai_74_app/main.dart';
import 'package:intl/intl.dart';


final artBookManagerProvider = Provider<ArtBookManager>((ref) {
  return ArtBookManager(ref.read);
});

class ArtBookManager {
  final Reader _read;

  ArtBookManager(this._read);

  Stream<List<Order>> ordersStream(String artBookName) => _read(firebaseDBProvider)
    .collection('artBooks')
    .doc(artBookName)
    .collection('orders')
    .snapshots()
    .map((orders) => orders.docs.map((e) => Order(e.data())).toList());
}

class Order {
  late final String hr;
  late final int count;
  late final Timestamp createdAt;

  Order(Map<String, dynamic> data) {
    hr = data['hr'] ?? '';
    count = data['orderCount'] ?? 0;
    createdAt = data['createdAt'] ?? Timestamp.now();
  }
}

final orderManagerProvider = StateNotifierProvider<OrderManagerNotifier, Map<String, Map<String, dynamic>>>((ref) {
  return OrderManagerNotifier(ref.read);
});

class OrderManagerNotifier extends StateNotifier<Map<String, Map<String, dynamic>>> {
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? _orderManager110Subscription;
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? _orderManager209Subscription;
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? _orderManager309Subscription;

  late final Stream<DocumentSnapshot<Map<String, dynamic>>> _orderManager110Stream = _read(firebaseDBProvider).collection('artBooks').doc('110').snapshots();
  late final Stream<DocumentSnapshot<Map<String, dynamic>>> _orderManager209Stream = _read(firebaseDBProvider).collection('artBooks').doc('209').snapshots();
  late final Stream<DocumentSnapshot<Map<String, dynamic>>> _orderManager309Stream = _read(firebaseDBProvider).collection('artBooks').doc('309').snapshots();

  final Reader _read;

  OrderManagerNotifier(this._read) : super({'110': {}, '209': {}, '309': {},}) {
    _orderManager110Subscription?.cancel();
    _orderManager209Subscription?.cancel();
    _orderManager309Subscription?.cancel();

    _orderManager110Subscription = _orderManager110Stream.listen((order) {
      Map<String, Map<String, dynamic>> stateCache = state;
      stateCache.addAll({'110': order.data() ?? {}});
      state = {...stateCache};
      print('orderManagerProvider: Order manager change was listened! ${state.toString()}');
    });

    _orderManager209Subscription = _orderManager209Stream.listen((order) {
      Map<String, Map<String, dynamic>> stateCache = state;
      stateCache.addAll({'209': order.data() ?? {}});
      state = {...stateCache};
      print('orderManagerProvider: Order manager change was listened! ${state.toString()}');
    });

    _orderManager309Subscription = _orderManager309Stream.listen((order) {
      Map<String, Map<String, dynamic>> stateCache = state;
      stateCache.addAll({'309': order.data() ?? {}});
      state = {...stateCache};
      print('orderManagerProvider: Order manager change was listened! ${state.toString()}');
    });
  }
  
  push(String artBook, Map<String, dynamic> property) {
    _read(firebaseDBProvider).collection('artBooks').doc(artBook).set(property, SetOptions(merge: true));
    print('orderManagerProvider: Pushed orderManager to $artBook! $property');
  }
}


final ordersProvider = StateNotifierProvider<OrdersNotifier, List<Order>>((ref) {
  return OrdersNotifier();
});

class OrdersNotifier extends StateNotifier<List<Order>> {
  OrdersNotifier(): super([]);

  void set(List<Order> newState) => state = newState;

  List<Order> get() => state;

  sortByHr() {
    var stateCache = state;
    stateCache.sort((a, b) => a.hr.compareTo(b.hr),);
    state = stateCache.toList();
    print('ordersProvider: Sorted state by hr!');
  }
  sortByDate() {
    var stateCache = state;
    stateCache.sort((a, b) => a.createdAt.toDate().compareTo(b.createdAt.toDate()),);
    state = stateCache.toList();
    print('ordersProvider: Sorted state by date!');
  }
}


final _pageProvider = StateProvider<String>((ref) {
  return '110';
});

final _sortProvider = StateProvider<String?>((ref) {
  return null;
});


class ArtBookManagePage extends ConsumerStatefulWidget {
  const ArtBookManagePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ArtBookManagePageState();
}

class _ArtBookManagePageState extends ConsumerState<ArtBookManagePage> {
  final List<String> _pageList = [
    '110',
    '209',
    '309',
  ];

  final List<String> _sortList = [
    'HR',
    '日時',
  ];

  late final Map<String, Stream<List<Order>>> ordersStreams;

  @override
  void initState() {
    super.initState();
    ordersStreams = {
      '110': ref.read(artBookManagerProvider).ordersStream('110'),
      '209': ref.read(artBookManagerProvider).ordersStream('209'),
      '309': ref.read(artBookManagerProvider).ordersStream('309'),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AltAppBar(context, '画集取り置き管理画面'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0).copyWith(top: 8.0, bottom: 8.0),
            child: Scrollbar(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  
                  children: [
                    SizedBox(
                      width: 80,
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: ref.watch(_pageProvider),
                        items: _pageList.map<DropdownMenuItem<String>>((String page) {
                          return DropdownMenuItem<String>(
                            value: page,
                            child: Text(page),
                          );
                        }).toList(),
                        onChanged: (String? page) {
                          if (page != null) {
                            ref.read(_pageProvider.notifier).update((state) => page);
                          }
                        }
                      ),
                    ),
                    const VerticalDivider(),
                    DropdownButton<String>(
                      icon: const Icon(Icons.sort),
                      value: ref.watch(_sortProvider),
                      hint: const Text('並び替え'),
                      items: _sortList.map<DropdownMenuItem<String>>((String sort) {
                        return DropdownMenuItem<String>(
                          value: sort,
                          child: Text(sort),
                        );
                      }).toList(),
                      onChanged: (String? sortBy) {
                        if (sortBy != null) {
                          ref.read(_sortProvider.notifier).update((state) => sortBy);
                          switch (sortBy) {
                            case 'HR':
                              ref.read(ordersProvider.notifier).sortByHr();
                              break;
                            case '日時':
                              ref.read(ordersProvider.notifier).sortByDate();
                              break;
                            default:
                          }
                        }
                      }
                    ),
                    const SizedBox(width: 10,),
                    Text('現在の状態: ${ref.watch(orderManagerProvider)[ref.watch(_pageProvider)]?['isOrderable'] ?? false ? '受付中' : '受付停止中'}'),
                    const SizedBox(width: 10,),
                    OutlinedButton(
                      onPressed: () {
                        showDialog(context: context, builder: (context) => ref.watch(orderManagerProvider)[ref.watch(_pageProvider)]?['isOrderable'] ?? false ? AlertDialog(
                          content: const Text('本当に受付を停止しますか？'),
                          actions: [
                            OutlinedButton(onPressed: () => Navigator.pop(context), child: const Text('キャンセル')),
                            ElevatedButton(
                              onPressed: () {
                                ref.read(orderManagerProvider.notifier).push(ref.read(_pageProvider), {'isOrderable': false});
                                Navigator.pop(context);
                              }, 
                              child: const Text('停止'),
                            ),
                          ],
                        ) : AlertDialog(
                          content: const Text('本当に受付を再開しますか？'),
                          actions: [
                            OutlinedButton(onPressed: () => Navigator.pop(context), child: const Text('キャンセル')),
                            ElevatedButton(
                              onPressed: () {
                                ref.read(orderManagerProvider.notifier).push(ref.read(_pageProvider), {'isOrderable': true});
                                Navigator.pop(context);
                              }, 
                              child: const Text('再開'),
                            ),
                          ],
                        ));
                      },
                      child: Text(ref.watch(orderManagerProvider)[ref.watch(_pageProvider)]?['isOrderable'] ?? false ? '受付を停止' : '受付を再開'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: ordersStreams[ref.watch(_pageProvider)],
              builder: (BuildContext context, AsyncSnapshot<List<Order>> snapshot) {
                Widget result;
                if (snapshot.hasData) {
                  List<Order> orders = snapshot.data!;
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    ref.read(ordersProvider.notifier).set(orders);
                  });
                  result = ListView.builder(
                    itemCount: ref.watch(ordersProvider).length,
                    itemBuilder: (context, index) {
                      Order order = ref.watch(ordersProvider)[index];
                      List<dynamic> markedOrders = ref.watch(orderManagerProvider)[ref.watch(_pageProvider)]?['markedOrders'];
                      return CheckboxListTile(
                        dense: true,
                        isThreeLine: true,
                        value: markedOrders.contains(order.hr),
                        title: Text('HR: ${order.hr}\n数量: ${order.count.toString()}'),
                        subtitle: Text(DateFormat('yyyy/MM/dd HH:mm').format(order.createdAt.toDate())),
                        onChanged: (value) {
                          List<dynamic> markedOrdersCache = markedOrders;
                          value ?? false
                            ? markedOrdersCache.add(order.hr)
                            : markedOrdersCache.remove(order.hr);
                          ref.read(orderManagerProvider.notifier).push(ref.watch(_pageProvider), {'markedOrders' : markedOrdersCache});
                        },
                      );
                    },
                  );
                  print('ArtBookManagePage: Order stream was listened with hasData!');
                } else if (snapshot.hasError) {
                  result = Center(
                    child: Text('エラーが発生しました。戻ってもう一度お試しください。\n${snapshot.error}'),
                  );
                  print('ArtBookManagePage: Order stream was listened with hasError!');
                } else {
                  result = const Center(
                    child: CircularProgressIndicator(),
                  );
                  print('ArtBookManagePage: Order stream was listened with hasNoData!');
                }
                return result;
              },
            ),
          ),
        ],
      )
    );
  }
}

