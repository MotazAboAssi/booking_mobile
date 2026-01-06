import 'package:booking/helper/test/print.dart';
import 'package:booking/presentation/cubit/auth/register/register_state_cubit.dart';
import 'package:booking/services/http_request.dart';
import 'package:booking/types/user_register_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterStateCubit> {
  RegisterCubit() : super(InitialRegister());
  Future<void> register(UserRegisterType user) async {
    emit(UnderRegistrationInRegister());
    try {
      final Map<String, dynamic> response = await HttpRequest().register(user);
      printGreen(response.toString());
      emit(
        RegisterSuccessfuly(
          user: UserRegisterType.fromJson(response["data"]['0']),
        ),
      );
    } catch (error) {
      emit(RegisterFailed(errorMessage: error.toString().split(":")[1]));
      throw Exception(error);
    }
  }
}
