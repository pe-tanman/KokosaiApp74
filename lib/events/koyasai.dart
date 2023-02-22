import 'package:flutter/material.dart';
import 'event_detail.dart';

class Koyasai extends StatelessWidget {
  Koyasai({Key? key}) : super(key: key);
  final List<Map<String, String>> eventsInfo = [
    {
      'title': 'ED Flash',
      'imgPath': 'assets/images/koyasai/ED Flash.jpg',
      'pr': '後夜祭こそが最高の舞台！！！ どう楽しむかはあなた次第！！\n動画　こあらの行進\n音楽　Mine'
    },
    {
      'title': 'ナヨ銃',
      'imgPath': 'assets/images/koyasai/ナヨ銃.jpg',
      'pr': 'リア充？非リア充？オレらはナヨ銃だ！！'
    },
    {
      'title': '雷威徒',
      'imgPath': 'assets/images/koyasai/雷威徒.jpg',
      'pr': '僕たち雷威徒はサイリウムダンスチームです！色鮮やかなサイリウムにご注目を！'
    },
    {
      'title': 'Anemos',
      'imgPath': 'assets/images/koyasai/Anemos.jpg',
      'pr': '楽しさも苦しみも、嬉しさも悲しみも、音楽とともに！'
    },
    {
      'title': '第六十七代旭丘應援團',
      'imgPath': 'assets/images/koyasai/第六十七代旭丘應援團.jpg',
      'pr': '襲名を行います。第六十七代の華々しいラスト、そして、第六十八代旭丘應援團の生まれ出づる瞬間を、しかとご覧あれ！！'
    },
    {
      'title': 'ファイヤートーチ部',
      'imgPath': 'assets/images/koyasai/ファイヤートーチ部.jpg',
      'pr': '今年もやって参りました、後夜祭トーチ。\n鯱光祭を締めくくるに相応しい炎舞をできるように頑張ります！！！'
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
              MaterialPageRoute(builder: (context) => EventDetail(eventInfo: eventInfo,)));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView(
        key: const PageStorageKey(6),
        children: [
          SizedBox(
            width: double.infinity,
            height: 220,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '後夜祭',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    '6日目(9月25日)\n16:00~18:56',
                    style: TextStyle(fontSize: 18),
                  ),
                  Row(
                    children: const [
                      Text(
                        '中第1部：16:00~16:44',
                        style: TextStyle(fontSize: 15),
                      ),
                      Text(
                        '｜',
                        style: TextStyle(fontSize: 15),
                      ),
                      Text(
                        '中第2部：17:15~18:00',
                        style: TextStyle(fontSize: 15),
                      )
                    ],
                  ),
                  const Text(
                    '外の部：18:15~18:56',
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
          const Divider(height: 30, indent: 20, endIndent: 20,),
          buildCard(context, '4', eventsInfo[4]),
          buildCard(context, '5', eventsInfo[5]),
        ],
      ),
    );
  }
}
