import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kokosai_74_app/art_book/order_controller.dart';
import 'package:kokosai_74_app/user/user_controller.dart';

import '../appbar_options.dart';


class ArtBookPage extends ConsumerWidget {
  ArtBookPage({Key? key}) : super(key: key);

  final List<String> itemList = [
    '110',
    '209',
    '309'
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AltAppBar(context, '画集取り置き'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('美術科の画集の取り置きができます。\n各クラスによって取り置きのルールが違うので注意してください。'),
              const SizedBox(height: 20,),
              const Text('クラスを選択'),
              Row(
                children: [
                  SizedBox(
                    width: 120,
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: ref.watch(orderPageProvider).pageName,
                      items: itemList.map<DropdownMenuItem<String>>((String pageName) {
                        return DropdownMenuItem<String>(
                          value: pageName,
                          child: Text(pageName),
                        );
                      }).toList(),
                      onChanged: (String? pageName) {
                        if (pageName != null) {
                          ref.read(orderPageProvider.notifier).changePage(pageName);
                        }
                      }
                    ),
                  )
                ],
              ),
              const Divider(),
              const SizedBox(height: 30,),
              ref.watch(orderPageProvider),
            ],
          ),
        ),
      ),
    );
  }
}

final _inputProvider = StateProvider<String>((ref) => '1');

class OrderPage extends ConsumerWidget {
  OrderPage(this.pageName, {Key? key}) : super(key: key);

  final String pageName;

  final _formKey = GlobalKey<FormState>();

  final Map<String, Map<String, dynamic>> _pageDataList = {
    '110': {
      'hr': '110',
      'comment': '110レジまで1冊450円現金で持ってきてください。\nその際にHR、クラス番号も伝えるようにしてください。',
      'price': '450円',
      'place': '3階110教室 レジ',
      'period': '24・25日',
      'maxOrder': 2,
    },
    '209': {
      'hr': '209',
      'comment': '209に来て物販のスペースにいる人にHR番号と自分の出席番号を伝えてください。そこでお金の支払いをします。',
      'price': '500円',
      'place': '3階209教室',
      'period': '24・25日',
      'maxOrder': 20,
    },
    '309': {
      'hr': '309',
      'comment': '309の画集レジにお金を持ってきて、そこでHR番号とクラス番号を伝えて受け取ってください。Twitterやインスタなどで既に取り置きした人は重複して取り置きしないようお願いします。',
      'price': '500円',
      'place': '4階309教室 画集レジ',
      'period': '25日の午前中まで',
      'maxOrder': 5,
    },
  };

  order(BuildContext context, WidgetRef ref, String artBookName, int orderCount) async {
    try {
      print('OrderPage.order(): 1');
      showDialog(
        barrierDismissible: false,
        context: context, 
        builder: (context) => WillPopScope(
          onWillPop: () async => false,
          child: const Center(child: CircularProgressIndicator()),
        ),
      );
      print('OrderPage.order(): 2');
      await ref.watch(orderControllerProvider.notifier).order(artBookName, orderCount);
      print('OrderPage.order(): 3');
      Navigator.pop(context);
      Navigator.pop(context);
      print('OrderPage.order(): 4');
      showDialog(context: context, builder: (context) => AlertDialog(
        content: const Text('取り置きに成功しました。'),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context), 
            child: const Text('戻る'),
          )
        ],
      ),);
      print('OrderPage.order(): 5');
    } catch (e) {
      print(e);
      switch (e) {
        case 'NotOrderable':
          Navigator.pop(context);
          Navigator.pop(context);
          showDialog(context: context, builder: (context) => AlertDialog(
            content: const Text('画集の取り置きは終了したか、現在受け付けておりません。\n文化祭当日に並んでお買い求めください。'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context), 
                child: const Text('戻る'),
              )
            ],
          ),);
          break;
        case 'OrderAlreadyExists':
          Navigator.pop(context);
          Navigator.pop(context);
          showDialog(context: context, builder: (context) => AlertDialog(
            content: const Text('この画集はすでに取り置き済みです。'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context), 
                child: const Text('戻る'),
              )
            ],
          ),);
          break;
        case 'UserDocNotExisted':
          Navigator.pop(context);
          Navigator.pop(context);
          showDialog(context: context, builder: (context) => AlertDialog(
            content: const Text('申し訳ございません。現在のステータスで取り置きするには再度ログインする必要があります。'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context), 
                child: const Text('戻る'),
              )
            ],
          ),);
          break;
        case 'UserNotLoggedIn':
          Navigator.pop(context);
          Navigator.pop(context);
          showDialog(context: context, builder: (context) => AlertDialog(
            content: const Text('取り置きを行うにはログインしてください。'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context), 
                child: const Text('戻る'),
              )
            ],
          ),);
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isOrderAlreadyExists = ref.watch(orderControllerProvider)[pageName] != null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(_pageDataList[pageName]!['hr'], style: Theme.of(context).textTheme.headline4,),
        const SizedBox(height: 15,),
        Text(_pageDataList[pageName]!['comment']),
        const SizedBox(height: 20,),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: Theme.of(context).textTheme.bodyText1!.color!,
              width: .5
            )
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('価格：${_pageDataList[pageName]!['price']}'),
                Text('受け取り場所：${_pageDataList[pageName]!['place']}'),
                Text('受け取り日時：${_pageDataList[pageName]!['period']}'),
              ],
            ),
          )
        ),
        const SizedBox(height: 50,),
        Text('取り置きする', style: Theme.of(context).textTheme.headline6,),
        const SizedBox(height: 20,),
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width - 180,
              child: Form(
                key: _formKey,
                child: TextFormField(
                  enabled: !isOrderAlreadyExists,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.local_mall),
                    labelText: '取り置き冊数',
                    hintText: '冊数を入力してください'
                  ),
                  initialValue: ref.watch(_inputProvider),
                  keyboardType: TextInputType.number,
                  validator: (String? value) {
                    return (value != null && int.parse(value) > _pageDataList[pageName]!['maxOrder']) ? '$pageNameの画集は${_pageDataList[pageName]!['maxOrder']}冊まで取り置きできます。' : null;
                  },
                  onChanged: (value) {
                    ref.read(_inputProvider.notifier).update((state) => value);
                  },
                ),
              ),
            ),
            const SizedBox(width: 40,),
            ElevatedButton(
              onPressed: !isOrderAlreadyExists ? () {
                if (_formKey.currentState!.validate()) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('確認'),
                      content: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('以下のステータスで画集を取り置きします。よろしいですか？'),
                            Text('\n・あなたのHR: ${ref.watch(userControllerProvider)?['hr']}\n・画集: $pageName\n・冊数: ${ref.read(_inputProvider)}冊'),
                            Text('\n※取り置きをキャンセルするには受取場所でその旨を伝える必要があります。\n※取り置きは各画集について一回までしかできません。\n※冊数の変更はできません。', style: TextStyle(color: Theme.of(context).errorColor,),),
                          ],
                        ),
                      ),
                      actions: [
                        OutlinedButton(onPressed: () => Navigator.pop(context), child: const Text('いいえ')),
                        ElevatedButton(onPressed: () => order(context, ref, pageName, int.parse(ref.read(_inputProvider))), child: const Text('はい')),
                      ],
                    ),
                  );
                }
              } : null,

              child: const Text('送信')
            )
          ],
        ),
        if (isOrderAlreadyExists) Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20,),
            Text('$pageName の画集は既に取り置き済みです。', style: Theme.of(context).textTheme.subtitle1,),
            const SizedBox(height: 10,),
            Text('あなたのHR: ${ref.watch(userControllerProvider)?['hr']}'),
            Text('画集: $pageName'),
            Text('冊数: ${ref.watch(_inputProvider)} 冊'),
          ],
        ),
        const SizedBox(height: 30,),
        Text('※取り置きをキャンセルするには受取場所でその旨を伝える必要があります。\n※取り置きは各画集について一回までしかできません。\n※冊数の変更はできません。', style: TextStyle(color: Theme.of(context).errorColor),),
      ],
    );
  }
}

class OrderPagesNotifier extends StateNotifier<OrderPage> {
  OrderPagesNotifier(): super(OrderPage('110'));

  void changePage(String pageName) {
    state = OrderPage(pageName);
  }
}

final orderPageProvider = StateNotifierProvider<OrderPagesNotifier, OrderPage>((ref) {
  return OrderPagesNotifier();
});