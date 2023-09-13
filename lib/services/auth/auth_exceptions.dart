class UserNotLoggedInException implements Exception {
  final message = "User haven't logged in. Please try again. ";
}

class LogInException {
  final message;
  LogInException(this.message);
}

class RegisterException {
  final message;
  RegisterException(this.message);
}

class UserNotCreatedException {
  final message = "User has not created. Please try again.";
  
}
class EmailVerificationException {
  final message = "A problem occurred, Please sign in again.";
}

class GenericException {
  final message;
  GenericException(this.message);
}
