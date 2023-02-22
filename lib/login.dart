import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kokosai_74_app/appbar_options.dart';
import 'package:kokosai_74_app/auth/auth_controller.dart';
import 'package:kokosai_74_app/main.dart';

final _inputHrNumber = StateProvider((ref) => '');
final _inputAuthId = StateProvider((ref) => '');
final _infoTextProvider = StateProvider.autoDispose((ref) => '');
final _isObscureTextEnabled = StateProvider.autoDispose((ref) => true);

class LoginLogic {
  final Reader _read;
  LoginLogic(this._read);

  Future<bool> tryLogin(WidgetRef ref) async {
    try {
      ref.read(_infoTextProvider.notifier).update((state) => '');
      if (!_verifyInput()) {
        _setInfoText(ref, '全てのフィールドを入力してください');
        return false;
      }
      final loginIdsDoc = _read(firebaseDBProvider)
          .collection('loginIds')
          .doc(_read(_inputHrNumber));
      final loginIdsDocSnapshot = await loginIdsDoc.get();
      if (!loginIdsDocSnapshot.exists) {
        _setInfoText(ref, '不正なHR番号です');
        return false;
      }
      final loginIdsDocData = loginIdsDocSnapshot.data();
      if (_read(_inputAuthId) == loginIdsDocData!['authId']) {
        if (!(await _tryProcessWhenSuccess())) {
          _setInfoText(ref, 'ログインに失敗しました');
          return false;
        }
        return true;
      } else {
        _setInfoText(ref, 'HR番号または認証IDが間違っています');
        return false;
      }
    } catch (e) {
      _setInfoText(ref, 'ログインに失敗しました1');
      return false;
    }
  }

  Future<bool> _tryProcessWhenSuccess() async {
    try {
      await _read(authControllerProvider.notifier).signIn();
      print('stack: Signed in');
      final User user = _read(firebaseAuthProvider).currentUser!;
      print('stack: Got user');
      final userDoc =
          _read(firebaseDBProvider).collection('users').doc(user.uid);
      print('stack: Got reference');
      final userDocSnapshot = await userDoc.get();
      print('stack: Got userDoc');
      if (!userDocSnapshot.exists) {
        await userDoc.set({
          'hr': _read(_inputHrNumber),
          'userId': user.uid,
          'createdAt': FieldValue.serverTimestamp(),
        });
        print('stack: Set doc');
      }
      return true;
    } catch (e) {
      print('stack: error: $e');
      return false;
    }
  }

  bool _verifyInput() {
    if (_read(_inputHrNumber) == '' || _read(_inputAuthId) == '') {
      return false;
    }
    return true;
  }

  void _setInfoText(WidgetRef ref, String errorMsg) =>
      ref.read(_infoTextProvider.notifier).update((state) => 'ログインに失敗しました');
}

class LoginPage extends ConsumerWidget {
  const LoginPage({Key? key}) : super(key: key);

  void _whenSuccess(BuildContext context) {
    showDialog(
        context: context,
        builder: (childContext) => AlertDialog(
              title: const Text('ログイン成功'),
              content: const Text('ログインに成功しました。'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.popUntil(context, ModalRoute.withName('/home'));
                  },
                  child: const Text('最初の画面に戻る'),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AltAppBar(context, 'ログイン'),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                child: Text(
                  '外部の方やOB・OGの方はログインせずにご利用いただけます。\n在校生の方はログインしてください。',
                  style: Theme.of(context).textTheme.bodyText2,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(labelText: 'HR番号(例：20618)'),
                onChanged: (String value) {
                  ref.read(_inputHrNumber.notifier).update((state) => value);
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: '認証ID(6桁の英数字)',
                    suffixIcon: IconButton(
                      icon: Icon(ref.watch(_isObscureTextEnabled)
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        ref
                            .watch(_isObscureTextEnabled.notifier)
                            .update((state) => state ? false : true);
                      },
                    )),
                obscureText: ref.watch(_isObscureTextEnabled),
                onChanged: (String value) {
                  ref.read(_inputAuthId.notifier).update((state) => value);
                },
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: Text(
                  ref.watch(_infoTextProvider),
                  style: TextStyle(
                      fontSize: 14, color: Theme.of(context).errorColor),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: const Text('ログイン'),
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                      barrierDismissible: false,
                    );
                    if (await LoginLogic(ref.read).tryLogin(ref)) {
                      Navigator.pop(context);
                      _whenSuccess(context);
                    } else {
                      Navigator.pop(context);
                    }
                  },
                ),
              ),
              TextButton(
                child: FittedBox(
                  child: Opacity(
                    opacity: .5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.help,
                          color: Theme.of(context).textTheme.bodyText1?.color,
                          size: 12,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          '認証IDとは？',
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText1?.color,
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (childContext) => AlertDialog(
                            title: const Text('認証IDとは？'),
                            content: const Text(
                                '旭丘の在校生一人一人に当てられた6桁の英数字です。\n案内の場所に貼られた表で確認することができます。'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('閉じる'),
                              )
                            ],
                          ));
                },
              ),
              TextButton(
                child: FittedBox(
                  child: Opacity(
                    opacity: .5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.help,
                          color: Theme.of(context).textTheme.bodyText1?.color,
                          size: 12,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          'ログインできませんか？',
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText1?.color,
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (childContext) => AlertDialog(
                            title: const Text('ログインできませんか？'),
                            content: const Text(
                                '大文字の「i」と小文字の「L」の間違いに注意してください。\n解決しない場合はホーム→誤植・バグ報告フォームから報告お願いします。'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('閉じる'),
                              )
                            ],
                          ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
