import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../appbar_options.dart';


final isLoadingTermsOfServicePageProvider = StateProvider<bool>((ref) => false);

class TermsOfService extends ConsumerStatefulWidget {
  const TermsOfService({Key? key}) : super(key: key);

  @override
  _TermsOfServiceState createState() => _TermsOfServiceState();
}

class _TermsOfServiceState extends ConsumerState<TermsOfService> {
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
              initialUrl: 'https://app74.kokosai.jp/termsofservice',
              javascriptMode: JavascriptMode.unrestricted,
              onPageStarted: (String url) {
                ref.read(isLoadingTermsOfServicePageProvider.notifier).update((state) => true);
              },
              onPageFinished: (String utl) {
                ref.read(isLoadingTermsOfServicePageProvider.notifier).update((state) => false);
              },
            ),
            if (ref.watch(isLoadingTermsOfServicePageProvider)) Container(
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