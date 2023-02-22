import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kokosai_74_app/appbar_options.dart';
import 'package:webview_flutter/webview_flutter.dart';


final isLoadingBugReportPageProvider = StateProvider<bool>((ref) => false);


class BugReportPage extends ConsumerStatefulWidget {
  const BugReportPage({Key? key}) : super(key: key);

  @override
  _BugReportPageState createState() => _BugReportPageState();
}

class _BugReportPageState extends ConsumerState<BugReportPage> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AltAppBar(context, '第74回鯱光祭'),
      body: Stack(
        children: [
          WebView(
            initialUrl: 'https://docs.google.com/forms/d/e/1FAIpQLSe1gaBe5oPKPoGzfQvua_yH5Jbb2SKLvXGGMNrXaFEENy_Nlg/viewform?usp=sf_link',
            javascriptMode: JavascriptMode.unrestricted,
            onPageStarted: (String url) {
              ref.read(isLoadingBugReportPageProvider.notifier).update((state) => true);
            },
            onPageFinished: (String utl) {
              ref.read(isLoadingBugReportPageProvider.notifier).update((state) => false);
            },
          ),
          if (ref.watch(isLoadingBugReportPageProvider)) Container(
            height: double.infinity,
            width: double.infinity,
            color: Theme.of(context).scaffoldBackgroundColor,
            child: const Center(child: CircularProgressIndicator(),)
          )
        ],
      )
    );
  }
}
