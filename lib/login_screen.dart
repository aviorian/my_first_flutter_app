import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import 'verify_email_view.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
    _controllerMail.dispose();
    _controllerPassword.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(29, 161, 242, 1),
      appBar: AppBar(
        title: const Text("Twitter"),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(29, 161, 242, 1),
        foregroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: ListView(scrollDirection: Axis.vertical, children: [
        Center(
          child: Column(
            children: [
              const SizedBox(height: 50),
              const Icon(
                FontAwesomeIcons.twitter,
                color: Colors.white,
                size: 100,
              ),
              const SizedBox(height: 20),
              const Text(
                "Login",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: _controllerMail,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: "Enter your email",
                  ),
                  autocorrect: false,
                  enableSuggestions: false,
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: _controllerPassword,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: "Enter your password",
                  ),
                  autocorrect: false,
                  enableSuggestions: false,
                  obscureText: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 200,
                ),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Forgot your password?",
                    style: TextStyle(color: Colors.grey.shade300),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () async {
                  String email = _controllerMail.text;
                  String password = _controllerPassword.text;
                  String exceptionMessage = "";
                  try {
                    UserCredential userCredential = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: email, password: password);
                    print(userCredential);

                    final user = FirebaseAuth.instance.currentUser!;
                    print(user);

                    if (!user.emailVerified) {
                      Navigator.of(context).pushNamedAndRemoveUntil("/verify/", (route) => true);
                    } else {
                      Navigator.of(context).pushNamedAndRemoveUntil("/LoggedIn/", (route) => false);
                      
                    }
                  } on FirebaseAuthException catch (e) {
                    print(e.code);
                    exceptionMessage = e.code;

                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return Scaffold(
                          appBar: AppBar(),
                          body: Center(child: Text(exceptionMessage)),
                        );
                      },
                    ));
                  }
                  //      Navigator.push(context, MaterialPageRoute(
                  //        builder: (context) {
                  //          return Scaffold(
                  //            appBar: AppBar(),
                  //          );
                  //        },
                  //      ));
                },
                child: Container(
                  width: 170,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color.fromRGBO(124, 202, 235, 1),
                  ),
                  child: const Center(
                    child: Text("Login",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        "/register/", (route) => false);
                  },
                  style: ButtonStyle(foregroundColor:MaterialStatePropertyAll(Colors.grey.shade300) ),
                  child: const Text("Don't have account yet?"))
            ],
          ),
        ),
      ]),
    );
  }
}
