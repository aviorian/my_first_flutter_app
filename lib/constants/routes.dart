class Routes {

static const _loginRoute = "/login/";
static const _registerRoute = "/register/";
static const _verifyEmailRoute = "/verify/";
static const _loggedInRoute = "/loggedIn/";
static const _loggedOutRoute = "/loggedOut/";

//you could do it without class, with above code only. 

static String get getLoginRoute => _loginRoute; 
static String get getRegisterRoute => _registerRoute;
static String get getVerifyEmailRoute => _verifyEmailRoute;
static String get getLoggedInRoute => _loggedInRoute;
static String get getLoggedOutRoute => _loggedOutRoute;

//You dont need do write String explicitly.
}