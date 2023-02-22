import 'package:flutter/material.dart';

import 'bunkasai.dart';
import 'event_detail.dart';

class Bunkakai extends StatelessWidget {
  Bunkakai({Key? key}) : super(key: key);

  final List<Map<String, String>> eventsInfo1F = [
    {
      'title': '旭生のための朗読講座',
      'info' : '多目的室1',
      'altInfo' : '筆記用具、飲み物（水分補給のため）',
      'pr': '滑舌がよくなりたい方、思いっきり叫んでストレス発散したい方、もちろん朗読に興味がある方、お待ちしております！！'
    },
    {
      'title': 'サッカーやろうぜ！',
      'info' : '運動場',
      'altInfo' : 'タオル、水筒、運動できる服装、運動靴、帽子など(任意)',
      'pr': 'サッカーやろうぜ！(少雨決行、雨天中止)'
    },
  ];
  final List<Map<String, String>> eventsInfo2F = [
    {
      'title': 'きっとあなたも⾷べたくなる！シュークリームから始めるスイーツ講座',
      'info' : '101教室',
      'pr': 'シュークリーム（をはじめとするスイーツ）、好きですか？⼤好きですよね…?（圧）シュークリーム（その他のスイーツ）が⼤好きだというそんな皆さんですが、もっとスイーツを好きになって、美味しく⾷べれたら嬉しいと思いませんか…？ '
    },
    {
      'title': '音ゲーのトリセツ ～なぜプロセカはこれほど難しいのか?～',
      'info' : '102教室',
      'altInfo' : '(必須)何かしら音ゲーが入ったスマホやタブレット(十分に充電した状態で)、指の筋力、やる気!!!\n(推奨)イヤホン、滑り止め',
      'pr': 'どんどん難化していると言われる(スマホ系)音ゲーについて徹底解説します!!(東方もあるよ!)\n※音ゲーの経験・多少の音楽の知識(音符の名称やテンポなど)が必要です'
    },
    {
      'title': 'トマト愛者のトマト愛者によるトマト愛者のためのトマト講座♡',
      'info' : '103教室',
      'altInfo' : 'スマホ、トマトに対する意見（好きor嫌い、またその理由）',
      'pr': 'トマトが大好きなそこのあなた!!トマトが大嫌いなそこのあなた!!\nトマト大佐が語るトマトまみれのトマト講座を受けて、トマトへの愛と知識を深堀りしませんか？？\n講座が終わったときにはトマトを食べたくてしかたがない状態にさせてみせます!!!'
    },
    {
      'title': 'ポーカーを広めたい！！',
      'info' : '104教室',
      'altInfo' : 'スマホ',
      'pr': '僕が愛してやまない！誰にでもできるゲーム。ポーカーについて語ります'
    },
    {
      'title': '犯罪心理学の入門',
      'info' : '105教室',
      'altInfo' : '筆記用具、ノートがあればなおよし',
      'pr': 'れっきとした学問なのに、知っている人がとても少ない犯罪心理学。今回は誰にでも分かるような大事な内容だけをぎゅっとまとめてみました。「犯罪心理学って？」という人、必見。'
    },
    {
      'title': 'マイナーな乗り物博覧会',
      'info' : '106教室',
      'altInfo' : '筆記用具、とても興味がある人はノートがあるといいです。',
      'pr': 'マイナーな乗り物博覧会へようこそ。この講座では文字通り変な乗り物たちをたくさんご紹介！興味があってもなくても大歓迎！（非常にコアな内容を扱うのでヲタク民も必見！！昭和初期〜現在までに活躍した（？）乗り物をご紹介します！）'
    },
    {
      'title': '“鉄道旅”のススメ',
      'info' : '107教室',
      'altInfo' : '筆記用具、スマホ',
      'pr': '皆さん、鉄道は単なる移動手段だと思っていませんか？実は、鉄道には色んな楽しみ方があるんです。それらを知って、世界に一つだけの｢my鉄道旅｣を計画してみましょう！'
    },
    {
      'title': '麻雀は旭丘の沼',
      'info' : '108教室',
      'pr': '麻雀はルールが複雑だと思われているけれど、やっていることは意外と単純！40分あればできるようになります。座学ではなく、実際に牌を使って遊びながら説明します。麻雀をやったことがある人もない人も来てください！みんなで卓を囲めば楽しいよ～(-ω☆)キラリ'
    },
    {
      'title': 'シンガポール⼊⾨',
      'info' : '109教室',
      'altInfo' : '筆記用具',
      'pr': 'シンガポールについての様々なこと‧ものを、シンガポールの歴史を軸として、広く深く教えます！\nシンガポールに行ったことあるよって人はもちろん、コロナ明けに旅行したいという人はぜひ！！'
    },
    {
      'title': '令和のクソゲー',
      'info' : '110教室',
      'pr': '講師がクソゲーを購入してプレイした感想を適当に喋るだけなので、初心者でも大歓迎です。自分は無料のスマホクソゲーが大嫌いなので、紹介するものは全てスイッチのソフトになります。現在6/30時点でクソゲーに使って1万五千円ほど財布から消えたので安心してください。'
    },
    {
      'title': '非リアの非リアによる人民のための恋愛観',
      'info' : '視聴覚室',
      'pr': '彼女のいない男が、自分の恋愛観を語る。（109会長）'
    },
  ];
  final List<Map<String, String>> eventsInfo3F = [
    {
      'title': '夏隣愁のわくわく作曲講座～(●´▽`●)э',
      'info' : '201教室',
      'altInfo' : 'メモできるものと写真を撮れるもの。スマホでよい。',
      'pr': '昨年の鯱光祭期間中にひっそりとデビューしていたボカロP、夏隣愁による作曲講座です。作曲活動の第一歩目を後押しするような初心者向け講座を目指しています。音楽経験のない方でも大歓迎です。小難しい音楽理論などは取り扱わないので気軽にご参加ください(●´▽`●)э'
    },
    {
      'title': 'TRPGのすゝめ',
      'info' : '202教室',
      'altInfo' : 'スマホ',
      'pr': 'TRPG(Table Talk Role-Playing Game)の紹介です。TRPGの存在自体は知っているけど、まだやったことがない人や、どのルールブックを買ったらいいか分からない人向けです。主にクトゥルフ、それ以外にはシノビガミ・おまじな・パラノイアetc.です。ピンと来た人は是非！'
    },
    {
      'title': '町長？蝶々！超入門！！！！哲学講座',
      'info' : '203教室',
      'altInfo' : '必要であれば筆記用具(”探究し続ける姿勢”は忘れずに！)',
      'pr': '太平洋は沈んだ、星は爆ぜた、(初心者による、初心者のための、超入門哲学講座です。)\n一瞥もくれずに、蝶は舞ってみせる。(2,3年生の方には物足りなく感じるかもしれませんが)\n私は、蝶になりたかった。(講座の後半には歯に衣着せぬ議論を行います､一緒に楽しみましょう!)'
    },
    {
      'title': 'S.E.A.はSociety of Explorers and Adventuresの略です',
      'info' : '204教室',
      'pr': 'タワーオブテラーで何が起きたのか、センターオブジアースで私たちはなぜ落とされるのか。その謎を解明すべく私たちはアマゾンの奥地へと……\nディズニーでの待ち時間が退屈なあなたに。\nアトラクション、だけじゃない！！新しいディズニーの楽しみ方をお伝えします！！！'
    },
    {
      'title': '天地創造 ～ゲームと世界観の創り方を語る～',
      'info' : '地学室',
      'altInfo' : '筆記用具、メモ用紙',
      'pr': '講師自身がゲームを創っていく中で気付いたことや、参考にした考え方などをまとめ、 なるべくわかりやすく教える講座です！ ゲームプログラマー志望の方もそうでない方も、 興味があればぜひご参加ください！あなたもゲームを「創る側」に回ってみませんか？'
    },
    {
      'title': '現代アート',
      'info' : '205教室',
      'pr': '現代アートとは何か。'
    },
    {
      'title': 'アメリカの銃社会について考えてみたい！',
      'info' : '206教室',
      'altInfo' : '筆記用具',
      'pr': 'アメリカの銃社会について講義します！銃社会の歴史や、銃に対する考えを多角的に知ってもらいたいです。アメリカ社会に興味のある方や、平和について考えたい方にオススメです〜(*^^*)'
    },
    {
      'title': '三角関数',
      'info' : '化学室',
      'altInfo' : '筆記用具',
      'pr': '三角関数に関する発展的な内容や面白い性質等を紹介します！基礎的な三角関数に関する知識を要求します(2年生以上が好ましい)。数学好きの方はぜひ。'
    },
    {
      'title': '知れば旅行が楽しくなる切符の話',
      'info' : '207教室',
      'pr': '旅行は楽しい！けど、困りがちなのが切符。そもそもどうやって買うの？もっと安くするには？電車が遅延したらどうすれば？…など、切符の「ルール」を元・鉄道研究部部長が分かりやすくお話しします！ 旅行が好きな人、秋冬に旅行に行く人、是非来て下さい'
    },
    {
      'title': '【天才】サワヤンの“ツ感”を徹底分析した結果がやばすぎるwwwwwwwwwww',
      'info' : '208教室',
      'altInfo' : '筆記用具',
      'pr': '入試において頻出だが、対策が後回しとされがちである“ツ感”を、人気講師の丁寧な解説と網羅性の高い参考書を用いて短期間で完成させられる講座です。'
    },
    {
      'title': '競馬について',
      'info' : '209教室',
      'pr': '競馬の魅力、楽しみ方などの解説を行います。 競馬をあまり知らなくても問題ありません。'
    },
  ];
  final List<Map<String, String>> eventsInfo4F = [
    {
      'title': '競プロ入門講座　～情報徒への道～',
      'info' : '302教室',
      'altInfo' : '筆記用具、紙',
      'pr': 'これからAIの発達で人間の仕事がどんどん奪われて最後にはターミネーターの世界みたいになってしまうのではないかと不安で仕方ないあなた！競プロを学び，情報徒となろう！'
    },
    {
      'title': '五等分の花嫁 〜私の「愛」を探し求めて〜',
      'info' : '303教室',
      'pr': '「五等分の花嫁」をさらに、もう一度、5000‰楽しむための講座です！\n色々な伏線、考察など、隠された魅力を深掘りし、作品の良さを語ります！\n⚠️アニメと映画をみたor漫画を全巻読んだ方のみご参加ください (花嫁知っている人なら可)'
    },
    {
      'title': 'あのバンド、なんか変わっちゃったよね',
      'info' : '304教室',
      'pr': '変化は進化か退化か。生半可な気持ちで愛してない。超絶スーパー愛してる！のに、バンドの 変化に「ジャンプ漫画で推しが死ぬ」みたいなそれを味わわされる同志達、ここに集え！'
    },
    {
      'title': '哲学思想講座',
      'info' : '305教室',
      'altInfo' : '筆記用具',
      'pr': '倫理政経・公共の授業ではあまり触れられることのない思想を中心に、様々な哲学思想についてお話しします。講師の偏った思想をなるべく押し付けないよう頑張ります'
    },
    {
      'title': '雨の日の午後、カフェで小説を書きたい。',
      'info' : '306教室',
      'altInfo' : '筆記用具',
      'pr': '拙いながらも書き手である私の主観と、読み手である私の客観から。\n小説の書き方に関する持論を展開します。小説を書くことの楽しさを知ってほしい。'
    },
    {
      'title': 'お抹茶仲間を増やしたいの会（切実）',
      'info' : '307教室',
      'altInfo' : '水洗いした空のペットボトル2本（2本とも500ml以下の大きさが好ましい）',
      'pr': '「抹茶は美味しくない」だとか、「抹茶はお金がかかる」だとか、「茶道は堅苦しい」だとか思っている方もそうでない方も全員この講座を聞いてください！！自宅で簡単にできる抹茶の飲み方も紹介します！！！実際に作ってみたりもします！！！！！！！！'
    },
    {
      'title': '範馬勇次郎に学ぶ地上最強の生物育成論',
      'info' : '308教室',
      'pr': '強くなりたくばこの講義を喰らえ!!!'
    },
    {
      'title': 'スタンブルガイズ講座＆大会',
      'info' : '309教室',
      'altInfo' : 'スタンブルガイズができる端末（スマホ、タブレットなど）',
      'pr': '新感覚大人気ゲーム　スタンブルガイズ！これであなたも一流スタンブラー？\n現役全国ランカーが勝ち方を解説！'
    },
    {
      'title': 'おじさん構文の作り方/愛と金、どっちが勝つ？',
      'info' : '階段教室',
      'pr': '(前半)おじさん😁👍構文とは、メッセージアプリ📨で使われる中年男性😱💦特有‼️の言い回しのことデス‼️☺️これを機に君👧📛も‼️おじさん😁👍構文を理解💕して、おじさん😁👍になりきってみないカナ⁉️⁉️ナンチャッテ😅💦  // （後半）こちらでは愛、金、そして人生を絡めてお話を展開していきます！ほんのちょっと哲学に足を踏み入れてみませんか？'
    },
  ];

  final List<Tab> _tabs = const [
    Tab(text: '1階', height: 30),
    Tab(text: '2階', height: 30),
    Tab(text: '3階', height: 30),
    Tab(text: '4階', height: 30),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    width: double.infinity,
                    height: 200,
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            '分科会',
                            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '3日目(9月22日)\n13:10~15:00',
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            '前半：13:30~14:10｜後半：14:20~15:00',
                            style: TextStyle(fontSize: 15),
                          )
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
                  // unselectedLabelColor: Theme.of(context).textTheme.bodyText1?.color?.withOpacity(.3),
                  // unselectedLabelStyle: const TextStyle(fontSize: 12.0, fontFamily: ('Noto Sans JP')),
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
              child: buildList(context, eventsInfo1F),
            ),
            SafeArea(
              child: buildList(context, eventsInfo2F),
            ),
            SafeArea(
              child: buildList(context, eventsInfo3F),
            ),
            SafeArea(
              child: buildList(context, eventsInfo4F),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildList(BuildContext context, List<Map<String, String>> eventsInfo) {
    List<Widget> result = [];
    for(int i = 0; i < eventsInfo.length; i++) {
      result.add(buildCard(context, eventsInfo[i]));
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
          },
        ),
      ),
    );
  }

  Widget buildCard(BuildContext context, Map<String?, String> eventInfo) {
    return Card(
      child: ListTile(
        title: Text(
          eventInfo['title']!,
          style: const TextStyle(fontWeight: FontWeight.bold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          '${eventInfo['info']!}  ${eventInfo['altInfo'] ?? ''}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EventDetail(eventInfo: eventInfo)));
        },
      ),
    );
  }
}