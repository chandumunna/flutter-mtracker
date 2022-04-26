import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mtracker/login.dart';
import 'package:mtracker/widget/error.dart';
import 'package:mtracker/widget/loading.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp(
    options: FirebaseOptions.fromMap(const {
      "apiKey": "AIzaSyBOq8HJFYR8hoPcLIuxTPVEGKet3Y5LYBE",
      "authDomain": "mtracker-sanjay-rb.firebaseapp.com",
      "projectId": "mtracker-sanjay-rb",
      "storageBucket": "mtracker-sanjay-rb.appspot.com",
      "messagingSenderId": "169102308036",
      "appId": "1:169102308036:web:bd3615ea97dfce9e954f91",
      "measurementId": "G-PZZQPYWW22"
    }),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '₹Tracker',
      theme: ThemeData(
        textTheme: GoogleFonts.catamaranTextTheme(Theme.of(context).textTheme),
      ),
      home: Scaffold(
        body: FutureBuilder(
          future: _initialization,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingWidget();
            } else {
              return snapshot.hasError
                  ? const ErrorDetailWidget("Firebase Not Connected")
                  : const LoginScreen();
            }
          },
        ),
      ),
    );
  }
}
