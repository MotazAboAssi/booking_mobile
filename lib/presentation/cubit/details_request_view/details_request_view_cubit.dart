import 'package:booking/helper/test/print.dart';
import 'package:booking/presentation/cubit/details_request_view/details_request_view_states.dart';
import 'package:booking/services/http_request.dart';
import 'package:booking/types/apartment_type.dart';
import 'package:booking/types/user_register_type.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsRequestViewCubit extends Cubit<DetailsRequestViewStates> {
  DetailsRequestViewCubit()
    : super(
        DetailsRequestViewInitial(apartment: null, user: null, message: null),
      );
  Future<void> fetch(int idApartment, int idUser) async {
    try {
      emit(
        DetailsRequestViewLoading(
          apartment: state.apartment,
          user: state.user,
          message: state.message,
        ),
      );
      final ApartmentType apartment = await HttpRequest()
          .getApartmentByIDForLandlord(idApartment);
      final UserRegisterType user = await HttpRequest().fetchUserByID(idUser);
      emit(
        DetailsRequestViewSuccessful(
          apartment: apartment,
          user: user,
          message: null,
        ),
      );
    } on DioException catch (e) {
      printRed(e.type.name);
      if (e.type.name == 'connectionError') {
        emit(
          DetailsRequestViewFaild(
            apartment: state.apartment,
            user: state.user,
            message: 'No Internet 😢',
          ),
        );
      }
    } catch (e) {
      emit(
        DetailsRequestViewFaild(
          apartment: state.apartment,
          user: state.user,
          message: e.toString(),
        ),
      );
    }
  }
}
