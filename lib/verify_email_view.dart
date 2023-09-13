import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_test/login_screen.dart';
import 'package:first_test/pop_ups.dart';
import 'package:first_test/services/auth/auth_exceptions.dart';
import 'package:first_test/services/firebase_auth_provider.dart';
import 'package:flutter/material.dart';

import 'constants/routes.dart';

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
                try {
                final provider = FirebaseAuthProvider();
                
                if (provider.currentUser != null) {
                  final user = provider.currentUser;
                  
                  await provider.sendEmailVerification();
                  await loginScreenErrorPopUp(context: context, error: "You can log in now.", sepByDash: false);
                  Navigator.of(context).pushNamedAndRemoveUntil(Routes.getLoginRoute, (route) => false);
                }
                }on UserNotLoggedInException catch(e) {
                  await loginScreenErrorPopUp(context: context, error: e.message, sepByDash: false);
                  Navigator.of(context).pushNamedAndRemoveUntil(Routes.getLoginRoute, (route) => false);
                }on EmailVerificationException catch (e) {
                  await loginScreenErrorPopUp(context: context, error: e.message, sepByDash: false);
                  Navigator.of(context).pushNamedAndRemoveUntil(Routes.getLoginRoute, (route) => false);
                }on GenericException catch (e) {
                  await loginScreenErrorPopUp(context: context, error: e.message, sepByDash: false);
                  Navigator.of(context).pushNamedAndRemoveUntil(Routes.getLoginRoute, (route) => false);
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
