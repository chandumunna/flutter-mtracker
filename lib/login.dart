import 'package:flutter/material.dart';
import 'package:mtracker/home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _passCtrl = TextEditingController();
  String passcode = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(height: 25),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: TextFormField(
                controller: _passCtrl,
                style: Theme.of(context).textTheme.headline3,
                textAlign: TextAlign.center,
                showCursor: false,
                enabled: false,
                decoration: InputDecoration(
                  hintText: 'Passcode',
                  hintStyle: Theme.of(context).textTheme.headline3,
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  filled: true,
                  contentPadding: const EdgeInsets.all(16),
                  fillColor: Colors.grey.shade200,
                ),
              ),
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                3,
                (index) => InkWell(
                  onTap: () {
                    setState(() {
                      _passCtrl.text += ["1", "2", "3"][index];
                    });
                  },
                  onLongPress: () {
                    passcode += ["1", "2", "3"][index];
                  },
                  child: ClipOval(
                    child: Container(
                      color: Colors.grey,
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: 100,
                      child: Center(
                        child: Text(
                          ["1", "2", "3"][index],
                          style: Theme.of(context)
                              .textTheme
                              .headline3
                              ?.copyWith(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                3,
                (index) => InkWell(
                  onTap: () {
                    setState(() {
                      _passCtrl.text += ["4", "5", "6"][index];
                    });
                  },
                  onLongPress: () {
                    passcode += ["4", "5", "6"][index];
                  },
                  child: ClipOval(
                    child: Container(
                      color: Colors.grey,
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: 100,
                      child: Center(
                        child: Text(
                          ["4", "5", "6"][index],
                          style: Theme.of(context)
                              .textTheme
                              .headline3
                              ?.copyWith(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                3,
                (index) => InkWell(
                  onTap: () {
                    setState(() {
                      _passCtrl.text += ["7", "8", "9"][index];
                    });
                  },
                  onLongPress: () {
                    passcode += ["7", "8", "9"][index];
                  },
                  child: ClipOval(
                    child: Container(
                      color: Colors.grey,
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: 100,
                      child: Center(
                        child: Text(
                          ["7", "8", "9"][index],
                          style: Theme.of(context)
                              .textTheme
                              .headline3
                              ?.copyWith(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      _passCtrl.text += "0";
                    });
                  },
                  onLongPress: () {
                    passcode += "0";
                    if (passcode == "4720") {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    }
                  },
                  child: ClipOval(
                    child: Container(
                      color: Colors.grey,
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: 100,
                      child: Center(
                        child: Text(
                          "0",
                          style: Theme.of(context)
                              .textTheme
                              .headline3
                              ?.copyWith(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
