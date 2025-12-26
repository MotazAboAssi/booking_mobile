import 'package:booking/helper/test/print.dart';
import 'package:booking/presentation/cubit/fetch_user/fetch_user_states.dart';
import 'package:booking/services/http_request.dart';
import 'package:booking/types/user_register_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FetchUserCubit extends Cubit<FetchUserStates> {
  FetchUserCubit() : super(FetchUserInitial());
  Future<void> userByID(int id) async {
    try {
      emit(FetchUserLoading());
      UserRegisterType user = await HttpRequest().fetchUserByID(id);
      emit(FetchUserSuccessful(user));
    } catch (e) {
      printRed(e.toString());
      emit(FetchUserFaild(e.toString()));
    }
  }
}
