import 'package:flutter/material.dart';
import 'event_detail.dart';

class Zenyasai extends StatelessWidget {
  Zenyasai({Key? key}) : super(key: key);
  final List<Map<String, String>> eventsInfo = [
    {
      'title': 'OP Flash',
      'imgPath': 'assets/images/zenyasai/OP Flash.jpg',
      'pr': '鯱光祭、READY GO!!\n制作者の名前\n動画　宮崎正理\n音楽　そば'
    },
    {
      'title': 'Cracked Biscuits',
      'imgPath': 'assets/images/zenyasai/Cracked Biscuits.jpg',
      'pr': '中国語では碎餅乾、フランス語ではBiscuits concassés、アラビア語ではبسكويت متكسر、和名は割れせんべい、どうもクラビスです！'
    },
    {
      'title': 'イデ',
      'imgPath': 'assets/images/zenyasai/イデ.jpg',
      'pr': 'がるるるるるってほらかわいい。なんでかわいいって言ってくれんの？かわいいと言われたい。圧倒的にかわいいと言われる回数が少ない。かわいいってまじで言ってほしい。'
    },
    {
      'title': '優柔不断',
      'imgPath': 'assets/images/zenyasai/優柔不断.jpg',
      'pr': '優柔不断です。よろしくお願いします。'
    },
    {
      'title': '食罪\'s',
      'imgPath': 'assets/images/zenyasai/食罪\'s.jpg',
      'pr': '🍆メンバー紹介🌽\nれんこん…言わずと知れた根菜の王\nかき　…俺だけガチャにいない疎外感。\nルッコラ…名乗っているが実は食べたことなし\n\n食材たちはその罪を背負って今日も舞う！'
    },
    {
      'title': 'とへん',
      'imgPath': 'assets/images/zenyasai/とへん.jpg',
      'pr': 'とへん、103です。よろしくお願いします！\nplay the pianoします　どうぞお楽しみにー　LET\'S ENJOY!\nイラスト作成協力者:103の友だち'
    },
    {
      'title': 'DANCE',
      'imgPath': 'assets/images/zenyasai/DANCE.jpg',
      'pr': '“Fly to your heart”みなさんの心まで届くように全力で踊ります。\n最後まで楽しんでいってください！\n(拍手などで盛り上げてくれると嬉しいです！)'
    },
    {
      'title': '第六十七代旭丘應援團',
      'imgPath': 'assets/images/zenyasai/第六十七代旭丘應援團.jpg',
      'pr': '押忍。我々は、第六十七代旭丘應援團です。今年も、鯱光祭の成功を全力で祈ります。'
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
        key: const PageStorageKey(0),
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
                    '前夜祭',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '1日目(9月20日)\n8:45~13:25',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    '前半：8:45~10:37｜後半：11:40~13:25',
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
          buildCard(context, '5', eventsInfo[5]),
          buildCard(context, '6', eventsInfo[6]),
          buildCard(context, '7', eventsInfo[7]),
        ],
      ),
    );
  }
}
