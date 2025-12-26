import 'package:booking/presentation/cubit/toggle_favorite_apartment_button/toggle_favorite_apartment_button_states.dart';
import 'package:booking/services/http_request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ToggleFavoriteApartmentButtonCubit
    extends Cubit<ToggleFavoriteApartmentButtonStates> {
  ToggleFavoriteApartmentButtonCubit()
    : super(ToggleFavoriteApartmentButtonInitial(isFavorite: false));
  Future<void> toggle(int id) async {
    try {
      emit(ToggleFavoriteApartmentButtonLoading(isFavorite: state.isFavorite));
      await HttpRequest().toggleFavoriteParticularApartmentByID(id);
      emit(
        ToggleFavoriteApartmentButtonSuccessful(isFavorite: !state.isFavorite),
      );
    } catch (e) {
      emit(
        ToggleFavoriteApartmentButtonFaild(
          message: e.toString().split("Exception: ")[1],
          isFavorite: state.isFavorite,
        ),
      );
    }
  }
}
