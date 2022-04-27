import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mtracker/routes/route.dart';

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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '₹Tracker',
      theme: ThemeData(
        textTheme: GoogleFonts.catamaranTextTheme(Theme.of(context).textTheme),
      ),
      initialRoute: RouteGenerator.initRoute,
      onGenerateRoute: RouteGenerator().generateRoute,
    );
  }
}
