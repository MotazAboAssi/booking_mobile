import 'package:booking/presentation/cubit/auth/auth_state_cubit.dart';
import 'package:booking/types/user_register_type.dart';

class UnderRegistrationInRegister extends AuthStateCubit {}

class RegisterSuccessfuly extends AuthStateCubit {
  final UserRegisterType user;

  RegisterSuccessfuly({required this.user});
}

class RegisterFailed extends AuthStateCubit {
  final String errorMessage;

  RegisterFailed({required this.errorMessage});
}
