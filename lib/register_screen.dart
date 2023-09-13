import 'package:firebase_core/firebase_core.dart';
import 'package:first_test/pop_ups.dart';
import 'package:first_test/services/auth/auth_exceptions.dart';
import 'package:first_test/services/firebase_auth_provider.dart';
import 'constants/routes.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'verify_email_view.dart';
import 'login_screen.dart';
import "package:first_test/services/auth/auth_provider.dart";
import "package:first_test/services/auth/auth_user.dart";

import "dart:developer" as devtools show log;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Twitter"),
          centerTitle: true,
          backgroundColor: const Color.fromRGBO(29, 161, 242, 1),
          foregroundColor: const Color.fromARGB(255, 255, 255, 255),
        ),
        backgroundColor: const Color.fromRGBO(29, 161, 242, 1),
        // bottomNavigationBar: BottomNavigationBar(
        //   items: const [
        //     BottomNavigationBarItem(
        //         icon: Icon(Icons.account_circle), label: "Log in"),
        //     BottomNavigationBarItem(
        //         icon: Icon(
        //           Icons.fiber_new,
        //         ),
        //         label: "Sign Up")
        //   ],
        //   currentIndex: currentIndex,
        //   onTap: (int index) {
        //     setState(() {
        //       currentIndex = index;
        //     });
        //   },
        //   backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        //   selectedItemColor: const Color.fromRGBO(29, 161, 242, 1),
        // ),
        body: FutureBuilder(
          future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          ),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return const RegisterScreenView();
              default:
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LoadingAnimationWidget.inkDrop(
                        color: Colors.white, size: 40),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "Loading...",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ));
            }
          },
        )
        // Container(
        //    // there will be sign up screen
        //    ),
        );
  }
}

class RegisterScreenView extends StatefulWidget {
  const RegisterScreenView({super.key});

  @override
  State<RegisterScreenView> createState() => _RegisterScreenViewState();
}

class _RegisterScreenViewState extends State<RegisterScreenView> {
  late final _controllerMail;
  late final _controllerPassword;

  @override
  void initState() {
    _controllerMail = TextEditingController();
    _controllerPassword = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controllerMail.dispose;
    _controllerPassword.dispose;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(scrollDirection: Axis.vertical, children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 50),
            child:
                Icon(FontAwesomeIcons.twitter, size: 100, color: Colors.white),
          ),
          const SizedBox(height: 20),
          const Text("Register",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: _controllerMail,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration:  InputDecoration(
                  filled: true,
                  fillColor:const Color.fromRGBO(255, 255, 255, 1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: "Enter your email",
              )
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: _controllerPassword,
              decoration:  InputDecoration(
                  filled: true,
                  fillColor:const Color.fromRGBO(255, 255, 255, 1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: "Enter your password",
              ),
              obscureText: true,
              autocorrect: false,
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () async {
              final email = _controllerMail.text;
              final password = _controllerPassword.text;

              try {
                final provider = FirebaseAuthProvider();
                await provider.register(email: email, password: password);

                Navigator.of(context).pushNamedAndRemoveUntil(Routes.getVerifyEmailRoute, (route) => false);
                
              } on UserNotCreatedException catch(e) {
                loginScreenErrorPopUp(context: context, error: e.message, sepByDash: false);
              }on RegisterException catch(e) {
                loginScreenErrorPopUp(context: context, error: e.message, sepByDash: true);
              }on GenericException catch(e) {
                loginScreenErrorPopUp(context: context, error: e.toString(), sepByDash: false);
              }

              //List<String> mailTypes = ["gmail.com", "outlook.com"];

              
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(124, 202, 235, 1),
                shadowColor: Colors.black,
                elevation: 3,
                fixedSize: const Size(170, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12))),
            child: const Text("Register",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(Routes.getLoginRoute, (route) => false);
              
              },
              child: Text(
                "Already has an account?",
                style: TextStyle(color: Colors.grey.shade300),
              ))
        ],
      ),
    ]);
  }
}
