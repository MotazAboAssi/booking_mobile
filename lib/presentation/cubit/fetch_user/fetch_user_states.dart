import 'package:booking/types/user_register_type.dart';

class FetchUserStates {
  final UserRegisterType? user;
  final String? errorMessage;

  FetchUserStates({required this.user, this.errorMessage});
}

class FetchUserInitial extends FetchUserStates {
  FetchUserInitial() : super(user: null, errorMessage: null);
}

class FetchUserLoading extends FetchUserStates {
  FetchUserLoading() : super(user: null, errorMessage: null);
}

class FetchUserSuccessful extends FetchUserStates {
  FetchUserSuccessful(UserRegisterType user)
    : super(user: user, errorMessage: null);
}

class FetchUserFaild extends FetchUserStates {
  final String? error;
  FetchUserFaild(this.error) : super(user: null, errorMessage: error);
}
