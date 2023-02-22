import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kokosai_74_app/auth/auth_controller.dart';
import 'package:kokosai_74_app/notifications.dart';

import 'events.dart';

class BasicAppBar extends AppBar {
  BasicAppBar(BuildContext context, String title, {Key? key, ImageProvider? image}) : super(key: key,
    title: Text(title),
    flexibleSpace: image == null ? null :  Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: image,
          fit: BoxFit.cover,
        ),
      ),
    ),
    centerTitle: true,
    actions: const <Widget>[
      NotificationIconButton()
    ],
  );
}
class AltAppBar extends AppBar {
  AltAppBar(BuildContext context, String title, {Key? key}) : super(key: key,
    leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Theme.of(context).textTheme.bodyText1?.color),
        onPressed: () => Navigator.pop(context)
    ),
    title: Text(title, style: TextStyle(color: Theme.of(context).textTheme.bodyText1?.color)),
    backgroundColor: Colors.transparent,
    elevation: 0
  );
}
class BlackAppBar extends AppBar {
  BlackAppBar(BuildContext context, String title, {Key? key}) : super(key: key,
    leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context)
    ),
    title: Text(title, style: const TextStyle(color: Colors.white)),
    backgroundColor: Colors.black,
    elevation: 0
  );
}

class BasicDrawer extends Drawer {
  BasicDrawer(BuildContext context, WidgetRef ref, {Key? key}) : super(key: key,
    child: Column(
      children: [
        Expanded(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: Divider.createBorderSide(context, width: 1),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 90,
                      child: Image.asset('assets/icon/icon.png', alignment: Alignment.topLeft),
                    ),
                    const Opacity(
                      opacity: .8,
                      child: Text(
                        '第74回鯱光祭アプリ',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Text(
                          'ステータス：',
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                        Text(
                          ref.watch(authControllerProvider) == null ? '未ログイン' : 'ログイン中',
                          style: TextStyle(
                            fontSize: 10,
                            color: ref.watch(authControllerProvider) == null ? Colors.red : Colors.green,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              if (ref.watch(authControllerProvider) == null) ListTile(
                title: const Text(
                  'ログイン',
                  style: TextStyle(fontSize: 16),
                ),
                trailing: const Icon(Icons.login),
                onTap: () {
                  Navigator.pushNamed(context, '/login');
                },
              ),
              if (ref.watch(authControllerProvider) == null) const Divider(thickness: 1),
              ListTile(
                title: const Text(
                  'ホーム',
                  style: TextStyle(fontSize: 16),
                ),
                onTap: () {
                  Navigator.popUntil(context, ModalRoute.withName('/home'));
                },
              ),
              ListTile(
                title: const Text(
                  'イベント一覧',
                  style: TextStyle(fontSize: 16),
                ),
                onTap: () {
                  ref.read(initialTabIndexOfEventsScreenProvider.notifier).reset();
                  Navigator.pushNamed(context, '/events');
                },
              ),
              ListTile(
                title: const Text(
                  'マップ',
                  style: TextStyle(fontSize: 16),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/map');
                },
              ),
              ListTile(
                title: const Text(
                  '設定',
                  style: TextStyle(fontSize: 16),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/settings');
                },
              ),
            ],
          ),
        ),
        if (!(ref.watch(authControllerProvider) == null)) const Divider(thickness: 1),
        if (!(ref.watch(authControllerProvider) == null)) ListTile(
          title: const Text(
            'ログアウト',
            style: TextStyle(fontSize: 16),
          ),
          trailing: const Icon(Icons.power_settings_new_rounded),
          onTap: () {
            showDialog(
              context: context,
              builder: (childContext) => AlertDialog(
                title: const Text('本当にログアウトしますか？'),
                content: const Text('ログアウト後は再度ログインする必要があります。'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('いいえ')
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                        barrierDismissible: false,
                      );
                      await ref.read(authControllerProvider.notifier).signOut();
                      Navigator.popUntil(context, ModalRoute.withName('/home'));
                    },
                    child: const Text('はい')
                  ),
                ],
              )
            );
          },
        ),
      ],
    )
  );
}

class NotificationIconButton extends StatelessWidget {
  const NotificationIconButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _onPressed() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Notifications()),
      );
    }
    return IconButton(
      onPressed: _onPressed,
      icon: const Icon(Icons.notifications),
    );
  }

}