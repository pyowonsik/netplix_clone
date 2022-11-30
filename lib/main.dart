import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:netplix_clone/firebase_options.dart';
import 'package:netplix_clone/screen/home_screen.dart';
import 'package:netplix_clone/screen/like_screen.dart';
import 'package:netplix_clone/screen/more_screen.dart';
import 'package:netplix_clone/screen/search_screen.dart';
import 'package:netplix_clone/widget/bottom_bar.dart';

// void main() => runApp(MyApp());

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    TabController controller;
    return MaterialApp(
      title: 'SikFlix',
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.black,
          accentColor: Colors.white),
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              HomeScreen(),
              SearchScreen(),
              LikeScreen(),
              MoreScreen(),
            ],
          ),
          bottomNavigationBar: Bottom(),
        ),
      ),
    );
  }
}
