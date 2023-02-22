import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

import 'appbar_options.dart';

class MyPdfPage extends StatefulWidget {
  const MyPdfPage({Key? key, required this.title, required this.pdfPinchController}) : super(key: key);
  final String title;
  final PdfControllerPinch pdfPinchController;

  @override
  _MyPdfPageState createState() => _MyPdfPageState();
}

class _MyPdfPageState extends State<MyPdfPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AltAppBar(context, widget.title),
      body: PdfViewPinch(
        controller: widget.pdfPinchController,
        builders: const PdfViewPinchBuilders<DefaultBuilderOptions>(
          options: DefaultBuilderOptions(
            loaderSwitchDuration: Duration(milliseconds: 300)
          )
        ),
      ),
    );
  }
}