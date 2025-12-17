import 'package:booking/types/user_register_type.dart';

class RegisterStateCubit {}

class InitialRegister extends RegisterStateCubit {}

class UnderRegistrationInRegister extends RegisterStateCubit {}

class RegisterSuccessfuly extends RegisterStateCubit {
  final UserRegisterType user;
  RegisterSuccessfuly({required this.user});
}

class RegisterFailed extends RegisterStateCubit {
  final String errorMessage;
  RegisterFailed({required this.errorMessage});
}
