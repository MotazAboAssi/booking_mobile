import 'package:booking/presentation/cubit/landlord/confirm_book/confirm_book_states.dart';
import 'package:booking/services/http_request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmBookCubit extends Cubit<ConfirmBookStates> {
  ConfirmBookCubit() : super(ConfirmBookIntial());
  Future<void> confirm(int id, bool isAccept) async {
    try {
      emit(ConfirmBookLoading());
      final Map<String, dynamic> response = await HttpRequest().confirmBookingByID(id, isAccept);
      emit(ConfirmBookSuccessful(message: response['message']));
    } catch (e) {
      emit(ConfirmBookFaild(message: e.toString()));
    }
  }
}
