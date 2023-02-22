import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kokosai_74_app/splash_screen.dart';
import 'package:kokosai_74_app/user/user_controller.dart';
import 'home.dart';
import 'login.dart';
import 'map.dart';
import 'events.dart';
import 'firebase_options.dart';
import 'settings.dart';

final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);
final firebaseDBProvider =
    Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print('User is signed in!');
    }
  });
  runApp(const ProviderScope(child: Main()));
}

class Main extends ConsumerWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(userControllerProvider);
    // ref.watch(orderControllerProvider);
    return MaterialApp(
      title: '第74回鯱光祭アプリ',
      theme: ThemeData(
          fontFamily: 'Noto Sans JP',
          visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme: const AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness:
                Brightness.light, // For Android (light icons)
            statusBarBrightness: Brightness.dark, // For iOS (light icons)
          )),
          primarySwatch: Colors.pink),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Noto Sans JP',
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness:Brightness.light, // For Android (light icons)
            statusBarBrightness: Brightness.dark, // For iOS (light icons)
        )),
        primarySwatch: Colors.grey,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => const LoginPage(),
        '/home': (BuildContext context) => HomePage(),
        '/map': (BuildContext context) => MapPage(),
        '/events': (BuildContext context) => EventsPage(),
        '/settings': (BuildContext context) => const SettingsPage(),
      },
    );
  }
}
