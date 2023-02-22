import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../appbar_options.dart';


final isLoadingPrivacyPolicyPageProvider = StateProvider<bool>((ref) => false);

class PrivacyPolicy extends ConsumerStatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends ConsumerState<PrivacyPolicy> {
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
              initialUrl: 'https://app74.kokosai.jp/privacypolicy',
              javascriptMode: JavascriptMode.unrestricted,
              onPageStarted: (String url) {
                ref.read(isLoadingPrivacyPolicyPageProvider.notifier).update((state) => true);
              },
              onPageFinished: (String utl) {
                ref.read(isLoadingPrivacyPolicyPageProvider.notifier).update((state) => false);
              },
            ),
            if (ref.watch(isLoadingPrivacyPolicyPageProvider)) Container(
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