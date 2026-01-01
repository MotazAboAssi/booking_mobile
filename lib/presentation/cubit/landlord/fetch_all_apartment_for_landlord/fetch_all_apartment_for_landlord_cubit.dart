import 'package:booking/presentation/cubit/landlord/fetch_all_apartment_for_landlord/fetch_all_apartment_for_landlord_states.dart';
import 'package:booking/services/http_request.dart';
import 'package:booking/types/apartment_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FetchAllApartmentForLandlordCubit
    extends Cubit<FetchAllApartmentForLandlordStates> {
  FetchAllApartmentForLandlordCubit()
    : super(FetchAllApartmentForLandlordInitial(apartments: [], message: null));
  Future<void> fetchAllApartmentForLandlord() async {
    try {
      emit(
        FetchAllApartmentForLandlordLoading(
          apartments: state.apartments,
          message: state.message,
        ),
      );
      final List<ApartmentType> apartments = await HttpRequest()
          .getAllApartmentForLandLord();
      emit(
        FetchAllApartmentForLandlordSuccessful(
          apartments: apartments,
          message: state.message,
        ),
      );
    } catch (e) {
      emit(
        FetchAllApartmentForLandlordFaild(
          apartments: state.apartments,
          message: e.toString().replaceAll('Exception: ', ''),
        ),
      );
    }
  }
}
