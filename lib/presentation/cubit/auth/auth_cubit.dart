import 'dart:math';

import 'package:booking/presentation/cubit/auth/auth_state_cubit.dart';
import 'package:booking/presentation/cubit/auth/login/login_state_cubit.dart';
import 'package:booking/services/http_request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthStateCubit> {
  AuthCubit() : super(InitialAuth());

  Future<void> register(Map<String, dynamic> user) async {
    // emit(UnderRegistrationInRegister());
    // try {
    //   await FirebaseAuth.instance.createUserWithEmailAndPassword(
    //     email: user["email"],
    //     password: user["password"],
    //   );
    //   emit(
    //     RegisterSuccessfuly(
    //       user: RegisterType(
    //         userName: user["user name"],
    //         email: user["email"],
    //         password: user["password"],
    //       ),
    //     ),
    //   );
    // } on FirebaseAuthException catch (error) {
    //   log(error.toString());
    //   emit(RegisterFailed(errorMessage: "No Internet"));
    // } catch (e) {
    //   emit(RegisterFailed(errorMessage: "No Internet"));
    // }
    // // throw Exception(error.toString());
  }
}
