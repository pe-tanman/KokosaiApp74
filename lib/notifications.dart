import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kokosai_74_app/main.dart';
import 'package:kokosai_74_app/notification_page.dart';

import 'appbar_options.dart';

class NotificationRepository {
  NotificationRepository({this.title, this.content, this.createdAt});
  final String? title;
  final String? content;
  final String? createdAt;
}

class NotificationNotifier extends StateNotifier<List<NotificationRepository>> {
  final Reader _read;

  NotificationNotifier(this._read): super([]);

  Future<void> appStarted() async {
    await fetchNotificationDocs();
  }

  Future<void> fetchNotificationDocs() async {
    final notifications = <NotificationRepository>[];
    final querySnapshot = await _read(firebaseDBProvider).collection('notifications').get();
    final queryDocSnapshots = querySnapshot.docs;
    for (final snapshot in queryDocSnapshots) {
      final data = snapshot.data();
      notifications.add(
        NotificationRepository(
          title: data['title'],
          content: data['content'],
          createdAt: data['createdAt']
        )
      );
      print('output: $snapshot');
    }
    state = notifications;
  }

  Future<List<NotificationRepository>> fetchAndGetState() async {
    await fetchNotificationDocs();
    return state;
  }
}

final notificationProvider = StateNotifierProvider((ref) => NotificationNotifier(ref.read)..appStarted());


class NotificationPageControllerNotifier extends StateNotifier<Widget> {
  NotificationPageControllerNotifier(this._read): super(const CircularProgressIndicator());
  final Reader _read;

  void appStarted() async {
    try {
      print('App started!');
      final notifications = await _read(notificationProvider.notifier).fetchAndGetState();
      print('Fetch completed!');
      state = _listView(notifications);
      print('Update state completed!');
    } catch (e) {
      state = const Text('通知の取得に失敗しました。');
    }
  }

  ListView _listView(List<NotificationRepository> notifications) => ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (BuildContext context, int index) {
        final notification = notifications[index];
        return ListTile(
          title: Text(notification.title ?? 'null title'),
          subtitle: Text(notification.createdAt ?? 'null date'),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationPage(
              title: notification.title,
              content: notification.content,
              createdAt: notification.createdAt,
            )));
          },
        );
      }
  );
}

final notificationPageControllerProvider = StateNotifierProvider<NotificationPageControllerNotifier, Widget>((ref) => NotificationPageControllerNotifier(ref.read)..appStarted());

class Notifications extends ConsumerWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AltAppBar(context, '通知一覧'),
      body: Center(
        child: ref.watch(notificationPageControllerProvider)
      ),
    );
  }
}