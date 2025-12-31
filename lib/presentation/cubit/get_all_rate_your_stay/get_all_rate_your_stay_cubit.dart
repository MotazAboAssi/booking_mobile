import 'package:booking/presentation/cubit/get_all_rate_your_stay/get_all_rate_your_stay_states.dart';
import 'package:booking/services/http_request.dart';
import 'package:booking/types/rate_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetAllRateYourStayCubit extends Cubit<GetAllRateYourStayStates> {
  GetAllRateYourStayCubit()
    : super(GetAllRateYourStayInitial(rates: [], message: null));
  Future<void> getAllRateByID(int idApartment) async {
    try {
      emit(
        GetAllRateYourStayLoading(message: state.message, rates: state.rates),
      );
      final List<RateType> rates = await HttpRequest()
          .getAllRateForParticularApartmentByID(idApartment);
      emit(GetAllRateYourStaySuccessful(message: state.message, rates: rates));
    } catch (e) {
      emit(
        GetAllRateYourStayFaild(
          message: e.toString().replaceAll("Exception: ", ""),
          rates: [],
        ),
      );
    }
  }
}
