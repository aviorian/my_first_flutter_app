import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_test/services/auth/auth_provider.dart';
import 'package:first_test/services/auth/auth_user.dart';
import 'package:first_test/services/auth/auth_exceptions.dart';

class FirebaseAuthProvider extends AuthProvider {
  @override
  AuthUser? get currentUser {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      return AuthUser.fromFirebase(user);
    } else {
      return null;
    }
  }

  @override
  Future<AuthUser> logIn({required email, required password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        return AuthUser(user);
      } else {
        throw UserNotLoggedInException();
      }
    } on FirebaseAuthException catch (e) {
      throw LogInException(e.code);
    } catch (e) {
      throw GenericException(e.toString());
    }
  }

  @override
  Future<AuthUser> register({required email, required password}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        return AuthUser.fromFirebase(user);
      } else {
        throw UserNotCreatedException();
      }
    } on FirebaseAuthException catch (e) {
      throw RegisterException(e.code);
    } catch (e) {
      throw GenericException(e.toString());
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await user.sendEmailVerification();
      } else {
        throw EmailVerificationException();
      }
    } catch (e) {
      throw GenericException(e.toString());
    }
  }
}
