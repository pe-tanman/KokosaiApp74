import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../appbar_options.dart';

class Credit extends StatelessWidget {
  Credit({Key? key}) : super(key: key);

  final Widget html = Html(
    data: '''
    <div>
      <h3>PRODUCER:</h3>
      <p>© 2022 Kokosai Application Division</p>
    </div>
    '''
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AltAppBar(context, 'クレジット'),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: html
          ),
        ),
      ),
    );
  }
}