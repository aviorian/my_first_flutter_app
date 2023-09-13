import 'package:firebase_auth/firebase_auth.dart';

class AuthUser {

final isEmailVerified;

AuthUser(this.isEmailVerified);

factory AuthUser.fromFirebase(User user) {
  return AuthUser(user.emailVerified);
}
}