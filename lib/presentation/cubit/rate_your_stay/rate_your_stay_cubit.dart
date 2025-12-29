import 'package:booking/presentation/cubit/rate_your_stay/rate_your_stay_states.dart';
import 'package:booking/services/http_request.dart';
import 'package:booking/types/rate_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RateYourStayCubit extends Cubit<RateYourStayStates> {
  RateYourStayCubit()
    : super(
        RateYourStayInitial(
          pov: RateType(comment: null, rate: null),
          message: null,
        ),
      );
  Future<void> addRate(int idApartment, RateType povUser) async {
    try {
      emit(RateYourStayLoading(pov: state.pov, message: state.message));
      await HttpRequest().rateApartmentByID(idApartment, povUser);
      emit(RateYourStaySuccessful(pov: povUser, message: state.message));
    } catch (e) {
      emit(RateYourStayFaild(pov: state.pov, message: e.toString()));
    }
  }
}
