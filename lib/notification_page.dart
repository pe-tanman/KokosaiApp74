import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kokosai_74_app/appbar_options.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key, this.title, this.content, this.createdAt}) : super(key: key);

  final String? title;
  final String? content;
  final String? createdAt;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AltAppBar(context, '通知詳細'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title ?? '', style: Theme.of(context).textTheme.headline5,),
            const SizedBox(height: 10,),
            Text(createdAt ?? '', style: Theme.of(context).textTheme.subtitle2,),
            const SizedBox(height: 10,),
            Text(content?.replaceAll('\\n', '\n') ?? '' , style: Theme.of(context).textTheme.bodyText1,)
          ],
        ),
      ),
    );
  }
}
