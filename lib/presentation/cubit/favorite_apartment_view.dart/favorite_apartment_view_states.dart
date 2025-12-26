import 'package:booking/types/apartment_type.dart';

class FavoriteApartmentViewStates {
  final List<ApartmentType> favorites;

  FavoriteApartmentViewStates({required this.favorites});
}

class FavoriteApartmentViewInitial extends FavoriteApartmentViewStates {
  FavoriteApartmentViewInitial({required super.favorites});
}

class FavoriteApartmentViewLoading extends FavoriteApartmentViewStates {
  FavoriteApartmentViewLoading({required super.favorites});
}

class FavoriteApartmentViewSuccessful extends FavoriteApartmentViewStates {
  FavoriteApartmentViewSuccessful({required super.favorites});
}

class FavoriteApartmentViewFaild extends FavoriteApartmentViewStates {
  final String message;
  FavoriteApartmentViewFaild({required super.favorites, required this.message});
}
