import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoggedInView extends StatelessWidget {
  const LoggedInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
      ),
      body:  Center(
        child: Column(children: [
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Welcome!",
            style: TextStyle(color: Colors.blueGrey, fontSize: 50),
          ),
          const Text(
            "There is no such a thing to do.",
            style: TextStyle(fontSize: 18, color: Colors.black54),
          ),
          ElevatedButton(onPressed: () async {
             
             final user = await FirebaseAuth.instance.currentUser!;
             print("${user.email}");

             if(!user.isAnonymous) {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushNamedAndRemoveUntil("/loggedout/", (route) => false);
             }

          }, child:const Text("Log Out") )
        ]),
      ),
    );
  }
}
