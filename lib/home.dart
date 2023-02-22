import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kokosai_74_app/appbar_options.dart';
import 'package:kokosai_74_app/art_book/art_book_page.dart';
import 'package:kokosai_74_app/bug_report_webview.dart';
import 'package:kokosai_74_app/events.dart';
import 'package:kokosai_74_app/pdf_page.dart';
import 'package:kokosai_74_app/point_table/point_table_page.dart';
import 'package:kokosai_74_app/tategaki/number_japanesed.dart';
import 'package:kokosai_74_app/tategaki/tategaki.dart';
import 'package:pdfx/pdfx.dart';

import 'auth/auth_controller.dart';
import 'music.dart';

final remainingDate = StateProvider<int>((ref) {
  var currentDateTime = DateTime.now();
  var goalDateTime = DateTime(2022, 9, 20, 0, 0);
  if (currentDateTime.isAfter(goalDateTime)) {
    if (currentDateTime.isAfter(DateTime(2022, 9, 20, 0, 0))) {
      return currentDateTime.difference(goalDateTime).inDays + 1;
    } else {
      return 0;
    }
  } else {
    return goalDateTime.difference(currentDateTime).inDays + 1;
  }
});

final topIllustProvider = StateProvider<String>((ref) {
  var currentDateTime = DateTime.now();
  var goalDateTime = DateTime(2022, 9, 20, 0, 0);
  if (currentDateTime.isAfter(goalDateTime)) {
    if (currentDateTime.isAfter(DateTime(2022, 9, 20, 0, 0))) {
      return 'assets/images/top_illust_in_days.png';
    } else {
      return 'assets/images/top_illust.png';
    }
  } else {
    return 'assets/images/top_illust.png';
  }
});

class HomePage extends ConsumerWidget {
  HomePage({Key? key}) : super(key: key);

  final ScrollController scrollController = ScrollController();


  Widget buildEventCard(BuildContext context, WidgetRef ref, String title, AssetImage img, int onTapedIndex, [bool isEnableWithoutAuth = false]) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
        child: SizedBox(
          width: 120,
          height: 140,
          child: Card(
            clipBehavior: Clip.antiAlias,
            color: Colors.transparent,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Ink.image(
              image: img,
              fit: BoxFit.cover,
              child: InkWell(
                onTap: () {
                  if (ref.read(authControllerProvider) == null && isEnableWithoutAuth == false) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(seconds: 2),
                        content: const Text('文化祭以外のページを利用するにはログインが必要です。'),
                        action: SnackBarAction(
                          label: 'ログイン',
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                        ),
                      )
                    );
                  } else {
                    ref.read(initialTabIndexOfEventsScreenProvider.notifier).set(onTapedIndex);
                    Navigator.pushNamed(context, '/events');
                  }
                },
              ),
            ),
          ),
        ),
      ),
    ],
  );

  Widget buildFuncCard(BuildContext context, IconData icon, String title, void Function()? onTap) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: Theme.of(context).dividerColor,
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: Theme.of(context).brightness == Brightness.light ? Theme.of(context).primaryColor : Theme.of(context).iconTheme.color?.withOpacity(.5),
                  size: 32,
                ),
                const SizedBox(height: 8,),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(title, style: TextStyle(color: Theme.of(context).brightness == Brightness.light ? Theme.of(context).primaryColor : Theme.of(context).iconTheme.color, fontSize: 11),)
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _onWillPop(BuildContext context) async {
    bool? exitResult = await showDialog(
      context: context,
      builder: (context) => _buildExitDialog(context),
    );
    return exitResult ?? false;
  }

  AlertDialog _buildExitDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('確認'),
      content: const Text('アプリを終了しますか？'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('いいえ'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('はい'),
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Widget> funcCards = [
      buildFuncCard(context, Icons.store, '発表団体', () {
        ref.read(initialTabIndexOfEventsScreenProvider.notifier).set(5);
        Navigator.pushNamed(context, '/events');
      }),
      buildFuncCard(context, Icons.map, 'マップ', () => Navigator.pushNamed(context, '/map')),
      buildFuncCard(context, Icons.music_note, 'テーマソン\n グ', () => Navigator.push(context, MaterialPageRoute(builder: (context) => const MusicPage()))),
      buildFuncCard(context, Icons.table_chart, '体育祭得点\n表', () => ref.read(authControllerProvider) == null ? ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          content: const Text('この機能を利用するにはログインが必要です。'),
          action: SnackBarAction(
            label: 'ログイン',
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
          ),
        )
      ) : Navigator.push(context, MaterialPageRoute(builder: (context) => const PointTablePage(),))),
      buildFuncCard(context, Icons.palette, '画集取り置\nき', () => ref.read(authControllerProvider) == null ? ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 2),
            content: const Text('この機能を利用するにはログインが必要です。'),
            action: SnackBarAction(
              label: 'ログイン',
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
            ),
          )
      ) : Navigator.push(context, MaterialPageRoute(builder: (context) => ArtBookPage(),))),
      buildFuncCard(context, Icons.rule, '体育祭るる\nぶ', () => ref.read(authControllerProvider) == null ? ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 2),
            content: const Text('この機能を利用するにはログインが必要です。'),
            action: SnackBarAction(
              label: 'ログイン',
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
            ),
          )
      ) : Navigator.push(context, MaterialPageRoute(
        builder: (context) => MyPdfPage(
          title: '体育祭るるぶ',
          pdfPinchController: PdfControllerPinch(document: PdfDocument.openAsset('assets/documents/rrb/rrb_origin.pdf'))
        )
      ))),
      buildFuncCard(context, Icons.article, 'プログラム\nダイジェスト', () => Navigator.push(context, MaterialPageRoute(
        builder: (context) => MyPdfPage(
          title: 'プログラムダイジェスト',
          pdfPinchController: PdfControllerPinch(document: PdfDocument.openAsset('assets/documents/program.pdf'))
        )
      ))),
      buildFuncCard(context, Icons.bug_report, '誤植\n・バグ報告', () => Navigator.push(context, MaterialPageRoute(builder: (context) => const BugReportPage()))),
    ];
    
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        appBar: BasicAppBar(context, 'ホーム', image: Theme.of(context).brightness == Brightness.light ? null : const AssetImage('assets/images/background/surface_fixed.jpg'),),
        drawer: BasicDrawer(context, ref),
        body: SafeArea(
          child: Scrollbar(
            thumbVisibility: true,
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  if (Theme.of(context).brightness == Brightness.dark) Column(
                    children: [
                      for (int i = 0; i < 3; i++) Image.asset('assets/images/background/surface_2.png'),
                    ],
                  ),
                  Column(
                    children: [
                      // トップイラスト
                      Stack(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Image.asset(ref.watch(topIllustProvider)),
                          ),
                          Positioned(
                            top: ref.watch(remainingDate) > 9 ? (MediaQuery.of(context).size.width * 10) / 19 : (MediaQuery.of(context).size.width * 10) / 18,
                            right: MediaQuery.of(context).size.width / 17,
                            child: SizedBox(
                              height: (MediaQuery.of(context).size.width * 10) / 70,
                              width: (MediaQuery.of(context).size.width * 10) / 80,
                              child: Tategaki(
                                JapaneseNumber.map[ref.watch(remainingDate)] ?? '零',
                                style: TextStyle(
                                  shadows: const [
                                    Shadow(
                                      blurRadius: 2.0
                                    )
                                  ],
                                  color: Colors.white,
                                  fontSize: (MediaQuery.of(context).size.width * 10) / 160, fontFamily: 'Tamanegi Kaisho GEKI',
                                ),
                              )
                            ),
                          )
                        ]
                      ),
                      const SizedBox(height: 20),
                      if (ref.watch(authControllerProvider) == null) Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: Card (
                            child: FittedBox(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(24, 20, 24, 10),
                                child: Center(
                                    child: Column(
                                      children: [
                                        const Text(
                                          '現在ゲストモードです。在校生の方はログインしてください。',
                                          textAlign: TextAlign.center,
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pushNamed(context, '/login');
                                          },
                                          child: const Text('ログイン')
                                        )
                                      ],
                                    )
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (ref.watch(authControllerProvider) == null) const SizedBox(height: 10),
                      // イベント
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(30,0,0,0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'イベント',
                                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '9月20日~25日',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10,),
                            SizedBox(
                              height: 161,
                              child: Scrollbar(
                                thumbVisibility: true,
                                controller: scrollController,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    const SizedBox(width: 30),
                                    buildEventCard(context, ref, '前夜祭', const AssetImage('assets/images/buttonImages/前夜祭.png'), 0),
                                    const SizedBox(width: 10),
                                    buildEventCard(context, ref, '体育祭', const AssetImage('assets/images/buttonImages/体育祭.png'), 1),
                                    const SizedBox(width: 10),
                                    buildEventCard(context, ref, '舞台発表', const AssetImage('assets/images/buttonImages/舞台発表.png'), 2),
                                    const SizedBox(width: 10),
                                    buildEventCard(context, ref, '分科会', const AssetImage('assets/images/buttonImages/分科会.png'), 3),
                                    const SizedBox(width: 10),
                                    buildEventCard(context, ref, '討論会', const AssetImage('assets/images/buttonImages/討論会.png'), 4),
                                    const SizedBox(width: 10),
                                    buildEventCard(context, ref, '文化祭', const AssetImage('assets/images/buttonImages/文化祭.png'), 5, true),
                                    const SizedBox(width: 10),
                                    buildEventCard(context, ref, '後夜祭', const AssetImage('assets/images/buttonImages/後夜祭.png'), 6),
                                    const SizedBox(width: 10),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(30,0,0,0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    '機能',
                                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 3,),
                                  Text(
                                    '発表団体ページから回った発表をチェックできます。',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              height: 300,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                child: GridView.count(
                                  primary: false,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  crossAxisCount: 4,
                                  childAspectRatio: (80 / 100),
                                  children: funcCards,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ]
              ),
            ),
          ),
        ),
      ),
    );
  }
}