import 'package:booking/presentation/cubit/auth/login/login_state_cubit.dart';
import 'package:booking/services/http_request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginStateCubit> {
  LoginCubit() : super(InitialLogIn());

  Future<void> login(Map<String, dynamic> loginData) async {
    emit(UnderRegistrationLogIn());
    try {
      emit(LoginSuccessfuly(user: await HttpRequest().login(loginData)));
    } catch (error) {
      emit(LoginFailed(errorMessage: error.toString()));
    }
  }
}
