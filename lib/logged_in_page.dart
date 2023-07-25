import 'package:flutter/material.dart';

class LoggedInPage extends StatelessWidget {
  const LoggedInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text(
          "You logged in!",
          style: TextStyle(color: Colors.blueGrey, fontSize: 25),
        ),
      ),
    );
  }
}