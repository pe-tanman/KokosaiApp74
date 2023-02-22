import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kokosai_74_app/appbar_options.dart';

/*
* マップ画面のウィジェット
* */
class MapPage extends ConsumerWidget {
  MapPage({Key? key}) : super(key: key);
  final List<Tab> _tabs = const <Tab>[
    Tab(text: '1F',),
    Tab(text: "2F",),
    Tab(text: "3F",),
  ];
  final List<Widget> _widgetOptions = <Widget>[
    Center(child: MapView(title: '1F', img: Image.asset('assets/images/maps/1Fmap.png')),),
    Center(child: MapView(title: '1F', img: Image.asset('assets/images/maps/2Fmap.png')),),
    Center(child: MapView(title: '1F', img: Image.asset('assets/images/maps/3Fmap.png')),),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('マップ'),
          centerTitle: true,
          actions: const <Widget>[
            NotificationIconButton()
          ],
          bottom: TabBar(
            unselectedLabelColor: Colors.white.withOpacity(0.3),
            unselectedLabelStyle: const TextStyle(fontSize: 12.0),
            tabs: _tabs,
          ),
        ),
        drawer: BasicDrawer(context, ref),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: _widgetOptions
        ),
      ),
    );
  }
}

class MapView extends StatelessWidget {
  const MapView({Key? key, required this.title, required this.img}) : super(key: key);

  final String title;
  final Image  img;

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: InteractiveViewer(
              minScale: 0.1,
              maxScale: 5,
              child: img,
            ),
          ),
        ],
      ),
    );
  }
}
