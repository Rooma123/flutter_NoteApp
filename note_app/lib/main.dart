// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:note_app/auth/login.dart';
import 'package:note_app/auth/signup.dart';
import 'package:note_app/cred/add.dart';
import 'package:note_app/home/homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import './home/catigory.dart';
import './home/update.dart';


Future<void> main() async {
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  
  @override
  void initState() {
    FirebaseAuth.instance
  .authStateChanges()
  .listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print('User is signed in!');
    }
  });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Note App',
      home:(FirebaseAuth.instance.currentUser!=null && FirebaseAuth.instance.currentUser!.emailVerified)
      ? Login() : Homepage(),

      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 32, 141, 125),
        buttonTheme: ButtonThemeData(
         buttonColor:  Color.fromARGB(255, 32, 141, 125),
        )
        
      ),
      
      
      routes: {
        "login":(context) => Login(),
        "signup":(context) =>Signup(),
        "homepage":(context) => Homepage(),
        "addnotes" : (context)  => AddNotes(),
        "catigory" : (context)  => Catigory(),
        
      },
    );
  }
}
