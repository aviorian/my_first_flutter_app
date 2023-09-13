import 'package:first_test/services/auth/auth_user.dart';

abstract class AuthProvider {

  //get currentUser
  AuthUser? get currentUser;
  //login
  Future<AuthUser> logIn({required email,required password});
  //register
  Future<AuthUser> register({required email,required password});
  //emailverification
  Future<void> sendEmailVerification();
}