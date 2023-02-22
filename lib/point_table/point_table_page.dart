import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kokosai_74_app/appbar_options.dart';
import 'package:kokosai_74_app/point_table/point_table_manage_page.dart';

class PointTablePage extends ConsumerWidget {
  const PointTablePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AltAppBar(context, '体育祭得点表',),
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            const Text('9月21日の体育祭中、ここで紅組、白組それぞれの得点を確認することができます。'),
            const SizedBox(height: 30,),
            ListTile(
              leading: const Text('紅組: '),
              title: Text('${ref.watch(pointTableProvider)['red']}', style: Theme.of(context).textTheme.subtitle1,),
            ),
            ListTile(
              leading: const Text('白組: '),
              title: Text('${ref.watch(pointTableProvider)['white']}', style: Theme.of(context).textTheme.subtitle1,),
            )
          ],
        ),
      ),
    );
  }
}
