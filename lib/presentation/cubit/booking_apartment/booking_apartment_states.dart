class BookingApartmentStates {}

class BookingApartmentInitial extends BookingApartmentStates {}

class BookingApartmentLoading extends BookingApartmentStates {}

class BookingApartmentSuccessful extends BookingApartmentStates {
  String? response;

  BookingApartmentSuccessful({this.response});
}

class BookingApartmentFaild extends BookingApartmentStates {
  final String errorMessage;

  BookingApartmentFaild({required this.errorMessage});
}
