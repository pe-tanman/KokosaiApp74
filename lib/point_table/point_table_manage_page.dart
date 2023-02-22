import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kokosai_74_app/appbar_options.dart';
import 'package:kokosai_74_app/main.dart';


final pointTableProvider = StateNotifierProvider<PointTableNotifier, Map<String, dynamic>>((ref) {
  return PointTableNotifier(ref.read);
});

class PointTableNotifier extends StateNotifier<Map<String, dynamic>> {
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? _tableSubscription;
  late final Stream<DocumentSnapshot<Map<String, dynamic>>> _tableStream = _read(firebaseDBProvider).collection('pointTable').doc('table').snapshots();

  final Reader _read;

  PointTableNotifier(this._read): super({'red': 0, 'white': 0}) {
    debugPrint('pointTableProvider: pointTableProvider was launched!');
    _tableSubscription?.cancel();
    _tableSubscription = _tableStream.listen((table) {
      state = {...table.data() ?? {'red': 0, 'white': 0}};
      debugPrint('pointTableProvider: Point change was listened! $state');
    });
  }
  
  void push(String team, int point) {
    Map<String, int> stateCache = {...state, team: point};
    _read(firebaseDBProvider).collection('pointTable').doc('table').set(stateCache);
    debugPrint('pointTableProvider: State was pushed! $stateCache');
  }
}


final _redInputProvider = StateProvider<int>((ref) {
  return 0;
});

final _whiteInputProvider = StateProvider<int>((ref) {
  return 0;
});


class PointTableManagePage extends ConsumerWidget {
  const PointTableManagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AltAppBar(context, '体育祭得点表管理画面'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('現在の赤組得点: ${ref.watch(pointTableProvider)['red'].toString()}', style: Theme.of(context).textTheme.subtitle1,),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: '紅組得点',
                      hintText: '得点を入力してください'
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      ref.read(_redInputProvider.notifier).update((state) => int.parse(value));
                    },
                  ),
                ),
                const SizedBox(width: 10,),
                ElevatedButton(
                  onPressed: () {
                    ref.read(pointTableProvider.notifier).push('red', ref.read(_redInputProvider));
                  },
                  child: const Text('送信'),
                )
              ],
            ),
            const SizedBox(height: 30,),
            Text('現在の白組得点: ${ref.watch(pointTableProvider)['white'].toString()}', style: Theme.of(context).textTheme.subtitle1,),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: '白組得点',
                      hintText: '得点を入力してください'
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      ref.read(_whiteInputProvider.notifier).update((state) => int.parse(value));
                    },
                  ),
                ),
                const SizedBox(width: 10,),
                ElevatedButton(
                  onPressed: () {
                    ref.read(pointTableProvider.notifier).push('red', ref.read(_whiteInputProvider));
                  },
                  child: const Text('送信'),
                )
              ],
            ),
          ]
        ),
      ),
    );
  }
}