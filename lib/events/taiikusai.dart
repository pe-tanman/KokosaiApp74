import 'package:flutter/material.dart';
import 'package:kokosai_74_app/pdf_page.dart';
import 'package:pdfx/pdfx.dart';

class Taiikusai extends StatelessWidget {
  Taiikusai({Key? key}) : super(key: key);

  final List<Map<String, String>> eventsInfo = [
    {
      'time' : '08:20',
      'title' : '点呼・選手変更受付',
      'subTitle': '',
      'pdfPath' : '',
      'tapEnabled' : 'false'
    },
    {
      'time' : '08:40',
      'title' : '開祭式',
      'subTitle': '',
      'pdfPath' : 'assets/documents/rrb/rrb5.pdf',
    },
    {
      'time' : '09:00',
      'title' : '玉入れ',
      'subTitle': '招集: 開会式後/トラック内',
      'pdfPath' : 'assets/documents/rrb/rrb6.pdf',
    },
    {
      'time' : '09:15',
      'title' : '女子 400mリレー',
      'subTitle': '招集: 09:00/ハンドコート',
      'pdfPath' : 'assets/documents/rrb/rrb7.pdf',
    },
    {
      'time' : '09:30',
      'title' : '男子 800mリレー',
      'subTitle': '招集: 09:00/ハンドコート',
      'pdfPath' : 'assets/documents/rrb/rrb8.pdf',
    },
    {
      'time' : '09:45',
      'title' : '綱引き',
      'subTitle': '招集: 男子800mリレー終了後/トラック内',
      'pdfPath' : 'assets/documents/rrb/rrb9.pdf',
    },
    {
      'time' : '10:15',
      'title' : '借り人二人三脚走',
      'subTitle': '招集: 男子800mリレー開始時/ハンドコート',
      'pdfPath' : 'assets/documents/rrb/rrb10.pdf',
    },
    {
      'time' : '10:45',
      'title' : '部対抗リレー真剣編(予選)',
      'subTitle': '招集: 綱引き開始時/ハンドコート',
      'pdfPath' : 'assets/documents/rrb/rrb11.pdf',
    },
    {
      'time' : '11:15',
      'title' : '台風の目',
      'subTitle': '招集: 部対抗リレー真剣編(予選)終了後/トラック内',
      'pdfPath' : 'assets/documents/rrb/rrb12.pdf',
    },
    {
      'time' : '11:35',
      'title' : '障害物競争',
      'subTitle': '招集: 部対抗リレー真剣編(予選)開始時/ハンドコート',
      'pdfPath' : 'assets/documents/rrb/rrb13.pdf',
    },
    {
      'time' : '12:45',
      'title' : '全員リレー(3年生後期HR対抗種目)',
      'subTitle': '招集: 12:30/トラック内',
      'pdfPath' : 'assets/documents/rrb/rrb14.pdf',
    },
    {
      'time' : '13:10',
      'title' : '部対抗リレー真剣編(決勝)',
      'subTitle': '招集: 全員リレー開始時/ハンドコート',
      'pdfPath' : 'assets/documents/rrb/rrb15.pdf',
    },
    {
      'time' : '13:30',
      'title' : '大玉運び',
      'subTitle': '招集: 部対抗リレー真剣編(決勝)終了後/トラック内',
      'pdfPath' : 'assets/documents/rrb/rrb16.pdf',
    },
    {
      'time' : '14:00',
      'title' : '紅白対抗リレー',
      'subTitle': '招集: 部対抗リレー真剣編(決勝)開始時/ハンドコート',
      'pdfPath' : 'assets/documents/rrb/rrb17.pdf',
    },
    {
      'time' : '14:30',
      'title' : '部対抗リレーパフォーマンス編',
      'subTitle': '招集: 紅白対抗リレー終了後/グラウンド',
      'pdfPath' : 'assets/documents/rrb/rrb18.pdf',
    },
    {
      'time' : '14:55',
      'title' : '閉祭式',
      'subTitle': '',
      'pdfPath' : 'assets/documents/rrb/rrb19.pdf',
    },
  ];

  Widget buildCard(BuildContext context, Map eventInfo) {
    return Card(
      color: eventInfo['tapEnabled'] == 'false' ? Colors.transparent : null,
      shape: eventInfo['tapEnabled'] == 'false' ? RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4), // if you need this
        side: BorderSide(
          color: Theme.of(context).dividerColor,
          width: 1,
        ),
      ) : null,
      elevation: eventInfo['tapEnabled'] == 'false' ? 0 : null,
      child: ListTile(
        leading: Text(
          eventInfo['time'],
          style: const TextStyle(fontSize: 24),
        ),
        title: Text(
          eventInfo['title'],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(eventInfo['subTitle']),
        onTap: () {
          eventInfo['tapEnabled'] == 'false' ? null : Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MyPdfPage(
                  title: eventInfo['title'],
                  pdfPinchController: PdfControllerPinch(document: PdfDocument.openAsset(eventInfo['pdfPath']))
              )
            )
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView(
        key: const PageStorageKey(1),
        children: [
          Container(
            width: double.infinity,
            height: 170,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    '体育祭',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '2日目(9月21日)\n8:40~14:55',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(16,0,0,0),
            child: Text('※タップでるるぶの対応するページを表示します。', style: TextStyle(fontSize: 14),),
          ),
          const SizedBox(height: 10,),
          OutlinedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyPdfPage(
                    title: 'るるぶ全体',
                    pdfPinchController: PdfControllerPinch(document: PdfDocument.openAsset('assets/documents/rrb/rrb_origin.pdf')),
                  )
                )
              );
            },
            child: const Text('るるぶ全体を表示'),
          ),
          const SizedBox(height: 10,),
          buildCard(context, eventsInfo[0]),
          buildCard(context, eventsInfo[1]),
          const Divider(height: 50, indent: 20, endIndent: 20,),
          buildCard(context, eventsInfo[2]),
          buildCard(context, eventsInfo[3]),
          buildCard(context, eventsInfo[4]),
          buildCard(context, eventsInfo[5]),
          buildCard(context, eventsInfo[6]),
          buildCard(context, eventsInfo[7]),
          buildCard(context, eventsInfo[8]),
          buildCard(context, eventsInfo[9]),
          const Divider(height: 50, indent: 20, endIndent: 20,),
          buildCard(context, eventsInfo[10]),
          buildCard(context, eventsInfo[11]),
          buildCard(context, eventsInfo[12]),
          buildCard(context, eventsInfo[13]),
          buildCard(context, eventsInfo[14]),
          const Divider(height: 50, indent: 20, endIndent: 20,),
          buildCard(context, eventsInfo[15]),
        ],
      ),
    );
  }
}