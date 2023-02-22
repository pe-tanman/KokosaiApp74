import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kokosai_74_app/events/schedule_page.dart';
import 'package:kokosai_74_app/local_preferences.dart';
import 'package:select_dialog/select_dialog.dart';

import 'event_detail.dart';
//
// final loadVisitedEventsProvider = FutureProvider<List<Map<String, String>>>((ref) async {
//   print('Start loading');
//   List<String> localSavedEvents = await LocalPreferences.readSetting<List<String>>('visitedEvents');
//   print('localSavedEvents: $localSavedEvents');
//
//   List<Map<String, String>> allEvents = [];
//   allEvents.addAll(EventsInfoData.eventsInfo1);
//   allEvents.addAll(EventsInfoData.eventsInfo2);
//   allEvents.addAll(EventsInfoData.eventsInfo3);
//   allEvents.addAll(EventsInfoData.eventsInfo4);
//   print('allEvents: $allEvents');
//
//   List<Map<String, String>> result = [];
//
//   for (var e in allEvents) {
//     if (localSavedEvents.contains(e['title']!)) {
//       result.add(e);
//     }
//   }
//   print('result: $result');
//   ref.read(visitedEventsProvider.notifier).update((state) => result);
//   return result;
// });

class VisitedEventsNotifier extends StateNotifier<List<Map<String, String>>> {
  VisitedEventsNotifier(): super([]);

  void loadSavedState() async {
    print('Start loading');

    List<String> localSavedEvents = await LocalPreferences.readSetting<List<String>>('visitedEvents');
    print('localSavedEvents: $localSavedEvents');

    List<Map<String, String>> allEvents = [];
    allEvents.addAll(EventsInfoData.eventsInfo1);
    allEvents.addAll(EventsInfoData.eventsInfo2);
    allEvents.addAll(EventsInfoData.eventsInfo3);
    allEvents.addAll(EventsInfoData.eventsInfo4);
    print('allEvents: $allEvents');

    List<Map<String, String>> result = [];
    for (var e in allEvents) {
      if (localSavedEvents.contains(e['title']!)) {
        result.add(e);
      }
    }
    print('result: $result');

    state = result;
  }

  void setState(List<Map<String, String>> value) {
    state = value;
  }

  void add(Map<String, String> value) {
    List<Map<String, String>> stateCache = state;
    stateCache.add(value);
    state = stateCache.toList();
  }

  void remove(Map<String, String> value) {
    List<Map<String, String>> stateCache = state;
    stateCache.remove(value);
    state = stateCache.toList();
  }

  List<Map<String, String>> getState() {
    return state;
  }
}

final visitedEventsProvider = StateNotifierProvider<VisitedEventsNotifier, List<Map<String, String>>>((ref) {
  return VisitedEventsNotifier()..loadSavedState();
});

class EventsInfoData {
  static final List<Map<String, String>> eventsInfo1 = [
    {
      'hr' : '101',
      'title' : '館漫浪正大〜時代の魔法にかけられて〜',
      'info' : '2階 101教室',
      'pr' : '気が付くと僕たちはタイムスリップしていた...!?\nレトロの代名詞、大正浪漫を堪能せよ!!',
      'imgPath' : 'assets/images/bunkasai/101.jpg'
    },
    {
      'hr' : '102',
      'title' : '絶望要塞(バスティーユ)',
      'info' : '2階 102教室',
      'pr' : '気がつくとそこは死刑執行室だった…。\n部屋の手掛かりをヒントに牢獄からの脱出を試みよ‼️',
      'imgPath' : 'assets/images/bunkasai/102.jpg'
    },
    {
      'hr' : '103',
      'title' : '0.01',
      'info' : '2階 103教室',
      'pr' : '103のお化け屋敷です！\n仲の良い友達と、\n気になるあの子とどうですか❤️？',
      'imgPath' : 'assets/images/bunkasai/103.jpg'
    },
    {
      'hr' : '104',
      'title' : '104グルイ〜生か死か〜',
      'info' : '2階 104教室',
      'pr' : 'おい、そこの君！我が日本国にカジノという名の賭場は必要かい、不必要かい、どっちなんだい！？パワー!!!',
      'imgPath' : 'assets/images/bunkasai/104.jpg'
    },
    {
      'hr' : '105',
      'title' : '君のハートにジャストヒット',
      'info' : '2階 105教室',
      'pr' : '105で疑似恋愛しませんか？ミニゲームをクリアして攻略対象のハートをゲットすると恋人ができるかも⁉',
      'imgPath' : 'assets/images/bunkasai/105.jpg'
    },
    {
      'hr' : '106',
      'title' : 'それでも自分はやってない',
      'info' : '2階 106教室',
      'pr' : 'あなたの手にかけられた手錠は本当は誰のものなのか。\n謎を解いて真実を暴きだせ！',
      'imgPath' : 'assets/images/bunkasai/106.jpg'
    },
    {
      'hr' : '107',
      'title' : '走れ!!宮田郎電鉄',
      'info' : '2階 107教室',
      'pr' : '107が桃太郎電鉄ならぬ宮太郎電鉄を運行開始!?ミニゲームを楽しみつつ、旭丘を旅しませんか?',
      'imgPath' : 'assets/images/bunkasai/107.jpg'
    },
    {
      'hr' : '108',
      'title' : 'アタッ菌グin108',
      'info' : '2階 108教室',
      'pr' : '108担任千種先生の体内に突如侵入した沢山のウイルスたち。彼女の体が蝕まれる前にウイルスに立ち向かえ！',
      'imgPath' : 'assets/images/bunkasai/108.jpg'
    },
    {
      'hr' : '109',
      'title' : '藤源郷',
      'info' : '2階 109教室',
      'pr' : '「中華が君(の賭博本能)を熱くする！クッ○ドゥー！\n109に来てね！味の○♪」',
      'imgPath' : 'assets/images/bunkasai/109.jpg'
    },
    {
      'hr' : '110',
      'title' : '旭美大サーカス',
      'info' : '3階 110教室',
      'pr' : '虎？ピエロ？象！？110がおくる賑やかで彩やかな2日間。旭美大サーカス開演！！',
      'imgPath' : 'assets/images/bunkasai/110.jpg'
    },
  ];

  static List<Map<String, String>> eventsInfo2 = [
    {
      'hr' : '201',
      'title' : '牢獄からの脱出',
      'info' : '3階 201教室',
      'pr' : '｢───君がここに居るのは、何かの間違いだ。\nここから脱出して、一緒に帰ろうじゃないか───｣',
      'imgPath' : 'assets/images/bunkasai/201.jpg'
    },
    {
      'hr' : '202',
      'title' : 'VSpy × park',
      'info' : '3階 202教室',
      'pr' : 'さぁ、君もSPY×FAMILY の世界へ行こう。202でお待ちしています！',
      'imgPath' : 'assets/images/bunkasai/202.jpg'
    },
    {
      'hr' : '203',
      'title' : 'それ逝け!アンパンマン〜愛と勇気とterrified〜',
      'info' : '3階 203教室',
      'pr' : '材料不足で、不完全なアンパンマンが生まれてしまった。誰か彼の暴走を止めてくれ！',
      'imgPath' : 'assets/images/bunkasai/203.jpg'
    },
    {
      'hr' : '204',
      'title' : 'La Revolution',
      'info' : '3階 204教室',
      'pr' : '急募　前線指揮官\n知恵を持ち合わせ、敵を撃ち倒せる。\n\nそんな人材を我々は欲している\n　　　　　　　　204革新派一同',
      'imgPath' : 'assets/images/bunkasai/204.jpg'
    },
    {
      'hr' : '205',
      'title' : '扉の向こうは猫の国',
      'info' : '3階 205教室',
      'pr' : '『205の扉を抜けると\n　　　そこは猫の国であった。』\n人の姿へ戻る為、猫の国から脱出せよ。',
      'imgPath' : 'assets/images/bunkasai/205.jpg'
    },
    {
      'hr' : '206',
      'title' : '血紅の邸宅',
      'info' : '3階 206教室',
      'pr' : '古風な洋館を訪れたあなたは、ある頼み事をされる。ドラキュラを封印してほしい、と。',
      'imgPath' : 'assets/images/bunkasai/206.jpg'
    },
    {
      'hr' : '207',
      'title' : 'そこのお前、人生やり直してみねぇか',
      'info' : '3階 207教室',
      'pr' : '人生ゲームが体験型アトラクションに！来るしかないよね？来てね！来てよ？来て(圧)',
      'imgPath' : 'assets/images/bunkasai/207.jpg'
    },
    {
      'hr' : '208',
      'title' : 'KOH STORY',
      'info' : '3階 208教室',
      'pr' : '208「KOH STORY」では、おもちゃ達によるシューティングゲームが楽しめます！',
      'imgPath' : 'assets/images/bunkasai/208.jpg'
    },
    {
      'hr' : '209',
      'title' : 'KYOKUVEGAS',
      'info' : '3階 209教室',
      'pr' : '0時現在。ここは眠らない街 キョクベガス。\n暗い路地を抜けるとそこに広がるのは…？',
      'imgPath' : 'assets/images/bunkasai/209.jpg'
    },
  ];

  static final List<Map<String, String>> eventsInfo3 = [
    {
      'hr' : '301',
      'title' : 'ナミヤ雑貨店の奇蹟',
      'info' : '5日目(9月24日) 9:30~ 武道場',
      'imgPath' : 'assets/images/bunkasai/301.jpg'
    },
    {
      'hr' : '302',
      'title' : 'アルジャーノンに花束を',
      'info' : '5日目(9月24日) 9:30~ 小体育館',
      'imgPath' : 'assets/images/bunkasai/302.jpg'
    },
    {
      'hr' : '303',
      'title' : 'DEATH NOTE',
      'info' : '6日目(9月25日) 9:30~ 鯱光館',
      'imgPath' : 'assets/images/bunkasai/303.jpg'
    },
    {
      'hr' : '304',
      'title' : 'コクリコ坂から',
      'info' : '5日目(9月24日) 13:00~ 武道場',
      'imgPath' : 'assets/images/bunkasai/304.jpg'
    },
    {
      'hr' : '305',
      'title' : 'カイジ',
      'info' : '5日目(9月24日) 13:00~ 小体育館',
      'imgPath' : 'assets/images/bunkasai/305.jpg'
    },
    {
      'hr' : '306',
      'title' : 'レ・ミゼラブル',
      'info' : '6日目(9月25日) 9:30~ 小体育館',
      'imgPath' : 'assets/images/bunkasai/306.jpg'
    },
    {
      'hr' : '307',
      'title' : 'マスカレード・ホテル',
      'info' : '5日目(9月24日) 9:30~ 鯱光館',
      'imgPath' : 'assets/images/bunkasai/307.jpg'
    },
    {
      'hr' : '308',
      'title' : '図書室のはこぶね',
      'info' : '5日目(9月24日) 13:00~ 鯱光館',
      'imgPath' : 'assets/images/bunkasai/308.jpg'
    },
    {
      'hr' : '309',
      'title' : '街華中美旭',
      'info' : '1階 多目的室1',
      'imgPath' : 'assets/images/bunkasai/309.jpg'
    },
  ];

  static final List<Map<String, String>> eventsInfo4 = [
    {
      'title' : '写真部',
      'info' : '2階 生徒サロン東',
      'pr' : 'PR文･･･♡写真展示　♡♡写真講座　♡♡♡写真撮影　生徒サロンでやってるからねっ...！',
      'imgPath' : 'assets/images/bunkasai/yushidantai/写真部.jpg'
    },
    {
      'title' : 'A-times編集部',
      'info' : '1階 正面玄関',
      'pr' : '旭丘の校内誌「A-Times」を配布します！',
      'imgPath' : 'assets/images/bunkasai/yushidantai/Atimes.jpg'
    },
    {
      'title' : '軽音楽部',
      'info' : '6日目(9月25日) 11:30開場 12:00開演 14:00頃終演\n武道場',
      'pr' : '軽音楽部です！日曜は見慣れた武道場がライブハウスに！ぜひお越しください♩',
      'imgPath' : 'assets/images/bunkasai/yushidantai/軽音楽部.jpg'
    },
    {
      'title' : '弦楽部',
      'info' : '5日目(9月24日) 11:35~11:50 中庭\n6日目(9月25日) 11:15~11:35 中庭',
      'pr' : '弦楽部です♪\n私たちはディズニーメドレーを演奏します！\n精一杯演奏するのでぜひ聴いてください！',
      'imgPath' : 'assets/images/bunkasai/yushidantai/弦楽部.jpg'
    },
    {
      'title' : '合唱部',
      'info' : '5日目(9月24日) 11:15~11:30 中庭',
      'pr' : 'こんにちは、合唱部です！文化祭では、校内に綺麗な歌声を響かせるので、ぜひ聴きに来てください！',
      'imgPath' : 'assets/images/bunkasai/yushidantai/合唱部.jpg'
    },
    {
      'title' : '旭丘高校ダンス部',
      'info' : '3階 生徒サロン',
      'pr' : '歴代衣装や過去公演の映像など、ダンス部についてたくさん知れちゃうコーナーです♡',
      'imgPath' : 'assets/images/bunkasai/yushidantai/ダンス部.jpg'
    },
    {
      'title' : 'DANCE',
      'info' : '5日目(9月24日) 12:20~12:40 中庭\n6日目(9月25日) 12:30~12:50 中庭',
      'pr' : 'ダンス部です！\n毎年恒例中庭公演！今年も開催します♪\nぜひお越しください！',
      'imgPath' : 'assets/images/bunkasai/yushidantai/ダンス（中庭）.jpg'
    },
    {
      'title' : '映画制作部',
      'info' : '2階 視聴覚室',
      'pr' : 'こんにちは！映画製作部です！\n私たちは、実写班による短編映画、アニメ班によるショートアニメーションを複数上映します。今年は例年より部員が増えどちらの班も活気づいているので、初めて見る方も去年見てくださった方も、レベルアップした私たちの作品をぜひ見に来てください！',
      'imgPath' : 'assets/images/bunkasai/yushidantai/映画制作部.jpg'
    },
    {
      'title' : 'きぐるみ愛好会',
      'info' : '',
      'pr' : 'きぐるみを着ている人(通称:きぐるまー)を見つけたら声をかけてみよう！たくさんのきぐるまーが校内を徘徊しているよ！きぐるまー全種、コンプしてみよう!!きぐるまーと一緒に写真を撮ると良いことあるかもね!!ｷｬ~!!\nP.S. きぐるみ食べようね!!',
      'imgPath' : 'assets/images/bunkasai/yushidantai/きぐるみ愛好会.jpg'
    },
    {
      'title' : '数理科学部',
      'info' : '3階 化学室',
      'pr' : '数理科学部では実験や数学の講義を行います!!\n知識なくても全然OK ぜひ化学室まで!!!',
      'imgPath' : 'assets/images/bunkasai/yushidantai/数理科学部.jpg'
    },
    {
      'title' : '旭丘高校クイズ研究部',
      'info' : '1階 多目的室2 ※日曜日のみ',
      'pr' : 'やめられないとまらないAQuAの早押し体験！',
      'imgPath' : 'assets/images/bunkasai/yushidantai/クイズ研究部.jpg'
    },
    {
      'title' : '競技かるた部',
      'info' : '1階 和室',
      'pr' : '私たちは狭い和室・広い心とともに日々仲良く活動しています。百人一首を覚えていなくても大丈夫！和室に足を運んでみてください☺️',
      'imgPath' : 'assets/images/bunkasai/yushidantai/かるた.jpg'
    },
    {
      'title' : '旭丘演劇部',
      'info' : '1階 小体育館',
      'pr' : '上演するのは創作脚本「傷痕」\n父への復讐を誓う少年。そんなとき再会したのは…',
      'imgPath' : 'assets/images/bunkasai/yushidantai/演劇部.jpg'
    },
    {
      'title' : '旭丘高校麻雀愛好会',
      'info' : '3階 多目的室4 ※日曜日のみ',
      'pr' : '旭雀会です\n多目4で日曜日に開きます。\nぜひ来てください！',
      'imgPath' : 'assets/images/bunkasai/yushidantai/旭雀会.jpg'
    },
    {
      'title' : '天文部',
      'info' : '3階 地学室',
      'pr' : 'こんにちは、天文です。\nプラネタリウム公演を行います。\n最高の15分間をお届けします！\nぜひ見に来てください！！！',
      'imgPath' : 'assets/images/bunkasai/yushidantai/天文部.jpg'
    },
    {
      'title' : '吹奏楽部x書道部',
      'info' : '6日目(9月25日) 11:40~11:55 中庭',
      'pr' : '吹奏楽部と書道部によるスペシャルパフォーマンスです！！ぜひお越しください！！！',
      'imgPath' : 'assets/images/bunkasai/yushidantai/吹奏楽部×書道部.jpg'
    },
    {
      'title' : 'オークション団体',
      'info' : '',
      'pr' : 'オークション形式で物販を行います！！みなさん是非来てください！！',
      'imgPath' : 'assets/images/bunkasai/yushidantai/オークション団体.jpg'
    },
    {
      'title' : '第六十七代旭丘應援団',
      'info' : '6日目(9月25日) 12:00~12:25 中庭',
      'pr' : '二日間で十以上の型を披露します。普段あまり見られない型も。海老もグリコも舞います。',
      'imgPath' : 'assets/images/bunkasai/yushidantai/応援団.jpg'
    },
    {
      'title' : '旭美71期デザイン専攻',
      'info' : '1階 多目的室2東 ※土曜日のみ',
      'pr' : 'デザイン専攻が授業内で制作した空間デザインの展示です。',
      'imgPath' : 'assets/images/bunkasai/yushidantai/美術科71期デザイン専攻.jpg'
    },
    {
      'title' : '情報公開審議委員会',
      'info' : '1階 会議室',
      'pr' : '旭丘高校のことを在校生が紹介するコーナー！説明会だけでなく、紹介動画や生徒が作成したパンフレットなどを多数用意。',
      'imgPath' : 'assets/images/bunkasai/yushidantai/情報審議委員会.jpg'
    },
    {
      'title' : '絵画研究同好会',
      'info' : '1階 多目的室2西<土曜日> 奥中庭<日曜日>',
      'pr' : '創作に集いし精鋭たちによる作品展示です。物販もあるよ！！！',
      'imgPath' : 'assets/images/bunkasai/yushidantai/絵画研究同好会.jpg'
    },
    {
      'title' : 'ファイヤートーチ部',
      'info' : '5日目(9月24日) 11:55~12:10 中庭',
      'pr' : 'こんにちは！ファイヤートーチ部です\n公演では火を付けられませんが、カッコイイこと間違いなしなので是非見に来てください！',
      'imgPath' : 'assets/images/bunkasai/yushidantai/トーチ部.jpg'
    },
    {
      'title' : '文藝部',
      'info' : '2階 図書館',
      'pr' : 'こんにちは文藝部（図書部）です！\n部員たちが執筆した作品集『旭藝』を図書館で配布します！',
      'imgPath' : 'assets/images/bunkasai/yushidantai/文藝部.jpg'
    },
    {
      'title' : 'Futsu-no marche',
      'info' : '2階 生徒サロン西',
      'pr' : '仲の良い普通科75期のクリエイターたちが集まって、2日間限定の市場を開きます。',
      'imgPath' : 'assets/images/bunkasai/yushidantai/Futsu-no marché.jpg'
    },
    {
      'title' : 'JRC同好会',
      'info' : '1階 校売前',
      'pr' : '２４,２５日の昼ごろにあしなが募金を行います！あたたかいご寄付をお願いいたします。',
      'imgPath' : 'assets/images/bunkasai/yushidantai/JRC.jpg'
    },
  ];

}

class Bunkasai extends ConsumerWidget {
  Bunkasai({Key? key}) : super(key: key);

  final eventsInfo1 = EventsInfoData.eventsInfo1;
  final eventsInfo2 = EventsInfoData.eventsInfo2;
  final eventsInfo3 = EventsInfoData.eventsInfo3;
  final eventsInfo4 = EventsInfoData.eventsInfo4;

  final List<Tab> _tabs = const [
    Tab(text: '1年', height: 30),
    Tab(text: '2年', height: 30),
    Tab(text: '3年', height: 30),
    Tab(text: '有志団体', height: 30),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    ref.listen<List<Map<String, String>>>(
      visitedEventsProvider,
      (previous, next) {
        List<String> result = [];
        for (var e in next) {
          result.add(e['title']!);
        }
        LocalPreferences.saveSetting('visitedEvents', result);
        print('Saved setting!');
      }
    );

    return DefaultTabController(
      length: _tabs.length,
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(30).copyWith(bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '文化祭',
                            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: const [
                              Text(
                                '5日目(9月24日)\n9:00~15:00',
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(
                                  height: 50,
                                  width: 20,
                                  child: VerticalDivider()
                              ),
                              Text(
                                '6日目(9月25日)\n9:00~15:00',
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => SchedulePage(),));
                            },
                            child: const Text('スケジュールを表示', style: TextStyle(fontSize: 12),),
                          ),
                          const SizedBox(height: 20,),
                          const Text('タップして詳細を表示、長押しして訪問済みにします。\n訪問済みの発表にはチェックアイコンが付きます。'),
                          const SizedBox(height: 10),
                          OutlinedButton(
                            child: const Text('まとめて訪問済みにする', style: TextStyle(fontSize: 12),),
                            onPressed: () {
                              List<Map<String, String>> allEvents = [];
                              allEvents.addAll(eventsInfo1);
                              allEvents.addAll(eventsInfo2);
                              allEvents.addAll(eventsInfo3);
                              allEvents.addAll(eventsInfo4);

                              SelectDialog.showModal<Map<String, String>>(
                                context,
                                label: "訪問済みにするHRを選択",
                                multipleSelectedValues: ref.read(visitedEventsProvider),
                                items: allEvents,
                                itemBuilder: (context, item, isSelected) => ListTile(
                                  trailing: isSelected ? const Icon(Icons.check) : null,
                                  title: Text((item['hr'] == null ? '' : '${item['hr']} ') + item['title']!),
                                  selected: isSelected,
                                ),
                                searchBoxDecoration: const InputDecoration(
                                  hintText: '検索'
                                ),
                                okButtonBuilder: (context, onPressed) => ElevatedButton(
                                  onPressed: onPressed,
                                  child: const Text('登録'),
                                ),
                                onMultipleItemsChange: (List<Map<String, String>> selected) {
                                  ref.read(visitedEventsProvider.notifier).setState(selected.toList());
                                  print(selected);
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SliverPersistentHeader(
              floating: true,
              pinned: true,
              delegate: StickyTabBarDelegate(
                TabBar(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  indicator: OutlineIndicator(color: Theme.of(context).textTheme.bodyText1?.color?.withOpacity(.7) as Color),
                  labelColor: Theme.of(context).textTheme.bodyText1?.color,
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                  unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
                  tabs: _tabs
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            SafeArea(
              child: buildList(context, ref, eventsInfo1),
            ),
            SafeArea(
              child: buildList(context, ref, eventsInfo2),
            ),
            SafeArea(
              child: buildList(context, ref, eventsInfo3),
            ),
            SafeArea(
              child: buildList(context, ref, eventsInfo4),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildList(BuildContext context, WidgetRef ref, List<Map<String, String>> eventsInfo) {
    List<Widget> result = [];
    for(int i = 0; i < eventsInfo.length; i++) {
      result.add(buildCard(context, ref, eventsInfo[i]));
    }
    return ScrollConfiguration(
      behavior: NoEffectScrollBehavior(),
      child: Scrollbar(
        child: ListView.builder(
          itemCount: eventsInfo.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return result[index];
            // ListTile(
            //     title: Text(eventsInfo[index]['title']!),
            //     trailing: visitedSign(context, ref, isVisited)
            // );
          },
        ),
      ),
    );
  }

  Widget? visitedSign(BuildContext context, WidgetRef ref, bool isVisited) {
    if (isVisited) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check),
          Text(
            '訪問済み',
            style: TextStyle(fontSize: 10, color: Theme.of(context).iconTheme.color),
          )
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.remove, color: Theme.of(context).iconTheme.color?.withOpacity(.3)),
        ],
      );
    }
  }

  Widget buildCard(BuildContext context, WidgetRef ref, Map<String, String> eventInfo) {
    List<Map<String, String>> visitedEvents = ref.watch(visitedEventsProvider);
    bool isVisited = visitedEvents.contains(eventInfo);
    return Card(
      child: ListTile(
        leading: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(eventInfo['imgPath']!)
            )
          ),
        ),
        title: Text(
          eventInfo['title']!,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(eventInfo['info']!),
        trailing: visitedSign(context, ref, isVisited),
        onLongPress: (() {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  isVisited ? ListTile(
                    leading: const Icon(Icons.remove),
                    title: const Text('訪問済みを解除する'),
                    onTap: () {
                      ref.read(visitedEventsProvider.notifier).remove(eventInfo);
                      print(visitedEvents);
                      Navigator.pop(context);
                    },
                  )
                  : ListTile(
                    leading: const Icon(Icons.check),
                    title: const Text('訪問済みにする'),
                    onTap: () {
                      if (isVisited) {
                        Navigator.pop(context);
                        return;
                      }
                      ref.read(visitedEventsProvider.notifier).add(eventInfo);
                      print(visitedEvents);
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            },
          );
        }),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EventDetail(eventInfo: eventInfo))
          );
        },
      ),
    );
  }
}

class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  const StickyTabBarDelegate(this.tabBar);

  final TabBar tabBar;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(color: Theme.of(context).scaffoldBackgroundColor, child: tabBar);
  }

  @override
  bool shouldRebuild(StickyTabBarDelegate oldDelegate) {
    return tabBar != oldDelegate.tabBar;
  }
}

class OutlineIndicator extends Decoration {
  const OutlineIndicator({
    this.color = Colors.white,
    this.strokeWidth = 2,
    this.radius = const Radius.circular(24),
  });

  final Color color;
  final double strokeWidth;
  final Radius radius;

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _OutlinePainter(
      color: color,
      strokeWidth: strokeWidth,
      radius: radius,
      onChange: onChanged,
    );
  }
}

class _OutlinePainter extends BoxPainter {
  _OutlinePainter({
    required this.color,
    required this.strokeWidth,
    required this.radius,
    VoidCallback? onChange,
  })  : _paint = Paint()
    ..style = PaintingStyle.stroke
    ..color = color
    ..strokeWidth = strokeWidth,
        super(onChange);

  final Color color;
  final double strokeWidth;
  final Radius radius;
  final Paint _paint;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);
    var rect = offset & configuration.size!;
    var rrect = RRect.fromRectAndRadius(rect, radius);
    canvas.drawRRect(rrect, _paint);
  }
}

class NoEffectScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context,
      Widget child,
      AxisDirection axisDirection,
      ) {
    return child;
  }
}