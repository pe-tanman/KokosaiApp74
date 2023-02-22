import 'package:flutter/material.dart';

class RequestLogin extends StatelessWidget {
  const RequestLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FittedBox(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text('文化祭以外のページを利用するにはログインしてください。'),
              TextButton(
                child: const Text('ログイン'),
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
