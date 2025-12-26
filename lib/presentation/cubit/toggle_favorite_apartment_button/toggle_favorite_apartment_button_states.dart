class ToggleFavoriteApartmentButtonStates {
   bool isFavorite;
  final String? message;

  ToggleFavoriteApartmentButtonStates({required this.isFavorite, this.message});
}

class ToggleFavoriteApartmentButtonInitial
    extends ToggleFavoriteApartmentButtonStates {
  ToggleFavoriteApartmentButtonInitial({
    required super.isFavorite,
    super.message,
  });
}

class ToggleFavoriteApartmentButtonLoading
    extends ToggleFavoriteApartmentButtonStates {
  ToggleFavoriteApartmentButtonLoading({
    required super.isFavorite,
    super.message,
  });
}

class ToggleFavoriteApartmentButtonSuccessful
    extends ToggleFavoriteApartmentButtonStates {
  ToggleFavoriteApartmentButtonSuccessful({
    required super.isFavorite,
    super.message,
  });
}

class ToggleFavoriteApartmentButtonFaild
    extends ToggleFavoriteApartmentButtonStates {
  ToggleFavoriteApartmentButtonFaild({
    required super.isFavorite,
    super.message,
  });
}
