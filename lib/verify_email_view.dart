import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_test/login_screen.dart';
import 'package:flutter/material.dart';

class VerifyEmailView extends StatelessWidget {
  const VerifyEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text(
            "Welcome to Fatih's Twitter!",
            style: TextStyle(color: Colors.blueGrey, fontSize: 25),
          ),
          const SizedBox(height: 30),
          const Text("You need to verify your email first to access the app."),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: () async {
                final User user = await FirebaseAuth.instance.currentUser!;
                if (!user.isAnonymous && !user.emailVerified) {
                  await user.sendEmailVerification();

                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return const LoginScreen();
                    },
                  ));
                }
              },
              child: const Text("Verify my Email")),
          const SizedBox(height: 10),
          const Text(
              "After verification, you will be directed into login page.")
        ]),
      ),
    );
  }
}
