import 'package:booking/presentation/cubit/landlord/api_apartment/api_apartment_states.dart';
import 'package:booking/services/http_request.dart';
import 'package:booking/types/apartment_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApiApartmentCubit extends Cubit<ApiApartmentStates> {
  ApiApartmentCubit()
    : super(
        ApiApartmentInitial(
          apartment: ApartmentType.empty(),
          message: null,
          deleteImage: [],
        ),
      );

  Future<void> update(ApartmentType apartment, List<int> deleteImage) async {
    try {
      emit(
        ApiApartmentLoading(
          apartment: state.apartment,
          message: state.message,
          deleteImage: state.deleteImage,
        ),
      );
      await HttpRequest().updateApartmentForLandlord(apartment);
      emit(
        ApiApartmentSuccefulAdd(
          apartment: state.apartment,
          message: state.message,
          deleteImage:deleteImage,
        ),
      );
    } catch (e) {
      emit(
        ApiApartmentFaild(
          apartment: state.apartment,
          message: e.toString().replaceAll('Exception: ', ''),
          deleteImage: state.deleteImage,
        ),
      );
    }
  }

  Future<void> add(ApartmentType apartment) async {
    try {
      emit(
        ApiApartmentLoading(
          apartment: state.apartment,
          message: state.message,
          deleteImage: [],
        ),
      );
      await HttpRequest().addApartmentForLandlord(apartment);
      emit(
        ApiApartmentSuccefulAdd(
          apartment: state.apartment,
          message: state.message,
          deleteImage: state.deleteImage,
        ),
      );
    } catch (e) {
      emit(
        ApiApartmentFaild(
          apartment: state.apartment,
          message: e.toString().replaceAll('Exception: ', ''),
          deleteImage: [],
        ),
      );
    }
  }
}
