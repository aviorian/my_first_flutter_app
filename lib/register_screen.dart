import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'logged_in_page.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  int currentIndex = 0;
  late final TextEditingController _controllerMail;
  late final TextEditingController _controllerPassword;
  String? errorText;

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
                return ListView(
                  scrollDirection: Axis.vertical,
                  children: [ Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: Icon(FontAwesomeIcons.twitter,
                            size: 100, color: Colors.white),
                      ),
                      const SizedBox(height: 20),
                      const Text("Register",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          controller: _controllerMail,
                          autocorrect: false,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color.fromRGBO(255, 255, 255, 1),
                              errorStyle: const TextStyle(color: Colors.red),
                              errorText: errorText,
                              border: const OutlineInputBorder(),
                              hintText: "Enter your e-mail"),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          controller: _controllerPassword,
                          decoration: const InputDecoration(
                              filled: true,
                              fillColor: Color.fromRGBO(255, 255, 255, 1),
                              border: OutlineInputBorder(),
                              hintText: "Enter your password"),
                          obscureText: true,
                          autocorrect: false,
                        ),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () async {
                          final email = _controllerMail.text;
                          final password = _controllerPassword.text;
                
                          UserCredential userCredential = await FirebaseAuth
                              .instance
                              .createUserWithEmailAndPassword(
                                  email: email, password: password);
                
                          print(userCredential);
                          //List<String> mailTypes = ["gmail.com", "outlook.com"];
                
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                            return const LoggedInPage();
                          }));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(124, 202, 235, 1),
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
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return const LoginScreen();
                              },
                            ));
                          },
                          child: Text(
                            "Already has an account?",
                            style: TextStyle(color: Colors.grey.shade300),
                          ))
                    ],
                  ),]
                );
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