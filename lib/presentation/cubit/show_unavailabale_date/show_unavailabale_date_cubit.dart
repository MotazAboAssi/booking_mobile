import 'package:booking/presentation/cubit/show_unavailabale_date/show_unavailabale_date_states.dart';
import 'package:booking/services/http_request.dart';
import 'package:booking/types/range_unavailable_date.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowUnavailabaleDateCubit extends Cubit<ShowUnavailabaleDateStates> {
  ShowUnavailabaleDateCubit() : super(ShowUnavailabaleDateInitial());
  Future<void> showUnavailableDate({required int apartmentId}) async {
    try {
      emit(ShowUnavailabaleDateLoading());
      final List<RangeUnavailableDate> dates = await HttpRequest()
          .displayUnavailableDateForParticularApartment(apartmentId);
      emit(ShowUnavailabaleDateSuccessful(dates));
    } catch (e) {
      emit(ShowUnavailabaleDateFailed(e.toString()));
    }
  }
}
