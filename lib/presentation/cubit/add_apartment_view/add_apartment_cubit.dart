import 'package:booking/presentation/cubit/add_apartment_view/add_apartment_states.dart';
import 'package:booking/services/http_request.dart';
import 'package:booking/types/apartment_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddApartmentCubit extends Cubit<AddApartmentStates> {
  AddApartmentCubit() : super(InitialAddApartment());
  Future<void> addApartmrnt(ApartmentType apartment) async {
    try {
      emit(AddApartmentLoading());
      await HttpRequest().addApartmentForLandlord(apartment);
      emit(AddApartmentSuccessful());
    } catch (e) {
      throw Exception(e);
    }
  }
}
