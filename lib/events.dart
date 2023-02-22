import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kokosai_74_app/appbar_options.dart';
import 'package:kokosai_74_app/events/bunkakai.dart';
import 'package:kokosai_74_app/events/bunkasai.dart';
import 'package:kokosai_74_app/events/butai.dart';
import 'package:kokosai_74_app/events/koyasai.dart';
import 'package:kokosai_74_app/events/request_login.dart';
import 'package:kokosai_74_app/events/taiikusai.dart';
import 'package:kokosai_74_app/events/toronkai.dart';
import 'package:kokosai_74_app/events/zenyasai.dart';

import 'auth/auth_controller.dart';

class InitialTabIndexOfEventsScreenNotifier extends StateNotifier<int> {
  InitialTabIndexOfEventsScreenNotifier() : super(0);

  void set(int index) => state = index;
  void reset() => state = 0;
}
final initialTabIndexOfEventsScreenProvider = StateNotifierProvider<InitialTabIndexOfEventsScreenNotifier, int>((ref) => InitialTabIndexOfEventsScreenNotifier());

class EventsPage extends ConsumerWidget {
  EventsPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Tab> tabs = <Tab>[
      const Tab(text: "前夜祭",),
      const Tab(text: "体育祭",),
      const Tab(text: "舞台発表",),
      const Tab(text: "分科会",),
      const Tab(text: "討論会",),
      const Tab(text: "文化祭",),
      const Tab(text: "後夜祭",),
    ];
    final List<Widget> widgetOptions = ref.watch(authControllerProvider) == null ? <Widget>[
      const RequestLogin(),
      const RequestLogin(),
      const RequestLogin(),
      const RequestLogin(),
      const RequestLogin(),
      Bunkasai(),
      const RequestLogin(),
    ] : <Widget>[
      Zenyasai(),
      Taiikusai(),
      Butai(),
      Bunkakai(),
      Toronkai(),
      Bunkasai(),
      Koyasai(),
    ];
    final initialIndex = ref.watch(initialTabIndexOfEventsScreenProvider);
    return DefaultTabController(
      length: 7,
      initialIndex: initialIndex,
      child: Scaffold(
          appBar: AppBar(
            title: const Text('イベント'),
            centerTitle: true,
            actions: const <Widget>[
              NotificationIconButton()
            ],
            bottom: TabBar(
              unselectedLabelColor: Colors.white.withOpacity(0.3),
              unselectedLabelStyle: const TextStyle(fontSize: 12.0),
              isScrollable: true,
              tabs: tabs,
            ),
          ),
          drawer: BasicDrawer(context, ref),
          body: TabBarView(
            children: widgetOptions,
          )
      ),
    );
  }
}