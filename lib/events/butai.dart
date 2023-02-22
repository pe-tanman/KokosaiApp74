import 'package:flutter/material.dart';
import 'event_detail.dart';

class Butai extends StatelessWidget {
  Butai({Key? key}) : super(key: key);
  final List<Map<String, String>> eventsInfo = [
    {
      'title': 'OP Flash',
      'imgPath': 'assets/images/butai/OP Flash.jpg',
      'pr': '鯱光祭はまだまだこれから！！\nテンションバグらせていきましょ！！？？？\n制作　おひたし'
    },
    {
      'title': '吹奏楽部',
      'imgPath': 'assets/images/butai/吹奏楽部.jpg',
      'pr': 'あなたは和太鼓の演奏をしっかりと聴いたことはありますか…？あまり知られていない和太鼓の魅力、格好良さを存分に楽しんで頂けたらと思います。\nさあ、大和魂を呼び起こせ‼️‼️'
    },
    {
      'title': 'ダンスバドミントン部',
      'imgPath': 'assets/images/butai/ダンスバドミントン部.jpg',
      'pr': 'みなさんこんにちはこんばんは！ダンバドことダンスバドミントン部です。あの伝説の部紹介から早半年、ついにダンバドが鯱光祭の舞台にやってきました！！둘,셋(ドゥーセッ)ダンバド！！'
    },
    {
      'title': 'ぽっぷこーん',
      'imgPath': 'assets/images/butai/ぽっぷこーん.jpg',
      'pr': '歌とピアノを幼馴染2人でお届けします！ぜひお聴きください！'
    },
    {
      'title': '和太鼓風帆',
      'imgPath': 'assets/images/butai/和太鼓風帆.jpg',
      'pr': 'みなさんと楽しめるような演奏をお届けします。一緒に盛り上がりましょう！！'
    },
  ];
  Widget buildCard(BuildContext context, String suffix, Map<String, String> eventInfo) {

    return Card(
      child: ListTile(
        leading: Opacity(
          opacity: .3,
          child: Text(
            suffix,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          eventInfo['title']!,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
            eventInfo['pr']!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EventDetail(eventInfo: eventInfo,))
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView(
        key: const PageStorageKey(2),
        children: [
          Container(
            width: double.infinity,
            height: 200,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    '舞台発表',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '3日目(9月22日)\n8:50~12:16',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    '前半：8:50~10:16｜後半：10:50~12:16',
                    style: TextStyle(fontSize: 15),
                  )
                ],
              ),
            ),
          ),
          buildCard(context, '0', eventsInfo[0]),
          buildCard(context, '1', eventsInfo[1]),
          buildCard(context, '2', eventsInfo[2]),
          buildCard(context, '3', eventsInfo[3]),
          buildCard(context, '4', eventsInfo[4]),
        ],
      ),
    );
  }
}
