import 'package:first_test/constants/routes.dart';
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
        Routes.getLoginRoute:(context) {
          return const LoginScreen();
        },
        Routes.getRegisterRoute:(context) {
          return  const RegisterScreen();
        },
        Routes.getVerifyEmailRoute:(context) {
          return const VerifyEmailView();
        },
        Routes.getLoggedInRoute:(context) {
          return const LoggedInView();
        },
        Routes.getLoggedOutRoute:(context) {
          return const LoggedOutView();
        }

      },
      debugShowCheckedModeBanner: false,
      home: const RegisterScreen(),
    ),
  );
}


