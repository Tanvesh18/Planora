
import 'package:authenticationprac/signinpage.dart';
import 'package:authenticationprac/tasksonly/task.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
const apiKey = 'AIzaSyCQWl1J9osgNdcbNK4chiLq_MuGFWnKGuE';
void main() async {
  Gemini.init(apiKey: apiKey);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/tasks',
      routes: {
        '/signin': (context) => Signinpage(),
        '/tasks': (context) => Task(),
      },
    );
  }
}
