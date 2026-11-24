import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'sign_in.dart';
import 'rejester.dart';
import 'first.dart';
import 'second.dart';
import 'theird.dart'; 
import 'home.dart';
import 'pages/new.dart'; 
import 'pages/sequance.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override 
  createState() => _MyAppState();   
} 

class _MyAppState extends State<MyApp> {
  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NotesFlow', 
      theme: ThemeData(primarySwatch: Colors.blue),
      home:
          (FirebaseAuth.instance.currentUser != null &&
              FirebaseAuth.instance.currentUser!.emailVerified)
          ? SequancePage()
          : FirstPage(),  
      routes: { 
        'sign_in': (context) => SignInPage(),
        'rejester': (context) => RejesterPage(),
        'first': (context) => FirstPage(),
        'second': (context) => SecondPage(),
        'third': (context) => ThirdPage(),
        'home': (context) => HomePage(),
        'Add': (context) => Create(),
        'sequance': (context) => SequancePage(),
      },
    );
  }
}
