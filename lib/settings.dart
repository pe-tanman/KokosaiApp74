import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kokosai_74_app/appbar_options.dart';
import 'package:kokosai_74_app/art_book/art_book_manage_page.dart';
import 'package:kokosai_74_app/point_table/point_table_manage_page.dart';
import 'package:kokosai_74_app/settings/credit.dart';
import 'package:kokosai_74_app/settings/debug.dart';
import 'package:kokosai_74_app/settings/privacypolicy.dart';
import 'package:kokosai_74_app/settings/terms_of_service.dart';
import 'package:kokosai_74_app/special_user/special_user_controller.dart';
import 'package:kokosai_74_app/user/user_controller.dart';

/*
* 設定画面のウィジェット
* */
class SettingsPage extends ConsumerWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void _onTapped(BuildContext context, Widget widget) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => widget),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('設定'),
        centerTitle: true,
        actions: const <Widget>[
          NotificationIconButton()
        ],
      ),
      drawer: BasicDrawer(context, ref),
      body: ListView(
        children: [
          ListTile(
            title: const Text('プライバシーポリシー'),
            onTap: () => _onTapped(context, const PrivacyPolicy())
          ),
          ListTile(
            title: const Text('利用規約'),
            onTap: () => _onTapped(context, const TermsOfService())
          ),
          ListTile(
            title: const Text('クレジット'),
            onTap: () => _onTapped(context, Credit())
          ),
          if (ref.watch(specialUserControllerProvider)?['admin'] == true) ListTile(
            title: const Text('デバッグ'),
            onTap: () => _onTapped(context, Debug())
          ),
          if (ref.watch(specialUserControllerProvider)?['admin'] == true || ref.watch(specialUserControllerProvider)?['artBookPermission'] == true) ListTile(
            title: const Text('画集取り置き管理'),
            onTap: () => _onTapped(context, const ArtBookManagePage()),
          ),
          if (ref.watch(specialUserControllerProvider)?['admin'] == true || ref.watch(specialUserControllerProvider)?['pointTablePermission'] == true) ListTile(
            title: const Text('体育祭得点表管理'),
            onTap: () => _onTapped(context, const PointTableManagePage()),
          ),
        ],
      )
    );
  }
}