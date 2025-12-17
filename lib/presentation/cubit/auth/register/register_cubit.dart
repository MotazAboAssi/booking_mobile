import 'package:booking/presentation/cubit/auth/register/register_state_cubit.dart';
import 'package:booking/services/http_request.dart';
import 'package:booking/types/user_register_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterStateCubit> {
  RegisterCubit() : super(InitialRegister());
  Future<void> register(Map<String, dynamic> registerData) async {
    emit(UnderRegistrationInRegister());
    try {
      final UserRegisterType user = UserRegisterType.fromJson(registerData);
      final Map<String, dynamic> data = await HttpRequest().register(user);
      emit(RegisterSuccessfuly(user: UserRegisterType.fromJson(data)));
    } catch (error) {
      emit(RegisterFailed(errorMessage: error.toString()));
    }
  }
}
