import 'package:booking/types/user_register_type.dart';

class LoginStateCubit {}

class InitialLogIn extends LoginStateCubit {}

class UnderRegistrationLogIn extends LoginStateCubit {}

class LoginSuccessfuly extends LoginStateCubit {
  final UserRegisterType user;

  LoginSuccessfuly({required this.user});
}

class LoginFailed extends LoginStateCubit {
  final String errorMessage;

  LoginFailed({required this.errorMessage});
}
