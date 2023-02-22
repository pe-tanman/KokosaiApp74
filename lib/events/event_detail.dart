import 'package:flutter/material.dart';
import 'package:kokosai_74_app/appbar_options.dart';

class EventDetail extends StatelessWidget {
  const EventDetail({Key? key, required this.eventInfo}) : super(key: key);
  final Map<String?, String> eventInfo;

  @override
  Widget build(BuildContext context) {
    String imgPath = eventInfo['imgPath'] ?? '';
    String? title = eventInfo['title'] ?? '';
    String? pr = eventInfo['pr'] ?? '';
    String? info = eventInfo['info'] ?? '';
    String? altInfo = eventInfo['altInfo'] ?? '';

    return Scaffold(
      appBar: AltAppBar(context, 'イベント詳細'),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(imgPath != '') GestureDetector(
                  onTap: () {
                    showGeneralDialog(
                      barrierColor: Colors.black.withOpacity(0.7),
                      barrierDismissible: true,
                      barrierLabel: '',
                      context: context,
                      pageBuilder: (context, animation1, animation2) {
                        return SafeArea(
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: InteractiveViewer(
                                      minScale: 0.1,
                                      maxScale: 5,
                                      child: Image.asset(imgPath),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Material(
                                    color: Colors.transparent,
                                    child: IconButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      icon: const Icon(
                                        Icons.close,
                                        size: 30,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15))
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.asset(imgPath),
                  ),
                ),
                if(imgPath != '') Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Text('※タップで画像をプレビューします。', style: TextStyle(fontSize: 12),),
                  ],
                ),
                if(imgPath != '') const SizedBox(height: 10,),
                if(title != '') Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                if(title != '') const SizedBox(height: 8,),
                if(info != '') Text(info, style: const TextStyle(fontSize: 15),),
                if(info != '' && altInfo != '') const SizedBox(height: 4,),
                if(altInfo != '') Text(altInfo, style: const TextStyle(fontSize: 15),),
                if(!(info == '' && altInfo == '')) const SizedBox(height: 15,),
                if(pr != '') Text(pr, style: const TextStyle(fontSize: 14),),
              ],
            ),
          )
        ],
      ),
    );
  }
}