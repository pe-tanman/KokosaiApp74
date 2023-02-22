import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kokosai_74_app/user/user_controller.dart';

import '../appbar_options.dart';

final testProvider = StateProvider((ref) => 'tile');

class Debug extends ConsumerWidget {
  Debug({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String uid = ref.watch(userControllerProvider)?.toString() ?? 'null';
    return Scaffold(appBar: AltAppBar(context, 'デバッグ'), body: Text(uid));
  }
  // ElevatedButton(
  //   onPressed: () {
  //     for(int i = 0; i < getLengthOfStudents(); i++) {  // 1 => getLengthOfStudents()
  //       FirebaseFirestore.instance.collection('loginIds').doc(getHrNumber(i).toString()).set(createUserData(i));
  //     }
  //     print('Process was completed');
  //   },
  //   child: const Text('createUserCorrectionOnFirebase')
  // ),
  // ElevatedButton(
  //   onPressed: () async {
  //     await FirebaseAuth.instance.signOut();
  //     print('Process was completed');
  //   },
  //   child: const Text('signOut')
  // ),

  Map<String, dynamic> createUserData(int index) {
    Map<String, dynamic> userData = {};
    userData = {'authId': getRandomString(), 'hr': getHrNumber(index)};
    return userData;
  }

  final List<int> hrClasses = [
    101,
    102,
    103,
    104,
    105,
    106,
    107,
    108,
    109,
    110,
    201,
    202,
    203,
    204,
    205,
    206,
    207,
    208,
    209,
    301,
    302,
    303,
    304,
    305,
    306,
    307,
    308,
    309
  ];
  final List<int> hrClassesWith41Member = [102, 106, 108];
  final List<int> hrClassesWith39Member = [204, 302, 304];
  final List<int> hrClassesWith38Member = [309];

  String getRandomString() {
    const int length = 6;
    const String chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return String.fromCharCodes(Iterable.generate(length,
        (_) => chars.codeUnitAt(Random.secure().nextInt(chars.length))));
  }

  int getHrNumber(int index) {
    int result = 0;

    int number = 0;
    for (int i = 0; i < hrClasses.length; i++) {
      number += getLengthOfClassMembers(i);
      if (number > index) {
        result = int.parse(hrClasses[i].toString() +
            ((index + 1) - (number - getLengthOfClassMembers(i)))
                .toString()
                .padLeft(2, '0'));
        break;
      }
    }
    return result;
  }

  int getLengthOfClassMembers(int classInt) {
    if (hrClassesWith41Member.contains(hrClasses[classInt])) {
      return 41;
    } else if (hrClassesWith39Member.contains(hrClasses[classInt])) {
      return 39;
    } else if (hrClassesWith38Member.contains(hrClasses[classInt])) {
      return 38;
    } else {
      return 40;
    }
  }

  int getLengthOfStudents() {
    int result = 0;
    result = hrClassesWith38Member.length * 38 +
        hrClassesWith39Member.length * 39 +
        hrClassesWith41Member.length * 41 +
        (hrClasses.length -
                hrClassesWith38Member.length -
                hrClassesWith39Member.length -
                hrClassesWith41Member.length) *
            40;
    return result;
  }
}
