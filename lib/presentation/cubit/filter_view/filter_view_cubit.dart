import 'package:booking/helper/test/print.dart';
import 'package:booking/presentation/cubit/filter_view/filter_view_states.dart';
import 'package:booking/services/http_request.dart';
import 'package:booking/types/apartment_type.dart';
import 'package:booking/types/filter_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterViewCubit extends Cubit<FilterViewStates> {
  FilterViewCubit() : super(FilterViewInitial(resFilter: [], message: null));
  Future<void> filter(FilterType res) async {
    try {
      emit(
        FilterViewLoading(resFilter: state.resFilter, message: state.message),
      );
      List<ApartmentType> data = await HttpRequest().filterApartment(res);
      if (data.isEmpty) throw Exception("Not Found");
      emit(FilterViewSuccessful(resFilter: data, message: state.message));
    } catch (e) {
      emit(FilterViewFaild(resFilter: state.resFilter, message: e.toString()));
    }
  }
}
