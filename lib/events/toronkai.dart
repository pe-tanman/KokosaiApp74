import 'package:flutter/material.dart';
import 'package:kokosai_74_app/events/event_detail.dart';

class Toronkai extends StatelessWidget {
  Toronkai({Key? key}) : super(key: key);

  final List<Map<String, String>> eventsInfo = [
    {
      'imgPath' : 'assets/images/toronkai/enviroment.jpg',
      'title' : '第一部　エネルギー・環境',
      'info' : '鯱光館',
      'pr' : '第一部では、今この瞬間も続く環境破壊の連鎖と原子力発電に対するさまざまな議論に焦点を当て、\n①原子力発電の是非 \n②経済発展と環境、どちらが大切か\nという2つのテーマで討論を行います。'
    },
    {
      'imgPath' : 'assets/images/toronkai/seculity.jpg',
      'title' : '第二部　安全保障',
      'info' : '鯱光館',
      'pr' : '第二部では身近に迫る安全保障の危機感と憲法9条のあり方に焦点を当て、\n①憲法9条は改正するべきか\n②日本は軍事予算を上げるべきか\nという2つのテーマで討論を行います。'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView(
        key: const PageStorageKey(4),
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
                    '討論会',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '4日目(9月23日)\n9:00~12:30',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    '第1部：9:00~10:30｜第2部：11:00~12:30',
                    style: TextStyle(fontSize: 15),
                  )
                ],
              ),
            ),
          ),
          Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => EventDetail(eventInfo: eventsInfo[0]),));
              },
              child: Column(
                children: [
                  Container(
                    height: 240,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(eventsInfo[0]['imgPath']!),
                        fit: BoxFit.cover
                      )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(eventsInfo[0]['title']!, style: const TextStyle(fontWeight: FontWeight.bold),),
                      subtitle: Text(eventsInfo[0]['info']!),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20,),
          Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => EventDetail(eventInfo: eventsInfo[1]),));
              },
              child: Column(
                children: [
                  Container(
                    height: 240,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(eventsInfo[1]['imgPath']!),
                        fit: BoxFit.cover
                      )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(eventsInfo[1]['title']!, style: const TextStyle(fontWeight: FontWeight.bold),),
                      subtitle: Text(eventsInfo[1]['info']!),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => EventDetail(eventInfo: eventsInfo[1]),));
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}