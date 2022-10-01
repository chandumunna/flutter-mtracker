import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mtracker/home.dart';
import 'package:mtracker/login.dart';
import 'package:mtracker/widget/loading.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  void initState() {
    Firebase.initializeApp(
      options: FirebaseOptions.fromMap(const {
        "apiKey": "AIzaSyBOq8HJFYR8hoPcLIuxTPVEGKet3Y5LYBE",
        "authDomain": "mtracker-sanjay-rb.firebaseapp.com",
        "projectId": "mtracker-sanjay-rb",
        "storageBucket": "mtracker-sanjay-rb.appspot.com",
        "messagingSenderId": "169102308036",
        "appId": "1:169102308036:web:bd3615ea97dfce9e954f91",
        "measurementId": "G-PZZQPYWW22"
      }),
    ).then((value) {
      Navigator.pushReplacementNamed(context, HomeScreen.route);
      return value;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: LoadingWidget());
  }
}
