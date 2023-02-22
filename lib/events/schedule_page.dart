import 'package:flutter/material.dart';
import 'package:kokosai_74_app/appbar_options.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({Key? key}) : super(key: key);

  Widget buildListTile({required String time, required Widget content}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(flex: 4, child: Center(child: Text(time,))),
          const Spacer(),
          Expanded(flex: 24, child: content)
        ],
      ),
    );
  }

  Widget buildCard({required TextTheme textStyle, required String label, required String title, String? subtitle}) {
    return InkWell(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(label, style: textStyle.labelSmall,),
              Text(title,),
              if (subtitle != null) Text(subtitle, style: textStyle.labelSmall,),
            ],
          )
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textStyle = Theme.of(context).textTheme;
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AltAppBar(context, '文化祭スケジュール'),
      body: Scrollbar(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: screenSize.width * 1.7,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 5日目
                    Text('5日目', style: textStyle.headline4,),
                    const SizedBox(height: 10,),
                    buildListTile(time: '8:20', content: const Text('朝の点呼')),
                    buildListTile(
                      time: '9:30~11:00', 
                      content: Row(
                        children: [
                          Expanded(
                            child: buildCard(textStyle: textStyle, label: '301 (鯱光館)', title: 'マスカレード・ホテル')
                          ),
                          Expanded(
                            child: buildCard(textStyle: textStyle, label: '302 (小体育館)', title: 'アルジャーノンに花束を')
                          ),
                          Expanded(
                            child: buildCard(textStyle: textStyle, label: '301 (武道場)', title: 'ナミヤ雑貨店の奇蹟')
                          ),
                        ],
                      )
                    ),
                    buildListTile(time: '11:15~11:30', content: const Text('合唱部')),
                    buildListTile(time: '11:35~11:50', content: const Text('弦楽部')),
                    buildListTile(time: '11:55~12:10', content: const Text('ファイアトーチ部')),
                    buildListTile(time: '12:20~12:40', content: const Text('DANCE')),
                    buildListTile(
                      time: '13:00~14:30', 
                      content: Row(
                        children: [
                          Expanded(
                            child: buildCard(textStyle: textStyle, label: '308 (鯱光館)', title: '図書室のはこぶね')
                          ),
                          Expanded(
                            child: buildCard(textStyle: textStyle, label: '305 (小体育館)', title: 'カイジ')
                          ),
                          Expanded(
                            child: buildCard(textStyle: textStyle, label: '304 (武道場)', title: 'コクリコ坂から')
                          ),
                        ],
                      )
                    ),
                    buildListTile(time: '15:00', content: const Text('ここまで一般公開')),
                    buildListTile(time: '集まり次第', content: const Text('帰りの点呼')),
                    buildListTile(time: '15:15~16:45', content: const Text('校内発表')),
                    buildListTile(time: '18:00', content: const Text('完全下校')),
                    const SizedBox(height: 30,),
          
                    // 6日目
                    Text('6日目', style: textStyle.headline4,),
                    const SizedBox(height: 10,),
                    buildListTile(time: '8:20', content: const Text('朝の点呼')),
                    buildListTile(
                      time: '9:30~11:00', 
                      content: Row(
                        children: [
                          Expanded(
                            child: buildCard(textStyle: textStyle, label: '303 (鯱光館)', title: 'DEATH NOTE')
                          ),
                          Expanded(
                            child: buildCard(textStyle: textStyle, label: '306 (小体育館)', title: 'Les Miserables')
                          ),
                          const Expanded(
                            child: Spacer(),
                          ),
                        ],
                      )
                    ),
                    buildListTile(time: '11:15~11:35', content: const Text('弦楽部')),
                    buildListTile(time: '11:40~11:55', content: const Text('吹奏楽部x書道部')),
                    buildListTile(
                      time: '12:00開演', 
                      content: Row(
                        children: [
                          Expanded(
                            child: buildCard(textStyle: textStyle, label: '軽音楽部 (武道場)', title: '武道場ライブ'),
                          ),
                          const Expanded(
                            child: Spacer(),
                          ),
                          const Expanded(
                            child: Spacer(),
                          ),
                        ],
                      )
                    ),
                    buildListTile(time: '12:00~12:25', content: const Text('第六十七代旭丘應援團')),
                    buildListTile(time: '12:30~12:50', content: const Text('DANCE')),
                    buildListTile(
                      time: '13:00開演', 
                      content: Row(
                        children: [
                          Expanded(
                            child: buildCard(textStyle: textStyle, label: '演劇部(小体育館)', title: '創作脚本「傷跡」'),
                          ),
                          const Expanded(
                            child: Spacer(),
                          ),
                          const Expanded(
                            child: Spacer(),
                          ),
                        ],
                      )
                    ),
                    buildListTile(time: '15:00', content: const Text('ここまで一般公開')),
                    buildListTile(time: '集まり次第', content: const Text('帰りの点呼&15:45まで清掃')),
                    buildListTile(
                      time: '13:00開演', 
                      content: Row(
                        children: [
                          Expanded(
                            child: buildCard(textStyle: textStyle, label: '中の部(2部制) ▶ 外の部', title: '後夜祭'),
                          ),
                          const Expanded(
                            child: Spacer(),
                          ),
                          const Expanded(
                            child: Spacer(),
                          ),
                        ],
                      )
                    ),
                    buildListTile(time: '19:30', content: const Text('完全下校')),
                    const SizedBox(height: 300,)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
