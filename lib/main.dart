import 'package:first_test/logged_in_view.dart';
import 'package:first_test/logged_out_view.dart';
import 'package:first_test/login_screen.dart';
import 'package:first_test/register_screen.dart';
import 'package:first_test/verify_email_view.dart';
import 'package:flutter/material.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
     MaterialApp(
      routes: {
        "/login/":(context) {
          return const LoginScreen();

        },
        "/register/":(context) {
          return  const RegisterScreen();
        },
        "/verify/":(context) {
          return const VerifyEmailView();
        },
        "/LoggedIn/":(context) {
          return const LoggedInView();
        },
        "/loggedout/":(context) {
          return const LoggedOutView();
        }

      },
      debugShowCheckedModeBanner: false,
      home: const RegisterScreen(),
    ),
  );
}


