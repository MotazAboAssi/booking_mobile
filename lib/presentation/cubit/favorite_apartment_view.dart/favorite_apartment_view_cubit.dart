import 'package:booking/presentation/cubit/favorite_apartment_view.dart/favorite_apartment_view_states.dart';
import 'package:booking/services/http_request.dart';
import 'package:booking/types/apartment_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteApartmentViewCubit extends Cubit<FavoriteApartmentViewStates> {
  FavoriteApartmentViewCubit()
    : super(FavoriteApartmentViewInitial(favorites: []));
  Future<void> getAllFavoriteApartment() async {
    try {
      emit(FavoriteApartmentViewLoading(favorites: state.favorites));
      List<ApartmentType> response = await HttpRequest()
          .getFavoriteApartments();
      emit(FavoriteApartmentViewSuccessful(favorites: response));
    } catch (e) {
      emit(FavoriteApartmentViewFaild(favorites: [], message: e.toString()));
    }
  }
}
